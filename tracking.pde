import processing.serial.*; 
Serial arduino; 

String stringAccX;
String stringAccY;

String stringAccXdis;
String stringAccYdis;

int[] accX = new int[600];
float inAccX;
int[] accY = new int[600];
float inAccY;

int[] accXdis = new int[600];
float inAccXdis;
int[] accYdis = new int[600];
float inAccYdis;

//convert all axis
int maxAngle = 180;
int oldx=0, oldy=0;
int first=1;

void convert()
{
  //convert the accelerometer x-axis
 if (stringAccX != null) 
 {
   //trim off any whitespace:
   stringAccX = trim(stringAccX);
   //convert to an float and map to the screen height:
   inAccX = int(stringAccX);
   inAccX = map(inAccX, maxAngle, -maxAngle, 0, width);
   accX[accX.length-1] = (int)inAccX; //why putting in the last position?????
 }
 //convert the accelerometer y-axis
 if (stringAccY != null) 
 {
   //trim off any whitespace:
   stringAccY = trim(stringAccY);
   //convert to an float and map to the screen height:
   inAccY = int(stringAccY);
   inAccY = map(inAccY, maxAngle, -maxAngle, 0, height);
   accY[accY.length-1] =(int)inAccY;
 }
 
}

void drawAxisX()
{
  //draw acceleromter x-axis
  noFill();
  stroke(0,129,230);//light blue
  //redraw everything
  beginShape();
    if(first==1) //<>//
    {
      //vertex(accX[accX.length-1], accY[accY.length-1]);
      oldx=accX[accX.length-1];
      oldy=accY[accY.length-1];
      first=0;
    }
    else
    {
      //vertex(accX[accX.length-1], accY[accY.length-1]);
      line(oldx, oldy, accX[accX.length-1], accY[accY.length-1]); //<>//
      oldx=accX[accX.length-1];
      oldy=accY[accY.length-1];
      //first=0;
    }
  endShape();   
}

void setup()
{
  size(600,400);
  arduino = new Serial(this, Serial.list()[1], 9600);
  arduino.bufferUntil('\n');
  
  /*for(int i=0;i<600;i++)//center all variables
  {
   accX[i] = 0;
   accY[i] = 0;
   //accXdis[i]=0;
   //accYdis[i]=0;
  }*/ 
}

void draw()
{ 
  //background(255);
  //convert();
  //drawAxisX();
}

void serialEvent (Serial arduino)
{
 //get the ASCII strings:
 stringAccX = arduino.readStringUntil('\t');
 stringAccY = arduino.readStringUntil('\t');

 //stringAccXdis = arduino.readStringUntil('\t');
 //stringAccYdis = arduino.readStringUntil('\t');
 
  convert();
  drawAxisX();
 
 }
