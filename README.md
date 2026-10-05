# SIANA Industrial Robotics Engineering

## Academic Engineering Repository — Prix InnovAM'26 / SAFE TRACK SIANA

This repository consolidates the engineering, software and integration work supplied for the SIANA industrial inspection robotics project.

The project concerns a robotic inspection platform intended to operate beneath railway vehicles and support inspection through mechanical mobility, sensing, embedded control, computer vision, artificial intelligence, communication and operator supervision.

The repository is deliberately organized as an **engineering project archive** rather than as a software-only repository. It distinguishes the team-level system from the individual contribution of the electrical/control contributor.

---

## 1. Project objective

The SIANA platform is designed around the following engineering objectives:

- inspection of railway-vehicle underbody components;
- acquisition and transmission of visual information;
- sensing for obstacle detection and environmental monitoring;
- robotic-arm manipulation and sensor orientation;
- real-time actuator and sensor control;
- AI-assisted defect detection;
- operator supervision and remote control;
- generation and management of inspection information.

The supplied technical material describes a distributed architecture involving embedded controllers, high-level computing, AI processing, sensing, actuation and a station-side software platform.

---

## 2. System architecture

At system level, the supplied material describes a separation between physical equipment, embedded control, high-level computation and the operator/station layer.

```text
                         OPERATOR / STATION
                                |
                                v
                    +-------------------------+
                    | SIANA Software Platform  |
                    | Web UI / Services / DB   |
                    +------------+------------+
                                 |
                         Commands / Telemetry
                                 |
                                 v
                    +-------------------------+
                    | High-Level Computation   |
                    | Raspberry Pi / Jetson    |
                    +------------+------------+
                                 |
               +-----------------+-----------------
               |                                   |
               v                                   v
     +--------------------+              +--------------------+
     | Embedded Control   |              | AI / Perception    |
     | Arduino / ESP32    |              | Vision / ROS 2     |
     +----------+---------+              +--------------------+
                |
          +-----+------+
          |            |
          v            v
       Actuators     Sensors
          |
          v
  Mechanical Robot Platform
```

The exact controller allocation evolved across the project material. The repository therefore preserves the terminology of the supplied documentation and avoids presenting preliminary allocations as immutable final hardware.

---

## 3. Individual contribution

### Electrical engineering and control integration

The principal individual contribution documented for this repository is the **electrical part of the project**.

The contribution includes:

- electrical-system research and architecture;
- motor and actuator integration;
- sensor integration;
- embedded controller integration;
- integration of motors and sensors into Python/Arduino control code;
- support for robotic-arm control;
- hardware/software integration;
- technical research and system-level engineering support.

The mechanical and AI domains were collaborative team activities. Contributions to those areas are therefore represented as supporting/integration work rather than as sole ownership.

### Robot Control Interface

A specific distinction is important:

> The **Robot Control Interface** is the dedicated interface used for robotic-arm movement and associated sensor interaction. It is not the complete technical dashboard of every SIANA robot subsystem.

The interface was developed collaboratively with the teammate responsible for the AI part. The electrical/control responsibility covered the integration of the physical motors and sensors with the Python/Arduino control layer.

The dedicated repository location is:

```text
src/robot_control_interface/
```

The supplied SIANA APP is also preserved under `software/siana-app/`; this is the broader station-side/web software platform and should not be confused with the dedicated arm-and-sensor interface.

---

## 4. Electrical engineering

The electrical documentation describes a distributed embedded architecture involving platforms such as ESP32, Arduino Mega, Raspberry Pi and NVIDIA Jetson, together with power, sensing and communication interfaces.

The documented system includes studies and integration around:

- motor control;
- robotic-arm servo control;
- ultrasonic distance sensing;
- temperature sensing;
- infrared proximity sensing;
- LiDAR navigation;
- IMU sensing;
- camera interfaces;
- LoRa communication;
- CAN communication;
- UART/serial communication;
- power conversion and distribution;
- protection and dedicated actuator power.

The six-degree-of-freedom robotic arm is documented with a dedicated Arduino Mega 2560 control layer and PWM-controlled high-torque digital servomotors. A dedicated arm supply is used to reduce disturbance from actuator current transients on the rest of the electronics.

Electrical design files are intentionally left in structured directories for manual addition, as requested.

---

## 5. Mechanical engineering

The mechanical project material includes the robot chassis, arm structure, joints, supports, couplings, sheet-metal parts, CAD assemblies, STEP/STL models, technical drawings and maintenance material.

Mechanical ownership is represented as a team contribution. Supporting technical and integration work is acknowledged, while the repository does not incorrectly attribute the complete mechanical design to the electrical contributor.

The final mechanical files should be added manually under:

```text
hardware/mechanical/cad/
hardware/mechanical/drawings/
hardware/mechanical/3d_prints/
```

---

## 6. Robot Control Interface

The dedicated interface is intended for robotic-arm and sensor control. The supplied implementation material establishes a hardware/software control chain of the following form:

```text
Operator interface
       |
       v
Python / application control layer
       |
       v
Arduino / serial control
       |
       +------> Robotic-arm motors / servos
       |
       +------> Associated sensors
```

The interface source supplied for the project includes controls and visualization for robotic motion and sensor values. The implementation material also documents serial communication at 115200 baud for the embedded interface.

The interface source should be maintained separately from the broader SIANA station application so that its purpose remains unambiguous.

---

## 7. SIANA station/application software

The final package includes the source material supplied in `SIANA APP` under:

```text
software/siana-app/
```

The application material contains two principal software sides:

### Siana UI

A React/TypeScript/Vite web application containing pages and components for:

- dashboard monitoring;
- robot management;
- inspection monitoring;
- live video presentation;
- anomaly tables;
- reports;
- settings and user management;
- robot control panels.

The supplied implementation uses React, TypeScript, Vite, Zustand, React Router, Tailwind/shadcn-style UI components, Framer Motion and other supporting libraries.

### Station backend/infrastructure

The station package includes FastAPI authentication services, PostgreSQL initialization, Nginx gateway configuration and Docker Compose deployment material.

The supplied architecture describes communication and data-management concepts involving REST APIs, WebSockets, MQTT/WebRTC-oriented integration, PostgreSQL, Redis/object-storage concepts and containerized deployment.

---

## 8. Computer vision and AI material

The supplied SIANA APP package contains a defect-detection workspace including:

- YOLO-based training material;
- a training notebook;
- dataset configuration;
- training/validation/test data;
- evaluation plots;
- confusion matrices;
- prediction examples;
- result CSV files.

Large trained model binaries are intentionally excluded from the GitHub-oriented repository package. They should be managed through Git LFS or an external model/artifact registry rather than committed directly to a normal Git repository.

---

## 9. Repository structure

```text
siana-industrial-robotics-engineering/
│
├── README.md
├── LICENSE
│
├── docs/
│   ├── academic/
│   ├── architecture/
│   ├── dashboard/
│   ├── electrical/
│   ├── mechanical/
│   └── reference/
│
├── hardware/
│   ├── electrical/
│   │   ├── schematics/
│   │   ├── pcb/
│   │   └── bom/
│   └── mechanical/
│       ├── cad/
│       ├── drawings/
│       └── 3d_prints/
│
├── src/
│   ├── robot_control_interface/
│   ├── arm_control/
│   └── embedded/
│
├── software/
│   └── siana-app/
│
├── tests/
└── media/
```

---

## 10. Academic documentation principle

The project is documented according to an engineering traceability chain:

**Requirement → Architecture → Component selection → Dimensioning → Implementation → Integration → Testing → Limitations → Future improvements**

Measured values, component specifications, calculations, assumptions and preliminary design choices should be explicitly distinguished in future additions.

---

## 11. Source-control policy

This repository intentionally excludes generated or environment-specific material such as:

- `node_modules/`;
- generated frontend `dist/` directories;
- local `.env` files containing configuration or credentials;
- large trained model binaries.

The source package retains dependency manifests such as `package.json` and `package-lock.json`, so dependencies can be reproduced without committing installed packages.

---

## 12. Project status

This package represents the consolidated repository structure after the supplied project documentation, mechanical/electrical material, Robot Control Interface information and SIANA APP software package were considered.

The mechanical and electrical design directories remain intentionally prepared for manual insertion of the authoritative design files, in accordance with the project owner's requested repository policy.

---

## 13. Repository identity

**Repository name:** `siana-industrial-robotics-engineering`

**Project:** SIANA / SAFE TRACK industrial inspection robotics

**Domain:** Industrial Robotics · Electromechanical Engineering · Embedded Control · Computer Vision · AI · Robotic Manipulation · Inspection Systems
