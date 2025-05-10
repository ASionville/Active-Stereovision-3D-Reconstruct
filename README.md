# Active-Stereovision-3D-Reconstruct

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

## Usage

1. **Prepare your data**  
   Place your images in a folder and note the path.

2. **Configuration**  
   In the `main_reconstruction.m` file, replace the paths `YOUR_DATA_PATH` and `YOUR_RESULTS_PATH` with your actual data and results directories.

3. **Execution**  
   Run the main script in MATLAB: `main_reconstruction.m`.
   The results (cropped images, phase maps, depth maps) will be saved in the specified results folder.

## Credits

The `phase_unwrap_Ghiglia.m` function used for phase unwrapping is based on the article by Ghiglia and Romero (1994) and was adapted by Muhammad F. Kasim (University of Oxford, 2016).  
Reference:  
Ghiglia, D. C., & Romero, L. A. (1994). Robust two-dimensional weighted and unweighted phase unwrapping that uses fast transforms and iterative methods. *JOSA A*, 11(1), 107-117. [https://doi.org/10.1364/JOSAA.11.000107](https://doi.org/10.1364/JOSAA.11.000107)

**Note:** Replace all `YOUR_DATA_PATH` and `YOUR_RESULTS_PATH` placeholders in the code with your actual directories before running the project.