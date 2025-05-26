# Active-Stereovision-3D-Reconstruct

# Authors
- Sophie RUMEAU
- Aubin SIONVILLE

## Project Purpose

This project was developed as part of the "3D Imaging" course at Télécom Saint-Étienne.
The goal is to reconstruct the 3D shape of an object using active stereovision techniques. The project implements a method for phase unwrapping and depth map reconstruction from a series of images captured with projected fringes.
The method is based on the principles of active stereovision, where a known pattern (fringes) is projected onto the object, and the resulting images are captured from different angles. The phase information from these images is then used to reconstruct the depth map of the object.

## Features

The project allows you to:
- Load images of an object and a background with projected fringes at different phase shifts.
- Crop and save the images.
- Reconstruct the object's depth map from the acquired images, using different phase unwrapping methods (classic unwrap or Ghiglia's method).
- Save and visualize the results (phase maps, depth map).
- Process multiple objects automatically, with a single background set per fringe period.
- Automatically display or not the Ghiglia depth map according to a configuration parameter.

## Configuration

All parameters are now set in the `config.m` file.  
To change parameters (such as cropping, image size, number of images, directories, object names, or display options), edit and save the `config.m` script.  
When you run `main_reconstruction.m`, the configuration is automatically updated by running `config.m` before loading the parameters.

**Key parameters in `config.m`:**

- **fringe_period**  
    *Usage:* Sets the fringe period in pixels for the projected pattern.  
    *Default value:* `16`

- **projector_angle**  
    *Usage:* Angle (in degrees) between the projector and camera.  
    *Default value:* `4.572`

- **N**  
    *Usage:* Number of phase-shifted images to process.  
    *Default value:* `4`

- **crop_x1, crop_x2, crop_y1, crop_y2**  
    *Usage:* Define the cropping rectangle for the images (pixel coordinates).  
    *Default values:* `crop_x1 = 87`, `crop_x2 = 1183`, `crop_y1 = 1`, `crop_y2 = 964`

- **img_width, img_height**  
    *Usage:* Set the width and height of the images (in pixels).  
    *Default values:* `img_width = 1296`, `img_height = 964`

- **fringe_px_to_cm**  
    *Usage:* Conversion ratio from fringe period in pixels to centimeters.  
    *Default value:* `0.42`

- **results_dir**  
    *Usage:* Path to the root directory where results will be saved.  
    *Default value:* `'YOUR_RESULTS_DIRECTORY/'`

- **images_dir**  
    *Usage:* Path to the directory containing input images.  
    *Default value:* `'YOUR_IMAGES_DIRECTORY/'`

- **object_names**  
    *Usage:* List of object names (cell array of strings) to process.  
    *Default value:* `{'object1', 'object2'}`

- **display**  
    *Usage:* Whether to display the Ghiglia depth map (`true` or `false`).  
    *Default value:* `true`

**Edit these values as needed, then run `main_reconstruction.m`. The configuration will be updated automatically.**
**Edit these values as needed, then run `main_reconstruction.m`. The configuration will be updated automatically.**

### File Naming Convention

- Background images (without object) must be named:  
  `fond_{fringe_period}_{n}.png` (e.g., `fond_16_1.png`, `fond_16_2.png`, ...)
- Object images must be named:  
  `{object_name}_{fringe_period}_{n}.png` (e.g., `cube_16_1.png`, `sphere_16_2.png`, ...)

### Output Organization

Results for each object are saved in:  
`{results_dir}/{fringe_period}/{object_name}/`

This includes cropped images, phase maps, and depth maps for each object.

## Usage

1. **Prepare your data**  
   Place your images in the folder specified by `images_dir` and name them according to the convention above.

2. **Configuration**  
   Edit `config.m` to set all parameters, including the list of object names and display option.

3. **Execution**  
   Run the main script in MATLAB: `main_reconstruction.m`.  
   The configuration will be updated automatically.  
   The results (cropped images, phase maps, depth maps) will be saved in the specified results folder, organized by fringe period and object name.

**Note:** Replace all `YOUR_IMAGES_DIRECTORY` and `YOUR_RESULTS_DIRECTORY` placeholders in the configuration with your actual directories before running the project.

## Credits

The `phase_unwrap_Ghiglia.m` function used for phase unwrapping is based on the article by Ghiglia and Romero (1994) and was adapted by Muhammad F. Kasim (University of Oxford, 2016).  
Reference:  
Ghiglia, D. C., & Romero, L. A. (1994). Robust two-dimensional weighted and unweighted phase unwrapping that uses fast transforms and iterative methods. *JOSA A*, 11(1), 107-117. [https://doi.org/10.1364/JOSAA.11.000107](https://doi.org/10.1364/JOSAA.11.000107)
