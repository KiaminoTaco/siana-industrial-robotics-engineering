/*
 * SIANA — RobotControlerInterface
 * Companion control abstraction for RobotArmInterface.pde.
 * Portfolio integration layer based on the supplied interface protocol.
 */

import processing.serial.*;

class RobotControlerInterface {

  PApplet parent;
  Serial serial;

  boolean connected = false;
  String statusMessage = "Disconnected";

  final int BAUD_RATE = 115200;

  float[] targetAngles = {0, 0, 0, 90, 90};
  float[] currentAngles = {0, 0, 0, 90, 90};

  float temperature = 0;
  float humidity = 0;
  float distance1 = 0;
  float distance2 = 0;

  RobotControlerInterface(PApplet parent) {
    this.parent = parent;
  }

  boolean connect(String portName) {
    try {
      serial = new Serial(parent, portName, BAUD_RATE);
      serial.bufferUntil('\n');
      connected = true;
      statusMessage = "Connected to " + portName;
      return true;
    } catch (Exception e) {
      connected = false;
      statusMessage = "Serial Error: " + e.getMessage();
      return false;
    }
  }

  void disconnect() {
    if (serial != null) {
      serial.stop();
      serial = null;
    }
    connected = false;
    statusMessage = "Disconnected";
  }

  void setTargetAngles(float base, float shoulder, float elbow,
                       float pan, float tilt) {
    targetAngles[0] = base;
    targetAngles[1] = shoulder;
    targetAngles[2] = elbow;
    targetAngles[3] = pan;
    targetAngles[4] = tilt;
  }

  String buildCommand() {
    return String.format(
      "%.2f,%.2f,%.2f,%.0f,%.0f\n",
      targetAngles[0],
      targetAngles[1],
      targetAngles[2],
      targetAngles[3],
      targetAngles[4]
    );
  }

  void sendCommand() {
    if (connected && serial != null) {
      serial.write(buildCommand());
    }
  }

  boolean parseMessage(String message) {
    if (message == null) return false;

    String data = trim(message);
    if (data.length() == 0) return false;

    try {
      if (data.startsWith("S,")) {
        String[] parts = data.substring(2).split(",");

        if (parts.length >= 4) {
          temperature = float(parts[0]);
          humidity = float(parts[1]);
          distance1 = float(parts[2]);
          distance2 = float(parts[3]);
          return true;
        }
        return false;
      }

      String[] parts = data.split(",");

      if (parts.length >= 5) {
        currentAngles[0] = float(parts[0]);
        currentAngles[1] = float(parts[1]);
        currentAngles[2] = float(parts[2]);
        currentAngles[3] = float(parts[3]);
        currentAngles[4] = float(parts[4]);
        return true;
      }
    } catch (Exception e) {
      statusMessage = "Parse Error";
    }

    return false;
  }

  boolean isConnected() {
    return connected && serial != null;
  }
}
