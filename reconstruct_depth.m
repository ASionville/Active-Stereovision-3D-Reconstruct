function depth_map = reconstruct_depth(obj_imgs, ref_imgs, fringe_period, projector_angle, unwrap_method, fringe_px_to_cm, save_dir)
% Function to reconstruct the depth map and save the results
% Inputs:
%   obj_imgs : Images with object (H x W x N)
%   ref_imgs : Images without object (H x W x N)
%   fringe_period : Fringe period
%   projector_angle : Projector angle (in degrees)
%   unwrap_method : 'unwrap' (classic) or 'ghiglia'
%   fringe_px_to_cm : fringe period (in px) to cm ratio (optional)
%   save_dir : save directory (optional)
% Output:
%   depth_map : Reconstructed depth map (in pixels or cm if fringe_px_to_cm provided)

[H, W, N] = size(obj_imgs);
psi = 2 * pi * (0:N-1) / N; % Phase shifts calculation

% Phase reconstruction for images with object
numerator_obj = zeros(H, W);
denominator_obj = zeros(H, W);
for n = 1:N
    numerator_obj = numerator_obj + obj_imgs(:, :, n) * sin(psi(n));
    denominator_obj = denominator_obj + obj_imgs(:, :, n) * cos(psi(n));
end
phi_obj = atan2(numerator_obj, denominator_obj); % Reconstructed phase with object

% Phase reconstruction for images without object
numerator_ref = zeros(H, W);
denominator_ref = zeros(H, W);
for n = 1:N
    numerator_ref = numerator_ref + ref_imgs(:, :, n) * sin(psi(n));
    denominator_ref = denominator_ref + ref_imgs(:, :, n) * cos(psi(n));
end
phi_ref = atan2(numerator_ref, denominator_ref); % Reconstructed phase without object

% Phase unwrapping according to the chosen method
if nargin < 5
    unwrap_method = 'unwrap';
end

switch lower(unwrap_method)
    case 'unwrap'
        phi_obj_unwrapped = unwrap(phi_obj);
        phi_ref_unwrapped = unwrap(phi_ref);
    case 'ghiglia'
        phi_obj_unwrapped = phase_unwrap_Ghiglia(phi_obj);
        phi_ref_unwrapped = phase_unwrap_Ghiglia(phi_ref);
    otherwise
        error('Unknown unwrapping method: %s', unwrap_method);
end

% Phase difference
phi_diff = phi_obj_unwrapped - phi_ref_unwrapped;

% Depth map estimation in pixels
depth_map_px = (phi_diff * fringe_period) / (2 * pi * tand(projector_angle));

% Conversion to cm if ratio is provided
if nargin >= 6 && ~isempty(fringe_px_to_cm)
    depth_map_cm = (phi_diff * fringe_px_to_cm) / (2 * pi * tand(projector_angle));

    % Correction of negative values (usually errors)
    depth_map_corrected = depth_map_cm;
    depth_map_corrected(depth_map_corrected < 0) = 0;
else
    depth_map_cm = [];
end

% Save results if a directory is provided
if nargin >= 7 && ~isempty(save_dir)
    if ~exist(save_dir, 'dir')
        mkdir(save_dir);
    end
    % Save images
    to_save = { ...
        {'phi_obj', phi_obj}, ...
        {'phi_ref', phi_ref}, ...
        {'phi_diff', phi_diff}, ...
        {'depth_map_px', depth_map_px} ...
    };
    if ~isempty(depth_map_cm)
        to_save{end+1} = {'depth_map_cm', depth_map_cm};
        to_save{end+1} = {'depth_map_corrected', depth_map_corrected};
    end
    for k = 1:numel(to_save)
        name = to_save{k}{1};
        data = to_save{k}{2};
        % Image with colormap and colorbar
        fig = figure('Visible','off');
        imagesc(data);
        axis image; axis off;
        colormap(gray);
        colorbar; 
        exportgraphics(gca, fullfile(save_dir, [name '_' lower(unwrap_method) '.png']));
        close(fig);
    end
end

% Return the map in cm if possible, otherwise in px
if ~isempty(depth_map_cm)
    depth_map = depth_map_cm;
else
    depth_map = depth_map_px;
end
end
