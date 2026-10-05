# Robot Control Interface

## Scope

This interface is a dedicated operator interface for the **robotic arm and its associated sensors**.

It is not the full technical dashboard of the entire inspection robot.

## Control chain

```text
UI / operator command
        |
        v
Python/application layer
        |
        v
Serial / Arduino control
        |
        +------> Arm actuators
        |
        +------> Sensor acquisition
```

## Supplied implementation characteristics

The supplied interface material documents serial communication with the embedded controller at **115200 baud** and integration of robotic-arm motion with sensor visualization.

The broader SIANA APP supplied with the project is maintained separately under `software/siana-app/`. Its control panel includes emergency-stop state, manual override, speed control and movement-direction controls. That station UI represents a broader software platform and must not be conflated with the dedicated arm-and-sensor interface.

## Source location

```text
src/robot_control_interface/
```
