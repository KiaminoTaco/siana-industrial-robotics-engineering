#ifndef TYPES_H
#define TYPES_H

/**
 * @brief Holds the current/target angles of all five joints.
 * 
 * Joint indices:
 *   0 - Base   (stepper NEMA17)
 *   1 - Shoulder (stepper NEMA17)
 *   2 - Elbow    (stepper NEMA23)
 *   3 - Wrist    (micro servo)
 *   4 - Gripper  (micro servo)
 */
struct JointAngles {
  float base;
  float shoulder;
  float elbow;
  float wrist;
  float gripper;
};

/**
 * @brief Unified motor indices used internally.
 */
enum MotorIndex : uint8_t {
  BASE      = 0,
  SHOULDER  = 1,
  ELBOW     = 2,
  WRIST     = 3,
  GRIPPER   = 4
};

#endif
