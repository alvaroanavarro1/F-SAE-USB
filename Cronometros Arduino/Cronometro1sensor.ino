#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

int led = 13; //Definimos pin 13 para el encendido del led

//variables para cuando pasa el carro por primera vez (inicia contador)
long distancia; //Variable para definir la distancia calculada
long tiempo; //Variable para definir el tiempo en el que tarda el pulso al rebotar

//Variables del estado del sensor
int State = 0; //Variable para el estado del sensor para inicar el contador
int lastState = 0; //Variable para el estado del  sensor para parar el contador
int aux=0;
int aux2=0;

//variables para el cronometro
volatile long start; //variable para iniciar el contador del cronómetro
volatile int frameRate = 100;                // the frame rate (frames per second)
volatile unsigned long interval = (1000 / frameRate); // blink interval
volatile unsigned long previousMillis = 0;            // variable to store last time LED was updated
volatile unsigned long elapsedTime ;                  // elapsed time for stop watch
volatile int fractional;                     // variable used to store fractional part of Frames
volatile int fractionalSecs;                 // variable used to store fractional part of Seconds
volatile int fractionalMins;                 // variable used to store fractional part of Minutes
volatile int elapsedFrames;                  // elapsed frames for stop watch
volatile int elapsedSeconds;                 // elapsed seconds for stop watch
volatile int elapsedMinutes;                 // elapsed Minutes for stop watch
volatile int lastFractional;                     // variable used to store fractional part of Frames
volatile int lastFractionalSecs;                 // variable used to store fractional part of Seconds
volatile int lastFractionalMins;                 // variable used to store fractional part of Minutes

void setup()
{ lcd.clear();   
  Serial.begin(9600); //Iniciamos comunicación serial
  pinMode(9, OUTPUT); //Pin 9 Trigger Sensor Ultrasonido
  pinMode(8, INPUT); //Pin 8 Echo Sensor Ultrasonido
  pinMode(led, OUTPUT); // funcion en el setip para prender el led
  lcd.begin(16, 2);
  lcd.setCursor(0, 0);
  lcd.print("00:00:00");
}

void loop()
{
  Serial.println(distancia);
  digitalWrite(9, LOW); /* Por cuestión de estabilización del sensor*/
  delayMicroseconds(5);
  digitalWrite(9, HIGH); /* envío del pulso ultrasónico*/
  delayMicroseconds(10);
  tiempo = pulseIn(8, HIGH); /* Función para medir la longitud del pulso entrante. Mide el tiempo que transcurrido entre el envío
  del pulso ultrasónico y cuando el sensor recibe el rebote, es decir: desde que el pin 12 empieza a recibir el rebote, HIGH, hasta que
  deja de hacerlo, LOW, la longitud del pulso entrante*/
  distancia = int(0.017 * tiempo); /*fórmula para calcular la distancia obteniendo un valor entero*/
  /*Monitorización en centímetros por el monitor serial*/
  if (distancia < 1000 && distancia > 0) {
    State = 1; //La variable state=1 para iniciar el cronómetro
    start = millis(); //Asigna el valor del contador millis a start para el momento del inicio del contador
  }

  if(distancia> 1000 && State==1){
    aux=1;
  }
 

  if (distancia < 1000 && distancia > 0 && aux==1) {

    lastState = 1; //la variable lastState=1 para detener el cronómetro luego de pasar por el segundo sensor
    digitalWrite(led, HIGH); //enciende el led
    aux2=1;
  }

  if (State == 1 && lastState == 0) //inicio del cronómetro
  {
    elapsedTime = millis() - start;

    // store elapsed time
    elapsedMinutes = (elapsedTime / 60000L);
    elapsedSeconds = (elapsedTime / 1000L);              // divide by 1000 to convert to seconds
    elapsedFrames = (elapsedTime / interval);            // divide by 100 to convert to 1/100 of a second
    fractional = (int)(elapsedFrames % frameRate);       // use modulo operator to get fractional part of 100 Seconds
    fractionalSecs = (int)(elapsedSeconds % 60L);        // use modulo operator to get fractional part of 60 Seconds
    fractionalMins = (int)(elapsedMinutes % 60L);        // use modulo operator to get fractional part of 60 Minutes
    lcd.setCursor(0, 0);
                                         // clear the LDC

    if (fractionalMins < 10) {
      lcd.print("0");
    }

    lcd.print(fractionalMins);
    lcd.print(":");

    if (fractionalSecs < 10) {
      lcd.print("0");
    }

    lcd.print(fractionalSecs);
    lcd.print(":");

    if (fractional < 10) {
      lcd.print("0");
    }

    lcd.print(fractional); {
    }
    
    lastFractional=fractional;
    lastFractionalMins=fractionalMins;
    lastFractionalSecs=fractionalSecs;
  }
  else if ((State == 1 && lastState == 1)) {
    Serial.println(lastFractionalMins);
    Serial.println(lastFractionalMins);
    Serial.println(":");
    Serial.println(lastFractionalSecs);
    Serial.println(":");
    Serial.println(lastFractional);
    
    lcd.setCursor(0, 1);
    
    lcd.print(lastFractionalMins);
    lcd.print(":");
    lcd.print(lastFractionalSecs);
    lcd.print(":");
    lcd.print(lastFractional);

    if(State==1 && lastState==1){
         aux=0;
  }
     if(aux==0){
        State=0;
        lastState=0;
     }
  }

  
  else {
    delayMicroseconds(10);
  }
    }

  


