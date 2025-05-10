clc; clear all; close all;

% Parameters
fringe_period = 16; % Fringe period
projector_angle = 4.572; % Projector angle (degrees)
N = 4; % Number of acquisitions

% Crop parameters
x1 = 87;
x2 = 1183;

% Fringe period (in px) to cm ratio
fringe_px_to_cm = 0.42; % 10 fringes of 16 px = 4.2cm

% Save directory
save_dir = 'YOUR_RESULTS_PATH/'; % <-- replace with your results directory
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

% Load images
ref_imgs = zeros(964, 1296, N); % Images without object
obj_imgs = zeros(964, 1296, N); % Images with object

for n = 1:N
    ref_imgs(:, :, n) = double(imread(['YOUR_DATA_PATH/background_' num2str(n) '.png'])) / 255; % <-- replace with your background images path
    obj_imgs(:, :, n) = double(imread(['YOUR_DATA_PATH/object_' num2str(n) '.png'])) / 255; % <-- replace with your object images path
end

% Crop images
obj_imgs_crop = obj_imgs(:, x1:x2, :);
ref_imgs_crop = ref_imgs(:, x1:x2, :);

% Save cropped images
for n = 1:N
    imwrite(obj_imgs_crop(:, :, n), fullfile(save_dir, sprintf('obj_img_crop_%d.png', n)));
    imwrite(ref_imgs_crop(:, :, n), fullfile(save_dir, sprintf('ref_img_crop_%d.png', n)));
end

% Depth map reconstruction and save results
reconstruct_depth(obj_imgs_crop, ref_imgs_crop, fringe_period, projector_angle, 'unwrap', fringe_px_to_cm, save_dir);
reconstruct_depth(obj_imgs_crop, ref_imgs_crop, fringe_period, projector_angle, 'ghiglia', fringe_px_to_cm, save_dir);

% Display depth maps
depth_map_unwrap = imread(fullfile(save_dir, 'depth_map_cm_unwrap.png'));
depth_map_ghiglia = imread(fullfile(save_dir, 'depth_map_cm_ghiglia.png'));
% figure; imshow(depth_map_unwrap, []); title('Estimated depth map (classic unwrap, cm)');
% figure; imshow(depth_map_ghiglia, []); title('Estimated depth map (Ghiglia, cm)');
