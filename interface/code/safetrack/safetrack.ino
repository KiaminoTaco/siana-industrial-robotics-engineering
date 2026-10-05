/*
 * RobotSystem.ino - Main firmware for the robotic arm.
 * 
 * Hardware:
 *   - 2x NEMA17 + 1x NEMA23 on CNC Shield V3
 *   - 2x micro servos (wrist & gripper)
 *   - DHT22 temperature/humidity sensor
 *   - 2x HC-SR04 ultrasonic distance sensors
 * 
 * Publishes the five motor angles (base, shoulder, elbow, wrist, gripper)
 * via serial at 115200 baud, every PUBLISH_INTERVAL milliseconds.
 */

#include "config.h"
#include "types.h"
#include "StepperArm.h"

// ---- Global objects ----
StepperArm stepperArm;
// Placeholders for classes that will be added later:
/*
ServoController servos;
DHT22Sensor dht;
Ultrasonic ultrasonic1, ultrasonic2;
RobotController robot;
Scheduler scheduler;
*/

// ---- Timing for serial publication ----
unsigned long lastPublishTime = 0;

void setup() {
  Serial.begin(SERIAL_BAUD);
  while (!Serial);  // optional for native USB boards

  stepperArm.begin();
  // When implemented:
  // servos.begin();
  // dht.begin();
  // ultrasonic1.begin(TRIG_PIN_1, ECHO_PIN_1);
  // ultrasonic2.begin(TRIG_PIN_2, ECHO_PIN_2);
  // robot.begin(stepperArm, servos, ...);
  // scheduler.begin();

  Serial.println("Robot system initialised.");
}

void loop() {
  // 1. Always update motors (NON-blocking)
  stepperArm.update();

  // 2. Read serial command
  if (Serial.available()) {
    String input = Serial.readStringUntil('\n');
    input.trim();  // 🔥 removes spaces and hidden characters

    Serial.print("Received: [");
    Serial.print(input);
    Serial.println("]");

    // 3. Parse safely (robust method)
    int firstComma = input.indexOf(',');
    int secondComma = input.indexOf(',', firstComma + 1);

    if (firstComma > 0 && secondComma > firstComma) {
      float b = input.substring(0, firstComma).toFloat();
      float s = input.substring(firstComma + 1, secondComma).toFloat();
      float e = input.substring(secondComma + 1).toFloat();

      Serial.println("Parsing OK");

      stepperArm.setTargetAngle(BASE, b);
      stepperArm.setTargetAngle(SHOULDER, s);
      stepperArm.setTargetAngle(ELBOW, e);

    } else {
      Serial.println("❌ Format error! Use: 10,10,10");
    }
  }

  // 4. (Optional) publish angles every 500 ms
  static unsigned long lastPublishTime = 0;
  if (millis() - lastPublishTime >= 500) {

    float base     = stepperArm.getCurrentAngle(BASE);
    float shoulder = stepperArm.getCurrentAngle(SHOULDER);
    float elbow    = stepperArm.getCurrentAngle(ELBOW);

    Serial.print(base, 2);
    Serial.print(",");
    Serial.print(shoulder, 2);
    Serial.print(",");
    Serial.print(elbow, 2);
    Serial.println(",0.00,0.00");

    lastPublishTime = millis();
  }
}

/**
 * @brief Prints the current angles of all five joints as CSV:
 *        base,shoulder,elbow,wrist,gripper
 *        followed by a newline.
 */
void publishJointAngles() {
  JointAngles angles;

  // Stepper joints (angles computed from motor steps)
  angles.base     = stepperArm.getCurrentAngle(BASE);
  angles.shoulder = stepperArm.getCurrentAngle(SHOULDER);
  angles.elbow    = stepperArm.getCurrentAngle(ELBOW);

  // Servo joints – placeholder: read 0.0 until ServoController is ready
  // angles.wrist   = servos.getAngle(WRIST);
  // angles.gripper = servos.getAngle(GRIPPER);
  angles.wrist   = 0.0f;
  angles.gripper = 0.0f;

  // Print in CSV format
  Serial.print(angles.base, 2);
  Serial.print(',');
  Serial.print(angles.shoulder, 2);
  Serial.print(',');
  Serial.print(angles.elbow, 2);
  Serial.print(',');
  Serial.print(angles.wrist, 2);
  Serial.print(',');
  Serial.println(angles.gripper, 2);
}
