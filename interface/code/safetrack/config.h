#ifndef CONFIG_H
#define CONFIG_H

// ---- CNC Shield V3 (Arduino Uno) pinout for stepper drivers ----
// We use X, Y, Z axes. Enable is shared, held LOW by default.
#define X_STEP_PIN       2
#define X_DIR_PIN        5
#define Y_STEP_PIN       3
#define Y_DIR_PIN        6
#define Z_STEP_PIN       4
#define Z_DIR_PIN        7
#define STEPPER_ENABLE   8       // Common enable, LOW = enabled

// ---- Microstepping (set by jumpers on the shield) ----
// Assume 1/16 microstepping for all drivers.
#define MICROSTEPS       16
#define STEPS_PER_REV    200     // NEMA17 / NEMA23 standard

// ---- Stepper motor assignments ----
// 0 = base (NEMA17), 1 = shoulder (NEMA17), 2 = elbow (NEMA23)
#define NUM_STEPPERS     3

// ---- Servo pins ----
#define SERVO1_PIN       9
#define SERVO2_PIN       10

// ---- DHT22 sensor ----
#define DHT22_PIN        A4

// ---- HC-SR04 ultrasonic sensors ----
#define TRIG_PIN_1       A0
#define ECHO_PIN_1       A1
#define TRIG_PIN_2       A2
#define ECHO_PIN_2       A3

// ---- Serial communication ----
#define SERIAL_BAUD      115200
#define PUBLISH_INTERVAL 100   // ms between angle publications

// ---- Movement limits ----
#define MAX_ANGLE_DEG    180.0f
#define MIN_ANGLE_DEG    0.0f

#endif
