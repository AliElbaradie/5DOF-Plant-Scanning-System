# 5DOF Plant Scanning System

**University Mechatronics Laboratory Team Project**  
**University of Duisburg-Essen**  
**November 2025**

This project was carried out as part of the **Mechatronics Laboratory** course at the **University of Duisburg-Essen**.

---

## Overview

This repository presents the development of a **5-degree-of-freedom (5-DOF) automated plant scanning system** for image acquisition and 3D plant reconstruction.

The project was completed by a **four-member interdisciplinary student team**, combining embedded systems, electronics, mechanical engineering and computer vision.

My primary responsibility was the **embedded systems development and hardware integration**, including Arduino programming, Processing GUI development, electronics integration, motion control and system integration.

---

## My Contributions

I was responsible for the embedded systems and electronics development, including:

- Development of the Arduino software for five-axis motion control
- Development of a Java-based graphical user interface using Processing
- Serial communication between the PC and Arduino
- Stepper motor control
- Integration of motor drivers, power supply and sensors
- Hardware wiring and electronics integration
- Design of custom sensor mounts using Siemens NX
- Manufacturing of custom components using 3D printing
- Hardware testing, debugging and system integration

---

## Other Team Responsibilities

### Mechanical System Development

- Redesign and modification of the existing test bench
- Mechanical integration of the 5-DOF motion platform

### Machine Vision & Machine Learning

- Camera selection and integration
- Image acquisition
- Machine vision
- Machine learning
- 3D plant reconstruction

---

## Project Objectives

- Develop a 5-DOF automated motion platform
- Control five stepper motors using an Arduino Mega 2560
- Develop a PC-based graphical user interface (GUI)
- Enable serial communication between the PC and the motion controller
- Integrate sensors and electronic hardware
- Support automated image acquisition for computer vision and 3D plant reconstruction

---

## System Hardware

### Motion System

- 5 Degrees of Freedom (3 Linear + 2 Rotational)
- X-, Y- and Z-axis linear motion
- Pan and Tilt camera mount
- Aluminum profile test bench

<p align="center">
<img src="images/system_overview_1.jpg.jpg" width="32%">
<img src="images/system_overview_2.jpg.jpg" width="32%">
<img src="images/system_overview_3.jpg.jpg" width="26%">
</p>

### Microcontroller

- Arduino Mega 2560
- USB serial communication

<p align="center">
<img src="images/arduino_mega_2560.png" width="35%">
</p>

### Motors

- 2 × NEMA 23 stepper motors (X/Y)
- 1 × Dual-shaft NEMA 23 stepper motor with electromagnetic brake (Z)
- 2 × NEMA 17 stepper motors (Pan/Tilt)

<p align="center">
<img src="images/nema23_stepper_motor_x.jpg" width="18%">
<img src="images/nema23_stepper_motor_z.jpg" width="32%">
<img src="images/nema17_stepper_motors.jpg" width="32%">
</p>

### Motor Drivers

- 5 × DM542T stepper motor drivers

<p align="center">
<img src="images/dm542t_driver.png" width="22%">
</p>

### Power Supply

- 24 V DC power supply

<p align="center">
<img src="images/power_supply.png" width="32%">
</p>

### Sensors

- Hall-effect limit switches
- Mechanical limit switches

<p align="center">
<img src="images/hall_effect_sensor.png" width="16%">
<img src="images/mechanical_limit_switch.png" width="16%">
<img src="images/sensor_mount.png" width="16%">
</p>

### Mechanical Components

- Linear guide rails
- Timing belt drive
- Shaft couplings
- Cable drag chains
- Spiral cable protection
- Custom 3D-printed sensor mounts

---

## Hardware Architecture

The following diagram illustrates the electrical architecture and wiring of the motion control system.

<p align="center">
<img src="images/hardware_architecture.png" width="70%">
</p>

The diagram shows the connection between the Arduino Mega 2560, DM542T stepper motor drivers, stepper motors, limit switches, and the 24 V power supply.

---

## Technologies

### Programming

- C/C++ (Arduino)
- Java (Processing)

### Embedded Systems

- Arduino Mega 2560
- Stepper Motor Control
- Serial Communication

### CAD

- Siemens NX
- 3D Printing

### Hardware

- Stepper Motors
- DM542T Stepper Drivers
- Hall-effect & Mechanical Limit Switches
- 24 V DC Power Supply

---

## Processing GUI

The graphical user interface was developed in **Processing (Java)** and provides intuitive control of the five motion axes. It communicates with the Arduino Mega via USB serial communication, allowing users to specify movement distances and rotation angles.

The indicators on the right side of the interface continuously display the current position of each motor in real time, allowing users to monitor the system state and verify executed movements during operation.

The screenshot below shows the **final GUI** developed during the project.

<p align="center">
<img src="images/processing_gui.png" width="70%">
</p>

> **Note**
>
> The repository contains the latest available source code. The GUI shown in the screenshot represents the final version demonstrated during the project, while the available Processing source code corresponds to an earlier development stage.

---

## Project Demonstration

The videos below demonstrate the operation of the 5-DOF camera positioning system.

- 🎥 [X-Axis Motion](videos/x_axis_motion.mp4)
- 🎥 [Y-Axis Motion](videos/y_axis_motion.mp4)
- 🎥 [Z-Axis Motion](videos/z_axis_motion.mp4)
- 🎥 [Tilt Camera Motion](videos/camera_tilt_motion.mp4)
- 🎥 [Pan Camera Motion](videos/camera_pan_motion.mp4)

---

## Repository Structure

```text
5DOF-Plant-Scanning-System/
│
├── README.md
│
├── arduino/
│   └── PlantScanner.ino
│
├── processing/
│   └── PlantScannerGUI.pde
│
├── docs/
│   └── Project_Report.pdf
│
└── images/
    ├── system_overview_1.jpg
    ├── system_overview_2.jpg
    ├── system_overview_3.jpg
    ├── arduino_mega_2560.png
    ├── nema23_stepper_motor_x.jpg
    ├── nema23_stepper_motor_z.jpg
    ├── nema17_stepper_motors.jpg
    ├── dm542t_driver.png
    ├── power_supply.png
    ├── hall_effect_sensor.jpg
    ├── mechanical_limit_switch.jpg
    ├── sensor_mount.jpg
    ├── processing_gui.png
    └── hardware_architecture.png
```

---

## Documentation

The complete project report is available in the **docs** folder.

📄 [Project Report (PDF)](docs/Project_Report.pdf)

---

## Author

**Ali Elbaradie**

M.Sc. Mechanical Engineering (Mechatronics)  
University of Duisburg-Esseneering (Mechatronics)  
University of Duisburg-Essen
