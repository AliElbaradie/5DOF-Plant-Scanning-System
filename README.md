# 5DOF Automated Camera Control System

**University Mechatronics Laboratory Team Project**  
**University of Duisburg-Essen**  
**November 2025**

This project was carried out as part of the **Mechatronics Laboratory** course at the **University of Duisburg-Essen**.

---

## Overview

This repository presents the development of a **5-degree-of-freedom (5-DOF) automated camera control system** for monitoring a laboratory sandbox.

The system combines a **three-axis Cartesian motion platform** with a **two-axis pan-tilt camera mechanism**, enabling precise positioning and orientation of the camera for automated image acquisition.

The project was completed by a **four-member interdisciplinary student team**, combining embedded systems, electronics, mechanical engineering and computer vision.

My primary responsibility was the **embedded systems development and hardware integration**, including Arduino programming, Processing GUI development, electronics integration, motion control, CAD design of custom components and overall system integration.

---

## My Contributions

I was responsible for the embedded systems and electronics development, including:

- Development of the Arduino software for five-axis motion control
- Development of the Processing-based graphical user interface (GUI)
- Serial communication between the PC and Arduino Mega
- Stepper motor control
- Integration of DM542T motor drivers
- Hardware wiring and electronics integration
- Integration of sensors and power supplies
- Design of custom camera mount and sensor holders using Siemens NX
- Manufacturing of custom components using 3D printing
- Hardware testing, debugging and complete system integration

---

## Other Team Responsibilities

### Mechanical System Development

- Design and assembly of the aluminum motion platform
- Mechanical integration of the linear motion system
- Belt drive and frame construction

### Computer Vision

- Camera selection and calibration
- Image acquisition
- Image processing
- Sandbox monitoring

---

## Project Objectives

- Develop a 5-DOF automated camera positioning system
- Control five stepper motors using an Arduino Mega 2560
- Develop a PC-based graphical user interface (GUI)
- Enable serial communication between the PC and the motion controller
- Integrate sensors and electronic hardware
- Provide accurate positioning of the camera inside the sandbox

---

## System Hardware

### Motion System

- 5 Degrees of Freedom (3 Linear + 2 Rotational)
- X-, Y- and Z-axis linear motion
- Pan and Tilt camera platform
- Aluminum extrusion frame

### Microcontroller

- Arduino Mega 2560
- USB serial communication

### Motors

- 2 × NEMA 23 stepper motors (X/Y)
- 1 × NEMA 23 stepper motor (Z)
- 2 × NEMA 17 stepper motors (Pan/Tilt)

### Motor Drivers

- 5 × DM542T digital stepper motor drivers

### Power Supply

- 24 V DC power supply

### Sensors

- Hall-effect sensor
- Mechanical limit switches

### Mechanical Components

- Linear guide rails
- Timing belt drive
- Cable drag chains
- Spiral cable protection
- Custom 3D-printed camera mount
- Custom 3D-printed sensor holders

---

## Technologies

### Programming

- Arduino (C/C++)
- Processing

### Embedded Systems

- Arduino Mega 2560
- Stepper Motor Control
- Serial Communication

### CAD

- Siemens NX
- 3D Printing

### Hardware

- DM542T Stepper Drivers
- NEMA 23 Stepper Motors
- NEMA 17 Stepper Motors
- Hall-effect Sensor
- Mechanical Limit Switches
- 24 V DC Power Supply

---

## Processing GUI

The Processing application provides a graphical user interface for controlling the five motion axes of the platform. It allows users to specify movement distances and camera angles while communicating with the Arduino via USB serial communication.

The screenshot below shows the final GUI developed during the project.

![Processing GUI](images/processing_gui.png)

> **Note**
>
> The repository contains the latest available source code. The GUI shown in the screenshot represents the final version demonstrated during the project.

---

## Images

### Complete System

The complete automated camera positioning system.

<p align="center">
<img src="images/system_overview_1.jpg" width="32%">
<img src="images/system_overview_2.jpg" width="32%">
<img src="images/system_overview_3.jpg" width="32%">
</p>

---

### Camera Platform

The custom-designed pan-tilt camera platform.

<p align="center">
<img src="images/camera_platform.jpg" width="45%">
<img src="images/camera_mount_closeup.jpg" width="45%">
</p>

---

### Hardware Architecture

The electrical architecture of the complete motion control system.

![Hardware Architecture](images/hardware_architecture.png)

---

### Electronics

Main electronic hardware components used in the project.

<p align="center">
<img src="images/arduino_mega_2560.png" width="22%">
<img src="images/dm542t_driver.png" width="22%">
<img src="images/power_supply.png" width="22%">
<img src="images/nema23_stepper_motor.png" width="22%">
</p>

---

### Sensor System

Custom-designed sensor holders together with the Hall-effect sensor and mechanical limit switch.

<p align="center">
<img src="images/sensor_mount.jpg" width="32%">
<img src="images/hall_effect_sensor.jpg" width="32%">
<img src="images/mechanical_limit_switch.jpg" width="32%">
</p>

---

## Repository Structure

```text
5DOF-Camera-Control-System/
│
├── README.md
│
├── arduino/
│   └── CameraControl.ino
│
├── processing/
│   └── CameraControlGUI.pde
│
├── docs/
│   └── Project_Report.pdf
│
└── images/
    ├── system_overview_1.jpg
    ├── system_overview_2.jpg
    ├── system_overview_3.jpg
    ├── camera_platform.jpg
    ├── camera_mount_closeup.jpg
    ├── hardware_architecture.png
    ├── processing_gui.png
    ├── sensor_mount.jpg
    ├── hall_effect_sensor.jpg
    ├── mechanical_limit_switch.jpg
    ├── arduino_mega_2560.png
    ├── dm542t_driver.png
    ├── power_supply.png
    └── nema23_stepper_motor.png
```

---

## Documentation

The complete project report is available in the **docs** folder.

📄 [Project Report (PDF)](docs/Project_Report.pdf)

---

## Author

**Ali Elbaradie**

M.Sc. Mechanical Engineering (Mechatronics)  
University of Duisburg-Essen
