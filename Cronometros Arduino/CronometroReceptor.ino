#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

int led = 13; //Definimos pin 13 para el encendido del led
long distancia; //Variable para definir la distancia calculada
long tiempo; //Variable para definir el tiempo en el que tarda el pulso al rebotar
int State = 0; //Variable para el estado del primer sensor
int lastState = 0; //Variable para el estado del segundo sensor
volatile long start; //variable para iniciar el contador del cronÃ³metro
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

void setup()
{
  Serial.begin(9600); //Iniciamos comunicaciÃ³n serial
  pinMode(9, OUTPUT); //Pin 9 Trigger Sensor Ultrasonido
  pinMode(8, INPUT); //Pin 8 Echo Sensor Ultrasonido
  pinMode(led, OUTPUT); // funcion en el setip para prender el led
  lcd.begin(16, 2);
  lcd.print("00:00:00");
}

void loop()
{
  Serial.println(distancia);
  if (Serial.available() > 0) //Condicion de recibir datos del Xbee emisor
  {
    if (Serial.read() == 'D') //Codicion de que paso el carro por el primer sensor
    {
      State = 1; //La variable state=1 para iniciar el cronÃ³metro
      start = millis(); //Asigna el valor del contador millis a start para el momento del inicio del contador
      Serial.end(); //Termina la comunicacion para que solo inicie el contador cuando pasa la primera parte del carro
    }
  }
  digitalWrite(9, LOW); /* Por cuestiÃ³n de estabilizaciÃ³n del sensor*/
  delayMicroseconds(5);
  digitalWrite(9, HIGH); /* envÃ­o del pulso ultrasÃ³nico*/
  delayMicroseconds(10);
  tiempo = pulseIn(8, HIGH); /* FunciÃ³n para medir la longitud del pulso entrante. Mide el tiempo que transcurrido entre el envÃ­o
  del pulso ultrasÃ³nico y cuando el sensor recibe el rebote, es decir: desde que el pin 12 empieza a recibir el rebote, HIGH, hasta que
  deja de hacerlo, LOW, la longitud del pulso entrante*/
  distancia = int(0.017 * tiempo); /*fÃ³rmula para calcular la distancia obteniendo un valor entero*/
  /*MonitorizaciÃ³n en centÃ­metros por el monitor serial*/
  if (distancia < 1000 && distancia > 0) {
    lastState = 1; //la variable lastState=1 para detener el cronÃ³metro luego de pasar por el segundo sensor
    digitalWrite(led, HIGH); //enciende el led

  }

  if (State == 1 && lastState == 0) //inicio del cronÃ³metro
  {
    elapsedTime = millis() - start;

    // store elapsed time
    elapsedMinutes = (elapsedTime / 60000L);
    elapsedSeconds = (elapsedTime / 1000L);              // divide by 1000 to convert to seconds
    elapsedFrames = (elapsedTime / interval);            // divide by 100 to convert to 1/100 of a second
    fractional = (int)(elapsedFrames % frameRate);       // use modulo operator to get fractional part of 100 Seconds
    fractionalSecs = (int)(elapsedSeconds % 60L);        // use modulo operator to get fractional part of 60 Seconds
    fractionalMins = (int)(elapsedMinutes % 60L);        // use modulo operator to get fractional part of 60 Minutes
    lcd.clear();                                         // clear the LDC

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
  }
  else if (State == 1 && lastState == 1) {
    lcd.setCursor(0, 0);
    lcd.print("");


  }
  else {
    delayMicroseconds(10);
  }
}

