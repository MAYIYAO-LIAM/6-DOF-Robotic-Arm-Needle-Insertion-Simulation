# 6-DOF Robotic Arm Needle Insertion Simulation

This project simulates the motion trajectory of a 6-DOF robotic arm during a needle insertion process using MATLAB and the Robotics Toolbox. The robotic arm's task is to pick up a needle from a needle box, insert the needle into a simulated human back (represented by a y-z plane), release the needle, and repeat the process for all the designated insertion points.

## Features

- `move_between_points`: Controls the robotic arm to move between two points and perform needle insertion, while displaying the real-time velocity of the end-effector. Velocity is limited by defining the time step.
- `move_to_origin`: Controls the robotic arm to return to its initial position.
- `move_to_point`: Controls the robotic arm to move to the preparation position for needle insertion.
- `plot_body`: Plots a y-z plane to simulate a seated human's back.
- `plot_needle_box`: Plots a needle box to simulate the needle-picking process.
- `plot_visible_workspace`: Plots the visible workspace of the robotic arm.
- `pure_jacobian_test`: Plans the motion trajectory of the robotic arm using the pure Jacobian method.

## Usage

1. Ensure that you have MATLAB and the Robotics Toolbox installed.
2. Run the main script file to observe the motion trajectory of the robotic arm and the needle insertion process.
3. Modify the position parameters from `P11` to `P83` to change the needle insertion locations within the workspace, ensuring the robotic arm does not extend beyond the simulated human's back.
4. Adjust the `plot_body` and `plot_needle_box` functions as needed to plot different sizes and positions of the simulated human back and needle box.
5. Modify the time step in the `move_between_points` function to change the velocity limit during the needle insertion process.
6. Use the `pure_jacobian_test` function to test the trajectory planned using the pure Jacobian method.

## File Structure

- Main script file: Contains the definition of the robotic arm, motion planning, and simulation of the needle insertion process.
- `move_between_points.m`: Implements the functionality of moving the robotic arm between two points and performing needle insertion.
- `move_to_origin.m`: Implements the functionality of returning the robotic arm to its initial position.
- `move_to_point.m`: Implements the functionality of moving the robotic arm to the preparation position for needle insertion.
- `plot_body.m`: Function to plot the simulated human back as a y-z plane.
- `plot_needle_box.m`: Function to plot the needle box.
- `plot_visible_workspace.m`: Function to plot the visible workspace of the robotic arm.
- `pure_jacobian_test.m`: Function to plan the trajectory using the pure Jacobian method.

Note that this simulation focuses on the needle insertion process and does not represent an acupuncture procedure.
