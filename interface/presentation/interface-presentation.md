# Robot Control & Visualization Interface

I use this interface as the operator-facing layer for controlling and monitoring the robotic arm.

## Controlled joints

| Index | Joint | Range |
|---:|---|---|
| 0 | Base | -180° to +180° |
| 1 | Shoulder | 0° to 180° |
| 2 | Elbow | 0° to 180° |
| 3 | Pan | 0° to 180° |
| 4 | Tilt | 0° to 180° |

## Functions

- five joint controls
- HOME position
- arm visualization
- joint-angle display
- temperature/humidity monitoring
- two distance channels
- sensor history graphs
- serial communication
- connection status

The supplied implementation uses Processing serial communication at 115200 baud.
