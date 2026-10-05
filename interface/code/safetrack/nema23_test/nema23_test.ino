// ===============================
// TEST NEMA23 + TB6600
// CNC SHIELD (Z AXIS)
// ===============================

#define STEP_PIN 4   // Z_STEP sur CNC Shield (Arduino Mega dépend du mapping)
#define DIR_PIN 7    // Z_DIR

int delayTime = 800; // vitesse (plus petit = plus rapide)

void setup() {
  pinMode(STEP_PIN, OUTPUT);
  pinMode(DIR_PIN, OUTPUT);

  digitalWrite(DIR_PIN, HIGH); // direction initiale
}

void loop() {

  // Rotation dans un sens
  digitalWrite(DIR_PIN, HIGH);

  for (int i = 0; i < 2000; i++) {
    digitalWrite(STEP_PIN, HIGH);
    delayMicroseconds(delayTime);
    digitalWrite(STEP_PIN, LOW);
    delayMicroseconds(delayTime);
  }

  delay(1000);

  // Changement de direction
  digitalWrite(DIR_PIN, LOW);

  for (int i = 0; i < 2000; i++) {
    digitalWrite(STEP_PIN, HIGH);
    delayMicroseconds(delayTime);
    digitalWrite(STEP_PIN, LOW);
    delayMicroseconds(delayTime);
  }

  delay(1000);
}
