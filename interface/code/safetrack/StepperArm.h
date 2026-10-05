#ifndef STEPPER_ARM_H
#define STEPPER_ARM_H

#include <AccelStepper.h>
#include "config.h"
#include "types.h"

/**
 * @brief Manages the three stepper motors (base, shoulder, elbow)
 *        connected via a CNC Shield V3.
 * 
 * Uses AccelStepper in DRIVER mode (step + direction pins).
 */
class StepperArm {
public:
  StepperArm();

  /**
   * @brief Initialise stepper objects, set speed/acceleration, enable drivers.
   *        Must be called once in setup().
   */
  void begin();

  /**
   * @brief Set the target angle for a stepper joint.
   * 
   * @param joint The motor index (BASE, SHOULDER, ELBOW).
   * @param angle Target angle in degrees (clamped to [MIN_ANGLE_DEG, MAX_ANGLE_DEG]).
   */
  void setTargetAngle(MotorIndex joint, float angle);

  /**
   * @brief Get the current computed angle of a stepper joint.
   * 
   * @param joint Motor index.
   * @return float Current angle in degrees.
   */
  float getCurrentAngle(MotorIndex joint) const;

  /**
   * @brief Non-blocking update: call frequently in loop() to run each motor.
   *        Moves motors towards their target positions.
   */
  void update();

  /**
   * @brief Immediately stop all stepper motors (disable outputs if desired).
   */
  void emergencyStop();

private:
  AccelStepper stepperX;   // BASE
  AccelStepper stepperY;   // SHOULDER
  AccelStepper stepperZ;   // ELBOW

  float stepsPerDegree;    // computed from MICROSTEPS & STEPS_PER_REV
  bool enabled;

  /**
   * @brief Convert a joint angle to an absolute step count.
   */
  long angleToSteps(float angle) const;

  /**
   * @brief Convert current step position back to degrees.
   */
  float stepsToAngle(long steps) const;

  /**
   * @brief Clamp angle to defined limits.
   */
  float clampAngle(float angle) const;
};

#endif
