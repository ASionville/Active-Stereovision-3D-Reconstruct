% Configuration file for Active-Stereovision-3D-Reconstruct

fringe_period = 16;           % Fringe period (pixels)
projector_angle = 4.572;      % Projector-camera angle (degrees)
N = 4;                        % Number of phase-shifted images

% Cropping parameters
crop_x1 = 87;                 % Crop start column
crop_x2 = 1183;               % Crop end column
crop_y1 = 1;                  % Crop start row
crop_y2 = 964;                % Crop end row

% Image size
img_width = 1296;             % Image width (pixels)
img_height = 964;             % Image height (pixels)

% Fringe period (in px) to cm ratio
fringe_px_to_cm = 0.42;       % 10 fringes of 16 px = 4.2cm

% Directories
results_dir = 'YOUR_RESULTS_DIRECTORY/';  % Root results directory
images_dir = 'YOUR_IMAGES_DIRECTORY/';      % Data/images directory

% List of object names to process (cell array of strings)
object_names = {'object1', 'object2'}; % <-- Edit with your object names

% Display Ghiglia depth map (true/false)
display = true;

save('config.mat');
