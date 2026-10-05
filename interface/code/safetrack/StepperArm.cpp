#include "StepperArm.h"
#include <Arduino.h>

// ---------------------------------------------------------------------------
// Constructor
// ---------------------------------------------------------------------------
StepperArm::StepperArm()
    : stepperX(AccelStepper::DRIVER, X_STEP_PIN, X_DIR_PIN)
    , stepperY(AccelStepper::DRIVER, Y_STEP_PIN, Y_DIR_PIN)
    , stepperZ(AccelStepper::DRIVER, Z_STEP_PIN, Z_DIR_PIN)
    , stepsPerDegree((float)(STEPS_PER_REV * MICROSTEPS) / 360.0f)
    , enabled(false)
{
}

// ---------------------------------------------------------------------------
// begin() – initialise drivers and motor parameters
// ---------------------------------------------------------------------------
void StepperArm::begin() {
  // Common enable pin: LOW = motors enabled
  pinMode(STEPPER_ENABLE, OUTPUT);
  digitalWrite(STEPPER_ENABLE, LOW);
  enabled = true;

  // Configure each stepper
  AccelStepper* steppers[3] = { &stepperX, &stepperY, &stepperZ };
  for (auto s : steppers) {
    s->setMaxSpeed(400);        // steps per second, adjust to your needs
    s->setAcceleration(200);    // steps per second per second
    s->setCurrentPosition(0);   // assume homed at zero
  }
}

// ---------------------------------------------------------------------------
// setTargetAngle() – request a new angle for a stepper joint
// ---------------------------------------------------------------------------
void StepperArm::setTargetAngle(MotorIndex joint, float angle) {
  angle = clampAngle(angle);
  long targetSteps = angleToSteps(angle);

  AccelStepper* motor = nullptr;
  switch (joint) {
    case BASE:     motor = &stepperX; break;
    case SHOULDER: motor = &stepperY; break;
    case ELBOW:    motor = &stepperZ; break;
    default: return; // invalid joint
  }

  motor->moveTo(targetSteps);
}

// ---------------------------------------------------------------------------
// getCurrentAngle() – convert current motor position back to degrees
// ---------------------------------------------------------------------------
float StepperArm::getCurrentAngle(MotorIndex joint) const {
  long pos = 0;
  switch (joint) {
    case BASE:     pos = stepperX.currentPosition(); break;
    case SHOULDER: pos = stepperY.currentPosition(); break;
    case ELBOW:    pos = stepperZ.currentPosition(); break;
    default: return 0.0f;
  }
  return stepsToAngle(pos);
}

// ---------------------------------------------------------------------------
// update() – non‑blocking call in loop()
// ---------------------------------------------------------------------------
void StepperArm::update() {
  stepperX.run();
  stepperY.run();
  stepperZ.run();
}

// ---------------------------------------------------------------------------
// emergencyStop() – stop all motors immediately, keep them enabled
// ---------------------------------------------------------------------------
void StepperArm::emergencyStop() {
  stepperX.stop();
  stepperY.stop();
  stepperZ.stop();
  // optional: digitalWrite(STEPPER_ENABLE, HIGH); // disable motors
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------
long StepperArm::angleToSteps(float angle) const {
  return (long)(angle * stepsPerDegree);
}

float StepperArm::stepsToAngle(long steps) const {
  return (float)steps / stepsPerDegree;
}

float StepperArm::clampAngle(float angle) const {
  if (angle < MIN_ANGLE_DEG) return MIN_ANGLE_DEG;
  if (angle > MAX_ANGLE_DEG) return MAX_ANGLE_DEG;
  return angle;
}
