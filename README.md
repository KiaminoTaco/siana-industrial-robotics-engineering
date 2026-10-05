# SIANA | Industrial Robotics Engineering Portfolio

<p align="center">
  <strong>TGV Inspection Robot</strong><br>
  Mechanical Engineering · Electrical Engineering · Electronics · Embedded Robotics · Interface Engineering · System Integration
</p>

<p align="center">
  <img src="https://img.shields.io/badge/INDUSTRIAL-ROBOTICS-111827?style=for-the-badge" alt="Industrial Robotics">
  <img src="https://img.shields.io/badge/ENGINEERING-ELECTROMECHANICAL-374151?style=for-the-badge" alt="Electromechanical Engineering">
  <img src="https://img.shields.io/badge/PORTFOLIO-EVIDENCE--BASED-4b5563?style=for-the-badge" alt="Evidence Based Portfolio">
</p>

## Project Image

<p align="center">
  <img src="docs/academic/SIANA_Industrial_Robot.PNG" alt="SIANA Industrial Robot" width="850">
</p>

<p align="center">
  <strong>SIANA Industrial Inspection Robot</strong><br>
  Main project platform and engineering integration target
</p>

---

## 01 | PROJECT OVERVIEW

The **TGV Inspection Robot** is an industrial robotic platform developed for automated visual inspection of high-speed train undercarriages at SIANA maintenance facilities.

The project combines mechanical design, electrical systems, embedded control, sensing, robotic manipulation, onboard computing, communication, operator interfaces, computer vision and artificial intelligence.

This repository presents the project as an **engineering portfolio**, with a particular focus on the physical robot, its electromechanical integration, control interfaces and the engineering evidence available from the project material.

> **Important attribution principle**  
> This is a personal portfolio derived from a multidisciplinary team project. Team-level work is not automatically presented as individual work. Where individual ownership cannot be verified, the repository keeps the contribution explicitly marked as team-level, supported, inferred or unverified.

---

# 02 | ENGINEERING SCOPE

The project can be understood as a chain of interconnected engineering layers:

```text
                    TGV INSPECTION ROBOT
                            |
        +-------------------+-------------------+
        |                   |                   |
        v                   v                   v
   MECHANICAL          ELECTRICAL          ELECTRONICS
        |                   |                   |
        |                   |                   |
        +-------------------+-------------------+
                            |
                            v
                    EMBEDDED CONTROL
                            |
                            v
                  ONBOARD COMPUTING
                            |
             +--------------+--------------+
             |                             |
             v                             v
       ROBOT CONTROL                 AI / VISION
             |                             |
             +--------------+--------------+
                            |
                            v
                  OPERATOR INTERFACE
                            |
                            v
                  INSPECTION WORKFLOW
```

### Main engineering domains

| Domain | Main content |
|---|---|
| Mechanical | Chassis, wheels, robotic arm, fairing, CAD, drawings |
| Electrical | Power architecture, wiring, protection, actuators |
| Electronics | Controllers, sensors, communication interfaces |
| Embedded | Robot control, telemetry, low-level interfaces |
| Interface | Operator control, visualization, sensor feedback |
| Software | Robot-side and station-side software context |
| AI | Detection, inference and model-training workflow |
| Maintenance | Preventive maintenance and service procedures |
| Integration | Mechanical, electrical, electronic and software interfaces |

---

# 03 | SYSTEM ARCHITECTURE

The software platform described in the project is divided into two principal environments.

### Robot-side system

The robot-side software is responsible for functions such as:

- autonomous navigation
- camera operation
- lighting control
- onboard AI inference
- wireless communication
- battery and system-health monitoring
- operator commands
- synchronization of inspection data

### Station-side platform

The control station provides:

- robot management
- inspection-session management
- telemetry visualization
- video processing and storage
- AI model management
- defect records
- inspection reports
- authentication and access control
- notifications and alerts
- audit logging

### Communication layer

The project documentation identifies:

```text
MQTT
    |
    +---- Command messaging
    +---- Robot telemetry

WebRTC
    |
    +---- Low-latency video streaming

Object Storage
    |
    +---- Inspection video
    +---- High-resolution images
```

The software context includes Python/FastAPI, PostgreSQL, Redis, MinIO and Docker-based deployment.

---

# 04 | MECHANICAL ENGINEERING

The mechanical section contains the physical design evidence of the robot.

## Mechanical architecture

The documented robot includes:

- aluminium-profile chassis
- driven wheels
- caster wheels
- removable protective fairing
- robotic arm
- camera support
- mechanical mounting interfaces
- maintenance-accessible components

## Mechanical engineering activities

The repository is structured to contain:

```text
mechanical/
|
+-- cad/
|   +-- assemblies/
|   +-- chassis/
|   +-- arm/
|   +-- wheel-system/
|
+-- drawings/
|   +-- definition/
|   +-- assembly/
|   +-- manufacturing/
|
+-- schematics/
|
+-- calculations/
|
+-- maintenance/
|
+-- README.md
```

### Mechanical evidence

The mechanical section should contain the original project files whenever publication is permitted:

- CAD assemblies
- part models
- definition drawings
- assembly drawings
- STL files
- mechanical calculations
- mechanical research
- maintenance documentation

The README of this section should explain the engineering reasoning rather than simply listing files.

---

# 05 | ELECTRICAL ENGINEERING

The electrical section documents how energy, actuators, sensors and control electronics are interconnected.

## Main topics

- battery architecture
- power distribution
- DC/DC conversion
- motor supply
- controller supply
- sensor supply
- wiring
- protection
- emergency-stop architecture
- actuator interfaces
- communication wiring

## Recommended structure

```text
electrical/
|
+-- schematics/
|   +-- power/
|   +-- controllers/
|   +-- sensors/
|   +-- actuators/
|   +-- communication/
|   +-- emergency-stop/
|
+-- wiring/
|
+-- protection/
|
+-- variants/
|
+-- bom/
|
+-- calculations/
|
+-- README.md
```

### Configuration control

The available project material may contain different electrical configurations or design variants.

These variants should remain identifiable.

They should not be silently merged into a single configuration unless the project evidence clearly establishes which configuration is the final validated design.

---

# 06 | ELECTRONICS & EMBEDDED ROBOTICS

The robot uses several levels of embedded and computing hardware.

The project material identifies technologies including:

```text
Sensors
   |
   v
Microcontrollers
   |
   +---- ESP32
   +---- Arduino Mega
   |
   v
Onboard Computing
   |
   +---- Jetson Nano
   +---- Raspberry Pi 5
   |
   v
Robot Functions
   |
   +---- Control
   +---- Telemetry
   +---- Communication
   +---- Vision / AI
```

The electronics documentation should contain:

```text
electronics/
|
+-- architecture/
+-- wiring/
+-- controllers/
+-- sensors/
+-- communication/
+-- component-docs/
+-- README.md
```

The embedded section should distinguish between:

- verified project source code
- project architecture
- representative portfolio code
- reconstructed examples
- personal integration work

This prevents representative code from being presented as original team source code.

---

# 07 | ROBOT CONTROL INTERFACE

A dedicated interface section documents the operator-facing control and monitoring layer.

```text
interface/
|
+-- code/
|   +-- RobotArmInterface.pde
|   +-- RobotControlerInterface.pde
|
+-- presentation/
|
+-- protocol/
|
+-- diagrams/
|
+-- README.md
```

## Interface functions

The supplied Processing interface includes functionality related to:

- five-joint robot control
- target-angle commands
- current-angle feedback
- HOME positioning
- arm visualization
- temperature monitoring
- humidity monitoring
- distance measurements
- sensor-history graphs
- serial communication
- connection status

### Joint model

| Joint | Documented range |
|---|---:|
| Base | -180° to +180° |
| Shoulder | 0° to 180° |
| Elbow | 0° to 180° |
| Pan | 0° to 180° |
| Tilt | 0° to 180° |

The interface protocol uses serial communication at **115200 baud**.

`RobotArmInterface.pde` is based on the supplied Processing interface source.

`RobotControlerInterface.pde` is a companion portfolio integration layer and should not be interpreted as automatically verified original team source code.

---

# 08 | SOFTWARE & AI CONTEXT

The project software platform supports the inspection workflow from robot operation to data analysis.

## Robot-side software

```text
Navigation
   |
Camera / Lighting
   |
AI Inference
   |
Telemetry
   |
Communication
   |
Inspection Data
```

## Station-side software

```text
Robot Management
       |
Inspection Sessions
       |
Video / Image Management
       |
Defect Records
       |
AI Training
       |
Reports / Analytics
```

### Technologies documented in the project

| Category | Technologies |
|---|---|
| Backend | Python, FastAPI |
| Database | PostgreSQL |
| Cache | Redis |
| Object storage | MinIO |
| Messaging | MQTT |
| Video | WebRTC |
| Deployment | Docker |
| AI | Machine-learning / YOLO-based workflow |

The software section is primarily maintained as **project context** unless an individual contribution is directly supported by evidence.

---

# 09 | MAINTENANCE ENGINEERING

Maintenance is treated as part of the robot engineering lifecycle.

The repository can contain:

```text
maintenance/
|
+-- manuals/
+-- preventive/
+-- inspection-checklists/
+-- maintenance-history/
+-- component-service/
+-- README.md
```

Typical documented maintenance subjects include:

- chassis and fairing inspection
- wheel-support inspection
- wheel play
- caster inspection
- cleaning and corrosion checks
- emergency-stop checks
- movement-warning checks
- robotic-arm fastening
- sealing inspection
- periodic general inspection

The maintenance section connects the physical design to long-term industrial operation.

---

# 10 | ENGINEERING DOCUMENTATION

The documentation layer should explain the engineering story without duplicating every source file.

### Academic project image

The main project image used in this README is stored in:

```text
docs/academic/SIANA_Industrial_Robot.PNG
```

It is referenced with a repository-relative path so that GitHub renders the image directly from the repository.

```text
documentation/
|
+-- system-architecture.md
+-- mechanical-engineering.md
+-- electrical-engineering.md
+-- electronics-engineering.md
+-- embedded-systems.md
+-- interface-engineering.md
+-- system-integration.md
+-- testing-and-validation.md
+-- maintenance-engineering.md
+-- contribution.md
```

The principle is:

```text
DOCUMENTATION
     |
     +---- explains the engineering
     |
     v
ENGINEERING FILES
     |
     +---- prove / support the engineering
```

---

# 11 | ENGINEERING EVIDENCE & ATTRIBUTION

This portfolio follows a strict attribution model.

| Status | Meaning |
|---|---|
| Explicitly documented | The project material directly identifies the contribution |
| Project-supported | The contribution is strongly supported by technical evidence |
| Team-level | It belongs to the project team rather than being individually attributed |
| Inferred | It is an engineering interpretation derived from available evidence |
| Other contributor | The source identifies another contributor |
| Uncertain | The available material is insufficient to verify ownership |

### Source priority

```text
1. Direct project files
2. Technical report
3. Project documentation
4. Team GitHub repository
5. Project images / videos
6. CV for professional context
7. Personal explanations
8. General engineering knowledge
```

This hierarchy is used to avoid turning assumptions into factual project claims.

---

# 12 | PROJECT VARIANTS

The project material may contain different technical variants during the development process.

Examples can include:

- alternative controller architectures
- alternative battery configurations
- alternative motor selections
- alternative sensor arrangements
- different software architecture stages

A variant is therefore kept as a **documented design state** until the project evidence establishes the final validated configuration.

This is important in an engineering portfolio because development history is evidence of engineering decision-making.

---

# 13 | REPOSITORY STRUCTURE

```text
SIANA-Industrial-Robotics-Engineering/
|
+-- mechanical/
|   +-- cad/
|   +-- drawings/
|   +-- schematics/
|   +-- calculations/
|   +-- maintenance/
|
+-- electrical/
|   +-- schematics/
|   +-- wiring/
|   +-- protection/
|   +-- variants/
|   +-- bom/
|
+-- electronics/
|   +-- architecture/
|   +-- wiring/
|   +-- controllers/
|   +-- sensors/
|
+-- embedded/
|
+-- interface/
|   +-- code/
|   +-- presentation/
|   +-- protocol/
|   +-- diagrams/
|
+-- electromechanical-integration/
|
+-- integration/
|
+-- calculations/
|
+-- maintenance/
|
+-- documentation/
|
+-- software-context/
|
+-- media/
|
+-- contribution/
|
+-- tests/
|
+-- bom/
|
+-- README.md
```

---

# 14 | HOW TO REVIEW THIS PORTFOLIO

A technical reviewer can follow this path:

```text
                    README
                      |
          +-----------+-----------+
          |           |           |
          v           v           v
      MECHANICAL   ELECTRICAL  ELECTRONICS
          |           |           |
          +-----------+-----------+
                      |
                      v
                EMBEDDED SYSTEMS
                      |
                      v
                INTERFACE LAYER
                      |
                      v
              SYSTEM INTEGRATION
                      |
                      v
               MAINTENANCE
```

For detailed verification, each engineering explanation should lead to the corresponding:

- CAD file
- drawing
- schematic
- calculation
- source code
- test result
- maintenance document
- photograph or video

---

# 15 | ENGINEERING APPROACH

The project demonstrates a multidisciplinary engineering workflow:

```text
Requirements
     |
     v
System Architecture
     |
     v
Mechanical / Electrical Design
     |
     v
Electronics & Embedded Control
     |
     v
Software / Interface
     |
     v
System Integration
     |
     v
Testing & Validation
     |
     v
Maintenance
```

The portfolio is intended to demonstrate the ability to understand and document these interfaces as one industrial robotic system.

---

# 16 | PERSONAL PORTFOLIO POSITIONING

This repository is designed to communicate an engineering profile focused on:

**Industrial Robotics**

with supporting capabilities in:

- mechanical design
- CAD and technical drawings
- electrical architecture
- electronics
- embedded systems
- robotic-arm integration
- sensor integration
- operator interfaces
- system integration
- maintenance engineering
- technical documentation

The emphasis is on understanding how the physical, electrical and digital parts of a robot operate together.

---

# 17 | COPYRIGHT, OWNERSHIP & PUBLICATION

This repository is a **personal engineering portfolio derived from a team project**.

It should not imply ownership of every project artifact.

Before public publication:

- verify whether project documents may be redistributed
- verify teammate-owned source code
- verify institutional documentation
- verify CAD and manufacturer documents
- remove confidential information
- preserve original attribution where required

When authorship is uncertain, the repository should explicitly say so.

---

<p align="center">
  <strong>SIANA — Industrial Robotics Engineering Portfolio</strong><br>
  TGV Inspection Robot
</p>

<p align="center">
  Mechanical · Electrical · Electronics · Embedded · Interface · Integration · Maintenance
</p>
