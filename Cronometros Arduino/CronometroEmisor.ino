#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

int led = 13; //Pin 13 para encendido y apagado de led
long distancia; //Variable para definir la distancia calculada
long tiempo; //Variable para definir el tiempo en el que tarda el pulso al rebotar

void setup()
{
    Serial.begin(9600); //Iniciamos comunicación serial 
    pinMode(9,OUTPUT); //Pin 9 Trigger Sensor Ultrasonido
    pinMode(8,INPUT);  //Pin 8 Echo Sensor Ultrasonido
    pinMode(led,OUTPUT); 
}

void loop()
{
  digitalWrite(9,LOW); //Por cuestión de estabilización del sensor
  delayMicroseconds(5);
  digitalWrite(9, HIGH); //envío del pulso ultrasónico
  delayMicroseconds(10);
  tiempo=pulseIn(8, HIGH); /* Función para medir la longitud del pulso entrante. Mide el tiempo que transcurrido entre el envío
  del pulso ultrasónico y cuando el sensor recibe el rebote, es decir: desde que el pin 12 empieza a recibir el rebote, HIGH, hasta que
  deja de hacerlo, LOW, la longitud del pulso entrante*/
  distancia= int(0.017*tiempo); /*fórmula para calcular la distancia obteniendo un valor entero*/
  /*Monitorización en centímetros por el monitor serial*/
  if(distancia < 1000) {
    Serial.print('D'); //Imprimimos una variable que es enviada al receptor mediante el XBee
    digitalWrite(led,HIGH); //Encender mientras el carro pasa
  }
  else{
    digitalWrite(led,LOW); //Apagar el led mientras el carro no pasa
  }
  delay(20);
      
}
