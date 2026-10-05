# Interface Architecture

```text
Operator
   |
   v
RobotArmInterface (Processing)
   |
   v
RobotControlerInterface
   |
   | Serial / USB
   v
Embedded Robot Controller
   |
   +--> Robotic arm
   +--> Sensors
   +--> Status / safety
```

The graphical interface is an operator layer; safety-critical functions should remain independently enforced by the embedded controller and hardware.
