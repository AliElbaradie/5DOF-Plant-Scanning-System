
/*
===========================
Stepper Motor Control Code
===========================

Ali Elbaradie, xxxxxx  
Hassan H, xxxxxx  
Sahl W, xxxxxx  
Ismael T, xxxxxx  

This code was written as part of the experiment 'Bildverarbeitung'  
for the subject 'Mechatroniklabor,' under the supervision of  
Univ.-Prof. Dr.-Ing. D. Söffker and Mazen Zeno, M.Sc.

===========================
Code Description
===========================


This code controls five stepper motors using the AccelStepper library. 
Each motor operates within specific limits, and the movements are controlled 
via commands entered in the Serial Monitor.

**Functionality:**
1. During initialization:
   - Motor1 moves in the positive direction until limitSwitchX1 is triggered.
   - Motor2 moves in the positive direction until limitSwitchY1 is triggered.
   - Motor3 moves in the negative direction until limitSwitchZ1 is triggered.
   - Motor4 moves in the positive direction until limitSwitchTilt is triggered.
   - Motor5 moves in the positive direction until limitSwitchPan1 is triggered, 
     then moves back to MAX_STEPS_PAN / 2 to set its starting position.

2. After initialization, the motors can be moved by sending commands in the Serial Monitor.

**Command Format:**
- Input: <motor number> <steps>
- Example:
  - `1 500` - Moves motor1 forward by 500 steps.
  - `3 -200` - Moves motor3 backward by 200 steps.

**Motor Details:**
- Motor1: Moves within a maximum of 10,000 negative steps.
- Motor2: Moves within a maximum of 7,000 negative steps.
- Motor3: Moves within a maximum of 5,000 negative steps.
- Motor4: Moves within a maximum of 4,000 negative steps.
- Motor5: Moves only between position 0 and MAX_STEPS_PAN (1000), starting from 500.

**Limit Switches:**
- Motor1: limitSwitchX1 (Pin 53)
- Motor2: limitSwitchY1 (Pin 35)
- Motor3: limitSwitchZ1 (Pin 39)
- Motor4: limitSwitchTilt (Pin 47)
- Motor5: limitSwitchPan1 (Pin 43)

**Setup Process:**
- Each motor moves to its starting position as determined by its respective limit switch.
- Motor5's position is further adjusted to the center of its range.

**Important Notes:**
- Ensure all limit switches are correctly connected and functioning.
- Commands entered should be formatted as: <motor number> <steps>.
- Motors will not move beyond their defined limits.

**AccelStepper Library:**
- This code uses the AccelStepper library for precise, non-blocking stepper motor control.

*/

#include <AccelStepper.h>

// Define stepper motors and drivers
AccelStepper stepper1(1, 9, 8);   // Stepper X
AccelStepper stepper2(1, 7, 6);   // Stepper Y
AccelStepper stepper3(1, 5, 4);   // Stepper Z
AccelStepper stepper4(1, 13, 12); // Stepper Tilt
AccelStepper stepper5(1, 11, 10); // Stepper Pan

// Define limit switches
#define limitSwitchX1 53    // Stepper X1
#define limitSwitchY1 35    // Stepper Y1
#define limitSwitchZ1 39    // Stepper Z1
#define limitSwitchTilt 47  // Stepper Tilt
#define limitSwitchPan1 43  // Stepper Pan

// Variables to track negative steps for each motor
int negativeStepsX = 0;
int negativeStepsY = 0;
int negativeStepsZ = 0;
int negativeStepsTilt = 0;

const int MAX_NEGATIVE_STEPS = 25000;       // Maximum allowed negative steps for motor 1
const int MAX_NEGATIVE_STEPS_MOTOR2 = 5300; // Maximum allowed negative steps for motor 2
const int MAX_NEGATIVE_STEPS_MOTOR3 = 2000; // Maximum allowed negative steps for motor 3
const int MAX_NEGATIVE_STEPS_MOTOR4 = 800; // Maximum allowed negative steps for motor 4
const int MAX_STEPS_PAN = 800;             // Maximum steps for motor 5 (Pan)

void setup() {
  // Initialize Serial Monitor
  Serial.begin(9600);
  Serial.println("Initializing motors...");

  // Set maximum speed and acceleration for all steppers
  stepper1.setMaxSpeed(200);
  stepper1.setAcceleration(2000);

  stepper2.setMaxSpeed(40);
  stepper2.setAcceleration(2000);

  stepper3.setMaxSpeed(40);
  stepper3.setAcceleration(2000);

  stepper4.setMaxSpeed(100);
  stepper4.setAcceleration(500);

  stepper5.setMaxSpeed(50);
  stepper5.setAcceleration(500);

  // Invert step and direction pins for all steppers
  stepper1.setPinsInverted(true, true, false);
  stepper2.setPinsInverted(true, true, false);
  stepper3.setPinsInverted(true, true, false);
  stepper4.setPinsInverted(true, true, false);
  stepper5.setPinsInverted(true, true, false);

  // Configure limit switch pins as inputs with pull-up resistors
  pinMode(limitSwitchX1, INPUT_PULLUP);
  pinMode(limitSwitchY1, INPUT_PULLUP);
  pinMode(limitSwitchZ1, INPUT_PULLUP);
  pinMode(limitSwitchTilt, INPUT_PULLUP);
  pinMode(limitSwitchPan1, INPUT_PULLUP);

  // Initialize motors' positions
  initializeMotors();

  Serial.println("Initialization complete.");
  Serial.println("Enter the motor number (1, 2, 3, 4, or 5) and steps to move (negative for reverse):");
}

void loop() {
  // Check if data is available in the Serial Monitor
  if (Serial.available() > 0) {
    // Read input
    String input = Serial.readStringUntil('\n');
    input.trim(); // Remove extra spaces or newlines

    // Split the input into motor number and steps
    int spaceIndex = input.indexOf(' '); // Find the space separator
    if (spaceIndex == -1) {
      Serial.println("Invalid input format. Use: <motor number> <steps>");
      return;
    }

    int motorNumber = input.substring(0, spaceIndex).toInt(); // Extract motor number
    int stepsToMove = input.substring(spaceIndex + 1).toInt(); // Extract steps to move

    // Validate motor number
    if (motorNumber < 1 || motorNumber > 5) {
      Serial.println("Invalid motor number. Use 1, 2, 3, 4, or 5.");
      return;
    }

    // Call the corresponding motor's move function
    switch (motorNumber) {
      case 1:
        moveMotor(stepper1, stepsToMove, negativeStepsX, MAX_NEGATIVE_STEPS);
        break;
      case 2:
        moveMotor(stepper2, stepsToMove, negativeStepsY, MAX_NEGATIVE_STEPS_MOTOR2);
        break;
      case 3:
        moveMotor3(stepper3, stepsToMove, negativeStepsZ, MAX_NEGATIVE_STEPS_MOTOR3);
        break;
      case 4:
        moveMotor3(stepper4, stepsToMove, negativeStepsTilt, MAX_NEGATIVE_STEPS_MOTOR4);
        //moveMotor(stepper4, stepsToMove, negativeStepsTilt, MAX_NEGATIVE_STEPS_MOTOR4);
        break;
      case 5:
        movePanMotor(stepper5, stepsToMove);
        break;
    }
  }
}

void initializeMotors() {
  // Move motor1 in positive direction until limitSwitchX1 is activated
  stepper1.moveTo(1e6); // Move to a very large position
  while (true) {
    if (digitalRead(limitSwitchX1) == LOW) { // Switch is pressed
      stepper1.stop();                       // Stop the motor
      stepper1.runToPosition();              // Ensure a clean stop
      stepper1.setCurrentPosition(0);        // Set current position as 0
      break;                                 // Exit the loop
    }
    stepper1.run(); // Continue moving
  }

  // Move motor2 in positive direction until limitSwitchY1 is activated
  stepper2.moveTo(1e6); // Move to a very large position
  while (true) {
    if (digitalRead(limitSwitchY1) == LOW) { // Switch is pressed
      stepper2.stop();
      stepper2.runToPosition();
      stepper2.setCurrentPosition(0);
      break;
    }
    stepper2.run();
  }

  // Move motor3 in negative direction until limitSwitchZ1 is activated
  stepper3.moveTo(-1e6); // Move to a very large negative position
  while (true) {
    if (digitalRead(limitSwitchZ1) == LOW) { // Switch is pressed
      stepper3.stop();
      stepper3.runToPosition();
      stepper3.setCurrentPosition(0);
      break;
    }
    stepper3.run();
  }

  // Move motor4 in positive direction until limitSwitchTilt is activated
  stepper4.moveTo(-1e6); // Move to a very large position
  while (true) {
    if (digitalRead(limitSwitchTilt) == LOW) { // Switch is pressed
      stepper4.stop();
      stepper4.runToPosition();
      stepper4.setCurrentPosition(0);
      break;
    }
    stepper4.run();
  }

  // Move motor5 in positive direction until limitSwitchPan1 is activated
  stepper5.moveTo(1e6); // Move to a very large position
  while (true) {
    if (digitalRead(limitSwitchPan1) == LOW) { // Switch is pressed
      stepper5.stop();
      stepper5.runToPosition();
      break;
    }
    stepper5.run();
  }

  // Move motor5 back by MAX_STEPS_PAN / 2
  stepper5.moveTo(stepper5.currentPosition() - (MAX_STEPS_PAN / 2));
  while (stepper5.distanceToGo() != 0) {
    stepper5.run();
  }
  stepper5.setCurrentPosition(MAX_STEPS_PAN / 2);
}

void moveMotor(AccelStepper &stepper, int steps, int &negativeSteps, int maxNegativeSteps) {
  // Check movement permissions based on negativeSteps and maxNegativeSteps
  if (steps < 0) {
    if (negativeSteps + abs(steps) > maxNegativeSteps) {
      Serial.println("Cannot move further in the negative direction. Input exceeds Maximum limit.");
      return;
    }
    negativeSteps += abs(steps); // Update negative steps
  } else if (steps > 0) {
    if (negativeSteps - steps < 0) {
      Serial.println("Cannot move further in the positive direction. Input exceeds Position zero.");
      return;
    }
    negativeSteps -= steps; // Update negative steps
  } else {
    Serial.println("No movement specified.");
    return;
  }

  // Move the motor the specified number of steps
  stepper.moveTo(stepper.currentPosition() + steps);

  // Perform the motion
  while (stepper.distanceToGo() != 0) {
    stepper.run(); // Non-blocking motion
  }

  // Notify completion
  Serial.print("Moved ");
  Serial.print(steps);
  Serial.println(" steps.");
  Serial.print("Current negative steps: ");
  Serial.println(negativeSteps);
}

void movePanMotor(AccelStepper &stepper, int steps) {
  int targetPosition = stepper.currentPosition() + steps;

  // Ensure the target position is within bounds (0 to MAX_STEPS_PAN)
  if (targetPosition < 0 || targetPosition > MAX_STEPS_PAN) {
    Serial.println("Cannot move. Target position is out of bounds (0 to 1000).");
    return;
  }

  // Move the motor the specified number of steps
  stepper.moveTo(targetPosition);

  // Perform the motion
  while (stepper.distanceToGo() != 0) {
    stepper.run(); // Non-blocking motion
  }

  // Notify completion
  Serial.print("Moved ");
  Serial.print(steps);
  Serial.println(" steps.");
  Serial.print("Current position: ");
  Serial.println(stepper.currentPosition());
}

// Add a new function for Motor 3
void moveMotor3(AccelStepper &stepper, int steps, int &negativeSteps, int maxNegativeSteps) {
  // Check movement permissions based on negativeSteps and maxNegativeSteps
  if (steps > 0) {
    if (negativeSteps + steps > maxNegativeSteps) {
      Serial.println("Cannot move further in the Positive direction. Input exceeds Maximum limit.");
      return;
    }
    negativeSteps += steps; // Update negative steps
  } else if (steps < 0) {
    if (negativeSteps - abs(steps) < 0) {
      Serial.println("Cannot move further in the Negative direction. Input exceeds Position zero.");
      return;
    }
    negativeSteps -= abs(steps); // Update negative steps
  } else {
    Serial.println("No movement specified.");
    return;
  }

  // Move the motor the specified number of steps
  stepper.moveTo(stepper.currentPosition() + steps);

  // Perform the motion
  while (stepper.distanceToGo() != 0) {
    stepper.run(); // Non-blocking motion
  }

  // Notify completion
  Serial.print("Moved ");
  Serial.print(steps);
  Serial.println(" steps.");
  Serial.print("Current Position: ");
  Serial.println(negativeSteps);
}
