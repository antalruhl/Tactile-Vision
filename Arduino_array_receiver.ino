int pin_count = 9;
int pins[]  = {0, 0, 0, 0,0,0, 0, 0, 0};
int counter = 0;
int mapping[] = {5, 10, 3, 7, 4, 8, 9, 2, 6};

int in = 0;
int bytesRead = 0;

void setup() {
  Serial.begin(9600);

  for (int i = 2; i < 14; i++) {
    pinMode(i, OUTPUT);
  }

  for (int i = 0; i < pin_count; i++) {
        digitalWrite(mapping[i], pins[i]);
      }
}

void loop() {
  for(int i = 0; i <= 8; i++) {
     while (!Serial.available());  // Wait for a character to arrive
     pins[i] = Serial.read();
  }

  for (int i = 0; i < pin_count; i++) {
    digitalWrite(mapping[i], pins[i] > 0 ? HIGH : LOW);
    //analogWrite(mapping[i], pins[i]);
  }
}
