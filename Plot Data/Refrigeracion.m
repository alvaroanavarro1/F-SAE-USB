%UNIVERSIDAD SIMON BOLIVAR
%EQUIPO FORMULA SAE USB
%DATOS PARA LA OBSERVACION DEL COMPORTAMIENTO DE LA TEMPERATURA EN EL PROTOTIPO
%Elaborado por: Alvaro Navarro

%Datos de entrada:
%Timesec
%CoolantTempC
%TPS
%RPM
%AvgNonDrivenWheelSpeedMPH

%%Grafica Temperatura vs Tiempo

figure;
plot(Timesec, CoolantTempC, 'xr')
grid on;
title('Water temp vs Time');
ylabel('Water temp (Celius)');
xlabel('Time (sec)');

%%Grafica Temperatura/TPS vs Tiempo

figure;
subplot(2,1,1), plot(Timesec, CoolantTempC, 'xr');
grid on;
title('Water temp vs Time');
ylabel('Water temp (Celius)');
xlabel('Time (sec)');

subplot(2,1,2), plot(Timesec, TPS, 'b');
grid on;
title('Throttle position vs Time');
ylabel('Position (%)');
xlabel('Time (sec)');

%%Grafica Temperatura/RPMfiltradas vs Tiempo

[b,a]=butter(3 , (0.8/50),'low');

figure;
RPMFiltered= filter(b,a,RPM);

subplot(2,1,1), plot(Timesec, CoolantTempC, 'xr');
grid on;
title('Water temp vs Time');
ylabel('Water temp (Celius)');
xlabel('Time (sec)');

subplot(2,1,2), plot(Timesec, RPMFiltered, 'b');
grid on;
title('RPM vs Time');
ylabel('Revolutions Per Minute');
xlabel('Time (sec)');

%%Grafica Temperatura/Velocidad vs Tiempo

figure;
AvgNonDrivenWheelSpeedKPH = AvgNonDrivenWheelSpeedMPH * 1.60943;
AvgNonDrivenWheelSpeedKPHFiltered = filter(b,a,AvgNonDrivenWheelSpeedKPH);

subplot(2,1,1), plot(Timesec, CoolantTempC, 'xr');
grid on;
title('Water temp vs Time');
ylabel('Water temp (Celius)');
xlabel('Time (sec)');

subplot(2,1,2), plot(Timesec, AvgNonDrivenWheelSpeedKPHFiltered, 'b');
grid on;
title('Speed vs Time');
ylabel('Speed (KpH');
xlabel('Time (sec)');

