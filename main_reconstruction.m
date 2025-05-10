clc; clear all; close all;

% Run configuration script to generate/update config.mat
run('config.m');

% Load configuration
config = load('config.mat');

% Parameters from config
fringe_period = config.fringe_period;
projector_angle = config.projector_angle;
N = config.N;
x1 = config.crop_x1;
x2 = config.crop_x2;
y1 = config.crop_y1;
y2 = config.crop_y2;
img_height = config.img_height;
img_width = config.img_width;
fringe_px_to_cm = config.fringe_px_to_cm;
results_dir = config.results_dir;
images_dir = config.images_dir;
object_names = config.object_names;
display = config.display;

% Load background images (shared for all objects with same fringe_period)
ref_imgs = zeros(img_height, img_width, N);
for n = 1:N
    ref_imgs(:, :, n) = double(imread(fullfile(images_dir, ...
        sprintf('fond_%d_%d.png', fringe_period, n)))) / 255;
end
ref_imgs_crop = ref_imgs(y1:y2, x1:x2, :);

% Process each object
for obj_idx = 1:numel(object_names)
    object_name = object_names{obj_idx};
    % Output directory for this object
    obj_results_dir = fullfile(results_dir, num2str(fringe_period), object_name);
    if ~exist(obj_results_dir, 'dir')
        mkdir(obj_results_dir);
    end

    % Load object images
    obj_imgs = zeros(img_height, img_width, N);
    for n = 1:N
        obj_imgs(:, :, n) = double(imread(fullfile(images_dir, ...
            sprintf('%s_%d_%d.png', object_name, fringe_period, n)))) / 255;
    end
    obj_imgs_crop = obj_imgs(y1:y2, x1:x2, :);

    % Save cropped images
    for n = 1:N
        imwrite(obj_imgs_crop(:, :, n), fullfile(obj_results_dir, sprintf('obj_img_crop_%d.png', n)));
        if obj_idx == 1 % Save cropped background only once (for first object)
            imwrite(ref_imgs_crop(:, :, n), fullfile(obj_results_dir, sprintf('ref_img_crop_%d.png', n)));
        end
    end

    % Depth map reconstruction and save results
    reconstruct_depth(obj_imgs_crop, ref_imgs_crop, fringe_period, projector_angle, 'unwrap', fringe_px_to_cm, obj_results_dir);
    reconstruct_depth(obj_imgs_crop, ref_imgs_crop, fringe_period, projector_angle, 'ghiglia', fringe_px_to_cm, obj_results_dir);

    % Display depth maps (optional)
    if display
        depth_map_ghiglia = imread(fullfile(obj_results_dir, 'depth_map_cm_ghiglia.png'));
        figure; imshow(depth_map_ghiglia, []); title(['Estimated depth map (Ghiglia, cm) - ' object_name]);
    end
end
