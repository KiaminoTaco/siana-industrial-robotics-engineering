# Electrical Engineering

## System role

The electrical subsystem links the power architecture, embedded controllers, sensors and actuators.

## Documented controllers

The project material discusses ESP32, Arduino Mega 2560, Raspberry Pi and NVIDIA Jetson platforms in a distributed architecture.

## Robotic arm

The robotic arm is described as a 6-DOF subsystem. The electrical documentation identifies an Arduino Mega 2560 as its dedicated controller and PWM-driven digital servomotors as its actuators.

A dedicated arm power path is used to limit voltage disturbance caused by servo current demand.

## Sensors

The supplied technical material covers:

- LiDAR for navigation and mapping;
- SRF10 ultrasonic sensors for obstacle detection around the arm;
- LM35 temperature sensing associated with motors;
- Sharp GP2Y0A02YK0F infrared distance sensing;
- camera/CSI imaging;
- IMU sensing;
- LoRa communications;
- CAN communications.

## Power and protection

The project studies battery supply, voltage conversion, distribution, motor/ESC power and protection measures including fusing and relay-based safety isolation.

## Individual contribution

The electrical contribution includes the integration of motors and sensors into the Python/Arduino control software and the associated hardware/software interface work.

## Design files

Authoritative electrical design files are intentionally left for manual addition:

```text
hardware/electrical/schematics/
hardware/electrical/pcb/
hardware/electrical/bom/
```
