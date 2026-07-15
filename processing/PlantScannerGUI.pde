import controlP5.*;
import processing.serial.*;
import meter.*;

Serial myPort;
ControlP5 cp5;
Meter m, m2;

Textlabel myTextlabelA;
Textfield t1, t2, t3, t4, t5, t6,t7, t8, t9, t10, t11, t12;

float displayPath1,displayPath2,displayPath3,displayPath4,displayPath5;

char HEADER = 'H';    // character to identify the start of a message
char HEADER2 = 'T'; 
short LF = 10;        // ASCII linefeed
int ledStatus = 0;
float error_FeedbackX, error_FeedbackY, error_FeedbackZ, error_FeedbackPan, error_FeedbackTilt;
float temp, hum;
String [] dataIn = new String[6];
String[] message;
String[] list;


void setup() {
  
  myPort= new Serial(this, "COM6", 9600);
  size(1300,680);
  smooth();   
  PFont p= createFont("calibri light", 18, true);   
  ControlFont font = new ControlFont(p);
  cp5 = new ControlP5(this);
  
  myTextlabelA = cp5.addTextlabel("label")
      .setText("5 DOF closed loop motion platform control")
      .setPosition(300,30)
      .setColorValue(0xffffff00)
      .setFont(createFont("BookmanOldStyle-Bold",40))
      ;

  t1 = cp5.addTextfield("inputx")
     .setPosition(20,100)
     .setLabel("X Position [0-170][cm]")
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
     .setInputFilter(ControlP5.INTEGER)
     .setId(1)
     //.setColor(color(255,0,0))
     ;
 t2 = cp5.addTextfield("inputy")
     .setPosition(20,180)
     .setLabel("Y Position [0-150][cm]")
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
     .setInputFilter(ControlP5.INTEGER)
     .setId(2)
     //.setColor(color(255,0,0))
     ;
 t3 = cp5.addTextfield("inputz")
     .setPosition(20,260)
     .setLabel("Z Position [0-70][cm]")
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
     .setInputFilter(ControlP5.INTEGER)
     .setId(3)
     //.setColor(color(255,0,0))
     ; 
 t4 = cp5.addTextfield("inputpan")
     .setPosition(20,340)
     .setLabel("Pan Angle [-90°,90°]")
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
    // .setInputFilter(ControlP5.INTEGER)
     .setId(4)
     //.setColor(color(255,0,0))
     ;
 t5 = cp5.addTextfield("inputtilt")
     .setPosition(20,420)
     .setLabel("Tilt Angle [-45°,45°]")
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
    // .setInputFilter(ControlP5.INTEGER)
     .setId(5)
     //.setColor(color(255,0,0))
     ;    
     
  t6 = cp5.addTextfield("Info1")
     .setPosition(20,500)
     .setLabel("Info1")
     .setSize(260,40)
     .setFont(font)
     .setText("Please enter any values in range")
     //.setColor(color(255,0,0))
     ;    

 t7 = cp5.addTextfield("feedbackx")
     .setPosition(460,100)
     .setSize(260,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
     .setInputFilter(ControlP5.INTEGER)
     .setId(1)
     .setText("X axis feedback indicator")
     //.setColor(color(255,0,0))
     ;
    
 t8 = cp5.addTextfield("feedbacky")
     .setPosition(460,180)
     .setSize(260,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
     .setInputFilter(ControlP5.INTEGER)
     .setId(2)
      .setText("Y axis feedback indicator")
     //.setColor(color(255,0,0))
     ;
 t9 = cp5.addTextfield("feedbackz")
     .setPosition(460,260)
     .setLabel("Z axis feedback")
     .setSize(260,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
     .setInputFilter(ControlP5.INTEGER)
     .setId(3)
      .setText("Z axis feedback indicator")
     //.setColor(color(255,0,0))
     ; 
 t10 = cp5.addTextfield("feedbackpan")
     .setPosition(460,340)
     .setSize(260,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
    // .setInputFilter(ControlP5.INTEGER)
     .setId(4)
     .setText("Pan movement feedback indicator")
     //.setColor(color(255,0,0))
     ;
 t11 = cp5.addTextfield("feedbacktilt")
     .setPosition(460,420)
     .setSize(260,40)
     .setFont(font)
     .setFocus(true)
     .setAutoClear(false)
    // .setInputFilter(ControlP5.INTEGER)
     .setId(5)
     .setText("Tilt movement feedback indicator")
     //.setColor(color(255,0,0))
     ;    
     
  t12 = cp5.addTextfield("Info2")
     .setPosition(460,500)
     .setLabel("Info2")
     .setSize(260,40)
     .setFont(font)
     .setText("Feedback info will be displayed here")
     //.setColor(color(255,0,0))
     ;  
     
   //add 2 buttons    
   cp5.addButton("clear")    // name of button
   .setPosition(20,590)    // x and y coord
   .setSize(100,60)        // (width,height)
   .setFont(font)
   .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
   ;
    cp5.addButton("action")  // name of button
   .setPosition(180,590)    // x and y coord
   .setSize(100,60)        // (width,height)
   .setFont(font)
   .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
   ;

  //temperature meter
  m = new Meter(this, 800, 100);  // here 25, 10 are x and y coordinates of meter's upper left corner
  
  m.setTitleFontSize(20);
  m.setTitleFontName("Arial bold");
  m.setTitle("Temperature (C)");
  
  //Change meter scale values
  String[] scaleLabels = {"0", "10", "20", "30", "40", "50", "60", "70", "80"};
  m.setScaleLabels(scaleLabels);
  m.setScaleFontSize(18);
  m.setScaleFontName("Times new roman bold");
  m.setScaleFontColor(color(200, 30, 70));
  
  //display the value of meter
  m.setDisplayDigitalMeterValue(true);
  
  //modifications to look nice
  m.setArcColor(color(141, 113, 178));
  m.setArcThickness(15); 
  m.setMaxScaleValue(80);
  m.setMinInputSignal(0);
  m.setMaxInputSignal(80);
  m.setNeedleThickness(3);
  
  // HUMIDITY METER
  // refference from first meter
  int mx = m.getMeterX(); // x coordinate of m
  int my = m.getMeterY(); // y coordinate of m
  int mh = m.getMeterHeight();
  
  m2 = new Meter(this, mx, my + mh + 20);
  
  m2.setTitleFontSize(20);
  m2.setTitleFontName("Arial bold");
  m2.setTitle("Humidity (%)");
  
  // Change meter scale values
  String[] scaleLabels2 = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
  m2.setScaleLabels(scaleLabels2);
  m2.setScaleFontSize(18);
  m2.setScaleFontName("Times new roman bold");
  m2.setScaleFontColor(color(200, 30, 70));
  
  //display the value of meter
  m2.setDisplayDigitalMeterValue(true);
  
  //modifications to look nice
  m2.setArcColor(color(141, 113, 178));
  m2.setArcThickness(15);
  m2.setMaxScaleValue(100);
  m2.setMinInputSignal(0);
  m2.setMaxInputSignal(100);
  m2.setNeedleThickness(3);
   
}

  
void draw() {
   background(120,120,120);
   
   fill(255,255,255);
   rect(460,575,260,70);
   textSize(18);
   fill(51, 255, 51); text("Green: no losing or oversteps",470,595);
   fill(255,0,0); text("Red: losing or oversteps",470,635);
   
   
   //temp = random(80);
  // hum = random(100);
   // println("Temperature: " + temp + " C  " + "Humidity: " + hum + " %");


    
   if (myPort.available() > 0) { //as long as there is data coming from serial port, read it and store it   
   String message = myPort.readStringUntil('\n'); // read serial data 

   if(message != null)
   {
    print("message");
    String [] dataIn = split(message, ',') ; // Split the comma-separated message
    if(dataIn[0].charAt(0) == HEADER)       // check for header character in the first field
    {
      error_FeedbackX = float(dataIn[1]);
      println("error_FeedbackX :" +error_FeedbackX);
      t7.setText("error_FeedbackX :" +error_FeedbackX);
      error_FeedbackY = float(dataIn[2]);
      println("error_FeedbackY :" +error_FeedbackY);
      t8.setText("error_FeedbackY :" +error_FeedbackY);
      error_FeedbackZ = float(dataIn[3]);
      println("error_FeedbackZ :" +error_FeedbackZ);
      t9.setText("error_FeedbackZ :" +error_FeedbackZ);
      error_FeedbackPan = float(dataIn[4]);
      println("error_FeedbackPan :" +error_FeedbackPan);
      t10.setText("error_FeedbackPan :" +error_FeedbackPan);
      error_FeedbackTilt = float(dataIn[5]);
      println("error_FeedbackTilt :" +error_FeedbackTilt);
      t11.setText("error_FeedbackTilt :" +error_FeedbackTilt);
      temp = float(dataIn[6]);
      println("Temperature :" +temp);
      hum = float(dataIn[7]);
      println("Humility :" +hum);
          
    }
    
   }
 }

   m.updateMeter(int(temp));
   m2.updateMeter(int(hum));

   
    if(abs(error_FeedbackX) < 1.5){
   fill(51, 255, 51);
    }
    else{
      fill(0, 0, 255);
    }
   ellipse(400,120,60,60);        // FeedbackX Kreis ausgeben
   
    if(abs(error_FeedbackY) < 1.5){
   fill(51, 255, 51);
    }
    else{
      fill(0, 0, 255);
    }
   ellipse(400,200,60,60);        // FeedbackY ausgeben
   
  if(abs(error_FeedbackZ) < 1.5){
   fill(51, 255, 51);
    }
    else{
      fill(0, 0, 255);
    }
   ellipse(400,280,60,60);        // FeedbackZ ausgeben
  
  
   if(abs(error_FeedbackPan) < 3.0){
   fill(51, 255, 51);
    }
    else{
      fill(0, 0, 255);
    }
   ellipse(400,360,60,60);        // Feedbackpan ausgeben
   
   if(abs(error_FeedbackTilt) < 3.0){
   fill(51, 255, 51);
    }
    else{
      fill(0, 0, 255);
    }
   ellipse(400,440,60,60);        // feedbacktilt ausgeben
   
   if(abs(error_FeedbackX) < 1.5 && abs(error_FeedbackY) < 1.5 && abs(error_FeedbackZ) < 1.5 && abs(error_FeedbackPan) < 1.5 && abs(error_FeedbackTilt) < 1.5){
   t12.setText("Donot need feedback");
   }
   
   else{
    t12.setText("Need feedback"); 
   }

}


void clear(){
  t1.clear();t2.clear();t3.clear();
  t4.clear();t5.clear();
}

void action() {
   displayPath1 = float(t1.getText());
   displayPath2 = float(t2.getText());
   displayPath3 = float(t3.getText());
   displayPath4 = float(t4.getText());
   displayPath5 = float(t5.getText());
  
    if((displayPath1 >= 0 && displayPath1 <= 170) && (displayPath2 >= 0 && displayPath2 <= 150)
    && (displayPath3 >= 0 && displayPath3 <= 70) && (displayPath4 >= -90 && displayPath4 <= 90)
    && (displayPath5 >= -45 && displayPath5 <= 45)){
    t6.setColor(color(255, 255, 255));  
    t6.setText("Running");
    
    myPort.write('<');
    myPort.write(t1.getText());
    myPort.write(',');
    myPort.write(t2.getText());
    myPort.write(',');
    myPort.write(t3.getText());
    myPort.write(',');
    myPort.write(t4.getText());
    myPort.write(',');
    myPort.write(t5.getText());
    myPort.write('>');
    }  
  
    else{
     t6.setColor(color(255,0,0));
     t6.setText("Warning: Input is out of range!");
     }
     
   
  }
   
