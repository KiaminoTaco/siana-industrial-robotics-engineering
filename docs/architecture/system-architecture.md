# System Architecture

The SIANA project uses a distributed architecture in which physical actuation, embedded control, high-level computation, AI/perception and operator/station software are separated into cooperating layers.

## Main layers

1. **Physical layer** — chassis, motors, arm actuators and sensors.
2. **Embedded layer** — real-time motor/servo and sensor interfacing.
3. **High-level computation** — Raspberry Pi / Jetson-oriented computation and coordination.
4. **AI/perception** — image processing and defect-detection workflows.
5. **Station layer** — web interface, services, databases, communication and reporting.
6. **Dedicated Robot Control Interface** — arm movement and associated sensor interaction.

The supplied SIANA APP adds a station-side software implementation with a React/TypeScript frontend and FastAPI-oriented backend services, PostgreSQL initialization and Nginx/Docker infrastructure.
