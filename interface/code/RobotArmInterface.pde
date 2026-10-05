// ============================================================================
// ROBOT CONTROL & SENSOR VISUALIZATION INTERFACE
// Processing Application for Arduino-based Robotic Arm
// ============================================================================

import processing.serial.*;

// ============================================================================
// CONFIGURATION
// ============================================================================

final String SERIAL_PORT = "COM3"; // Change to your port (e.g., "/dev/ttyUSB0" on Linux)
final int BAUD_RATE = 115200;
final int GRAPH_HISTORY = 300; // samples to keep in history

// Joint angle constraints
final float[] ANGLE_MINS = {-180, 0, 0, 0, 0};
final float[] ANGLE_MAXS = {180, 180, 180, 180, 180};
final String[] JOINT_NAMES = {"Base", "Shoulder", "Elbow", "Pan", "Tilt"};

// ============================================================================
// GLOBAL STATE
// ============================================================================

Serial serial;
ControlPanel controlPanel;
SensorGraph sensorGraph;
RobotVisualizer robotViz;

float[] targetAngles = {0, 0, 0, 90, 90};
float[] currentAngles = {0, 0, 0, 90, 90};

float temperature = 0;
float humidity = 0;
float distance1 = 0;
float distance2 = 0;

ArrayList<Float> tempHistory = new ArrayList<Float>();
ArrayList<Float> humidityHistory = new ArrayList<Float>();
ArrayList<Float> dist1History = new ArrayList<Float>();
ArrayList<Float> dist2History = new ArrayList<Float>();

boolean connected = false;
String statusMessage = "Disconnected";

// ============================================================================
// SETUP & MAIN LOOP
// ============================================================================

void settings() {
  size(1600, 900);
}

void setup() {
  frameRate(60);
  initializeSerial();
  
  controlPanel = new ControlPanel();
  sensorGraph = new SensorGraph();
  robotViz = new RobotVisualizer();
}

void draw() {
  background(11, 12, 15);
  
  // Update serial communication
  if (connected) {
    readSerialData();
    sendControlCommand();
  }
  
  // Render interface
  controlPanel.display();
  robotViz.display(width * 0.5, 50);
  sensorGraph.display(width * 0.5, height * 0.55);
  
  // Status bar
  drawStatusBar();
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    // Reset all angles to home position
    targetAngles = new float[]{0, 0, 0, 90, 90};
  }
}

// ============================================================================
// SERIAL COMMUNICATION
// ============================================================================

void initializeSerial() {
  try {
    String[] ports = Serial.list();
    if (ports.length > 0) {
      println("Available ports:", ports);
      for (String port : ports) {
        if (port.contains(SERIAL_PORT) || port.contains("COM") || port.contains("ttyUSB")) {
          serial = new Serial(this, port, BAUD_RATE);
          serial.bufferUntil('\n');
          connected = true;
          statusMessage = "Connected to " + port;
          println("Connected to: " + port);
          return;
        }
      }
      // Fallback: try first port
      if (ports.length > 0) {
        serial = new Serial(this, ports[0], BAUD_RATE);
        serial.bufferUntil('\n');
        connected = true;
        statusMessage = "Connected to " + ports[0];
      }
    }
  } catch (Exception e) {
    println("Serial connection failed:", e.getMessage());
    statusMessage = "Serial Error: " + e.getMessage();
  }
}

void serialEvent(Serial p) {
  String data = p.readStringUntil('\n');
  if (data == null) return;
  
  data = data.trim();
  if (data.length() == 0) return;
  
  try {
    if (data.startsWith("S,")) {
      // Sensor data: S,temp,humidity,dist1,dist2
      String[] parts = data.substring(2).split(",");
      if (parts.length >= 4) {
        temperature = float(parts[0]);
        humidity = float(parts[1]);
        distance1 = float(parts[2]);
        distance2 = float(parts[3]);
        
        sensorGraph.addData(temperature, humidity, distance1, distance2);
      }
    } else {
      // Angle data: base,shoulder,elbow,pan,tilt
      String[] parts = data.split(",");
      if (parts.length >= 5) {
        currentAngles[0] = float(parts[0]);
        currentAngles[1] = float(parts[1]);
        currentAngles[2] = float(parts[2]);
        currentAngles[3] = float(parts[3]);
        currentAngles[4] = float(parts[4]);
      }
    }
  } catch (Exception e) {
    println("Parse error:", data, e.getMessage());
  }
}

void sendControlCommand() {
  // Send target angles as CSV
  String cmd = String.format("%.2f,%.2f,%.2f,%.0f,%.0f\n",
    targetAngles[0], targetAngles[1], targetAngles[2], targetAngles[3], targetAngles[4]);
  
  if (serial != null && serial.available() >= 0) {
    serial.write(cmd);
  }
}

// ============================================================================
// CONTROL PANEL (LEFT SIDE)
// ============================================================================

class ControlPanel {
  
  Slider[] sliders;
  Button homeBtn;
  
  ControlPanel() {
    sliders = new Slider[5];
    for (int i = 0; i < 5; i++) {
      sliders[i] = new Slider(
        30, 80 + i * 140, 300, 120,
        JOINT_NAMES[i],
        ANGLE_MINS[i], ANGLE_MAXS[i],
        (ANGLE_MINS[i] + ANGLE_MAXS[i]) / 2
      );
    }
    homeBtn = new Button(30, 800, 300, 50, "HOME POSITION");
  }
  
  void display() {
    // Panel background
    fill(18, 19, 23);
    stroke(45, 48, 56);
    strokeWeight(1);
    rect(0, 0, width * 0.45, height);
    
    // Title
    fill(255);
    textFont(createFont("Courier", 18));
    textAlign(LEFT);
    text("JOINT CONTROL", 30, 40);
    
    // Sliders
    for (int i = 0; i < 5; i++) {
      targetAngles[i] = sliders[i].display();
    }
    
    // Home button
    homeBtn.display();
    if (homeBtn.isPressed()) {
      for (int i = 0; i < 5; i++) {
        targetAngles[i] = ANGLE_MAXS[i] / 2;
      }
    }
    
    // Status info
    fill(100, 200, 100);
    textSize(12);
    textAlign(LEFT);
    text("R - Reset to Home", 30, 860);
  }
}

class Slider {
  float x, y, w, h;
  float minVal, maxVal, currentVal;
  String label;
  boolean isDragging = false;
  
  Slider(float x, float y, float w, float h, String label, float minVal, float maxVal, float defaultVal) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.minVal = minVal;
    this.maxVal = maxVal;
    this.currentVal = defaultVal;
  }
  
  float display() {
    // Background
    fill(25, 27, 32);
    stroke(45, 48, 56);
    strokeWeight(1);
    rect(x, y, w, h, 4);
    
    // Label and value
    fill(255);
    textFont(createFont("Courier", 13));
    textAlign(LEFT);
    text(label, x + 12, y + 25);
    
    fill(100, 200, 100);
    textSize(12);
    text(String.format("%.1f°", currentVal), x + 12, y + 45);
    
    // Slider track
    float trackY = y + 60;
    fill(40, 43, 50);
    rect(x + 12, trackY, w - 24, 6, 3);
    
    // Slider fill
    float sliderPos = map(currentVal, minVal, maxVal, x + 12, x + w - 12);
    fill(100, 200, 100);
    rect(x + 12, trackY, sliderPos - (x + 12), 6, 3);
    
    // Slider knob
    if (mousePressed && mouseX > x && mouseX < x + w && mouseY > trackY - 5 && mouseY < trackY + 15) {
      isDragging = true;
    }
    if (!mousePressed) {
      isDragging = false;
    }
    
    if (isDragging) {
      float normalized = constrain((mouseX - (x + 12)) / (w - 24), 0, 1);
      currentVal = lerp(minVal, maxVal, normalized);
    }
    
    fill(150, 220, 150);
    circle(sliderPos, trackY + 3, 12);
    
    return currentVal;
  }
}

class Button {
  float x, y, w, h;
  String label;
  boolean wasPressed = false;
  
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  void display() {
    boolean isHovered = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
    
    // Button background
    if (isHovered) {
      fill(100, 200, 100);
    } else {
      fill(40, 140, 60);
    }
    stroke(100, 200, 100);
    strokeWeight(2);
    rect(x, y, w, h, 4);
    
    // Text
    fill(11, 12, 15);
    textFont(createFont("Courier", 14));
    textAlign(CENTER, CENTER);
    text(label, x + w / 2, y + h / 2);
  }
  
  boolean isPressed() {
    boolean current = mousePressed && mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
    boolean result = current && !wasPressed;
    wasPressed = current;
    return result;
  }
}

// ============================================================================
// ROBOT VISUALIZER (TOP RIGHT)
// ============================================================================

class RobotVisualizer {
  
  void display(float offsetX, float offsetY) {
    // Panel background
    fill(18, 19, 23);
    stroke(45, 48, 56);
    strokeWeight(1);
    rect(offsetX, offsetY, width - offsetX, height * 0.45, 4);
    
    // Title
    fill(255);
    textFont(createFont("Courier", 16));
    textAlign(LEFT);
    text("ROBOT KINEMATICS", offsetX + 20, offsetY + 35);
    
    // Draw simplified 2D arm
    drawArm(offsetX + 100, offsetY + 200);
    
    // Angle readout
    drawAngleReadout(offsetX + 20, offsetY + 380);
  }
  
  void drawArm(float baseX, float baseY) {
    // Arm segments (simplified 2D projection)
    float segmentLength = 60;
    
    // Base rotation
    float baseAngle = radians(currentAngles[0]);
    
    // Draw base
    fill(100, 150, 200);
    circle(baseX, baseY, 16);
    
    // Shoulder
    float sx = baseX + sin(baseAngle) * segmentLength;
    float sy = baseY - cos(baseAngle) * segmentLength;
    stroke(100, 150, 200);
    strokeWeight(8);
    line(baseX, baseY, sx, sy);
    fill(100, 150, 200);
    circle(sx, sy, 12);
    
    // Elbow
    float shoulderAngle = baseAngle + radians(currentAngles[1]);
    float ex = sx + sin(shoulderAngle) * segmentLength;
    float ey = sy - cos(shoulderAngle) * segmentLength;
    stroke(150, 180, 220);
    line(sx, sy, ex, ey);
    fill(150, 180, 220);
    circle(ex, ey, 10);
    
    // Tool center
    float elbowAngle = shoulderAngle + radians(currentAngles[2]);
    float tx = ex + sin(elbowAngle) * (segmentLength * 0.6);
    float ty = ey - cos(elbowAngle) * (segmentLength * 0.6);
    stroke(200, 220, 100);
    strokeWeight(4);
    line(ex, ey, tx, ty);
    fill(200, 220, 100);
    circle(tx, ty, 8);
    
    // Pan/Tilt indicator (compass)
    float compassX = baseX - 100;
    float compassY = baseY - 80;
    
    fill(40, 43, 50);
    stroke(60, 65, 75);
    strokeWeight(1);
    rect(compassX - 40, compassY - 40, 80, 80, 4);
    
    fill(60, 65, 75);
    circle(compassX, compassY, 30);
    
    // Pan needle
    float panRad = radians(currentAngles[3]);
    stroke(100, 200, 100);
    strokeWeight(2);
    line(compassX, compassY, 
         compassX + sin(panRad) * 20, compassY - cos(panRad) * 20);
    
    fill(255);
    textFont(createFont("Courier", 9));
    textAlign(CENTER, CENTER);
    text("Pan", compassX, compassY + 50);
  }
  
  void drawAngleReadout(float x, float y) {
    fill(100);
    textFont(createFont("Courier", 11));
    textAlign(LEFT);
    for (int i = 0; i < 5; i++) {
      text(String.format("%-10s: %7.1f°", JOINT_NAMES[i], currentAngles[i]),
           x, y + i * 18);
    }
  }
}

// ============================================================================
// SENSOR GRAPH (BOTTOM RIGHT)
// ============================================================================

class SensorGraph {
  ArrayList<Float> tempHist = new ArrayList<Float>();
  ArrayList<Float> humidHist = new ArrayList<Float>();
  ArrayList<Float> dist1Hist = new ArrayList<Float>();
  ArrayList<Float> dist2Hist = new ArrayList<Float>();
  
  void addData(float temp, float humid, float d1, float d2) {
    tempHist.add(temp);
    humidHist.add(humid);
    dist1Hist.add(d1);
    dist2Hist.add(d2);
    
    while (tempHist.size() > GRAPH_HISTORY) {
      tempHist.remove(0);
      humidHist.remove(0);
      dist1Hist.remove(0);
      dist2Hist.remove(0);
    }
  }
  
  void display(float offsetX, float offsetY) {
    // Panel background
    fill(18, 19, 23);
    stroke(45, 48, 56);
    strokeWeight(1);
    rect(offsetX, offsetY, width - offsetX, height - offsetY, 4);
    
    // Title
    fill(255);
    textFont(createFont("Courier", 16));
    textAlign(LEFT);
    text("SENSOR DATA", offsetX + 20, offsetY + 35);
    
    float panelWidth = width - offsetX - 40;
    float graphHeight = (height - offsetY - 80) / 2;
    
    // Temperature/Humidity graph
    drawGraph(offsetX + 20, offsetY + 50, panelWidth, graphHeight,
              "Temperature (°C) / Humidity (%)",
              tempHist, humidHist, 0, 50, 0, 100,
              color(255, 100, 100), color(100, 150, 255));
    
    // Distance graph
    drawGraph(offsetX + 20, offsetY + 50 + graphHeight + 20, panelWidth, graphHeight,
              "Distance Sensors (cm)",
              dist1Hist, dist2Hist, 0, 400, 0, 400,
              color(100, 255, 100), color(255, 200, 100));
    
    // Current values
    fill(255);
    textFont(createFont("Courier", 11));
    textAlign(LEFT);
    text(String.format("Temp: %.1f°C  |  Humidity: %.1f%%  |  Dist1: %.1f cm  |  Dist2: %.1f cm",
                       temperature, humidity, distance1, distance2),
         offsetX + 20, offsetY + height - offsetY - 15);
  }
  
  void drawGraph(float x, float y, float w, float h, String title,
                 ArrayList<Float> data1, ArrayList<Float> data2,
                 float min1, float max1, float min2, float max2,
                 color col1, color col2) {
    
    // Title
    fill(200);
    textFont(createFont("Courier", 12));
    textAlign(LEFT);
    text(title, x, y - 8);
    
    // Graph background
    fill(25, 27, 32);
    stroke(45, 48, 56);
    strokeWeight(1);
    rect(x, y, w, h, 3);
    
    // Grid lines
    stroke(40, 43, 50);
    strokeWeight(1);
    for (int i = 0; i <= 5; i++) {
      float gridY = y + (h / 5) * i;
      line(x, gridY, x + w, gridY);
    }
    
    // Draw data1
    stroke(col1);
    strokeWeight(2);
    noFill();
    beginShape();
    for (int i = 0; i < data1.size(); i++) {
      float px = x + (w / GRAPH_HISTORY) * i;
      float py = y + h - map(data1.get(i), min1, max1, 0, h);
      vertex(px, py);
    }
    endShape();
    
    // Draw data2
    stroke(col2);
    strokeWeight(2);
    noFill();
    beginShape();
    for (int i = 0; i < data2.size(); i++) {
      float px = x + (w / GRAPH_HISTORY) * i;
      float py = y + h - map(data2.get(i), min2, max2, 0, h);
      vertex(px, py);
    }
    endShape();
    
    // Legend
    fill(col1);
    circle(x + w - 200, y + 10, 6);
    fill(200);
    textFont(createFont("Courier", 10));
    textAlign(LEFT);
    text("Data 1", x + w - 185, y + 14);
    
    fill(col2);
    circle(x + w - 80, y + 10, 6);
    fill(200);
    text("Data 2", x + w - 65, y + 14);
  }
}

// ============================================================================
// STATUS BAR (BOTTOM)
// ============================================================================

void drawStatusBar() {
  fill(25, 27, 32);
  stroke(45, 48, 56);
  strokeWeight(1);
  rect(0, height - 30, width, 30);
  
  fill(connected ? color(100, 200, 100) : color(200, 100, 100));
  circle(15, height - 15, 8);
  
  fill(200);
  textFont(createFont("Courier", 11));
  textAlign(LEFT);
  text(statusMessage, 35, height - 13);
  
  textAlign(RIGHT);
  text("FPS: " + (int)frameRate, width - 20, height - 13);
}