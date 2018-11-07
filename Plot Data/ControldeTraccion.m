%%UNIVERSIDAD SIMON BOLIVAR
%%EQUIPO FORMULA SAE USB
%%DATOS ADQUIRIDOS 14-02-17 PARA LA IMPLEMENTACION DEL SISTEMA DE CONTROL
%%DE TRACCION
%%Elaborado por: Daniel Comas

%% Datos de Entrada:
%% AvgDrivenWheelSpeedMPH
%% AvgNonDrivenWheelSpeedMPH
%% DrivenWheelSpeed1MPH
%% DrivenWheelSpeed2MPH
%% DrivenWheelSpeedRateofChangeftsecsec
%% IgnitionPercentCut
%% NonDrivenWheelSpeed1MPH
%% NonDrivenWheelSpeed2MPH
%% PercentSlip
%% RPM
%% Timesec
%% TPS
%% TractionControlCompensationIgnitiondeg
%% TractionControlCompenstationIgnitionPercentCut
%% TractionControlDesiredPercentSlip
%% TractionControlDesiredWheelSpeedRateofChange


figure;
subplot(4,1,1), plot(Timesec, RPM);
grid on;
title('Revoluciones por Minuto');
xlabel('Tiempor <s>');
ylabel('RPM');
%axis([10 40 0 12000]);
subplot(4,1,2), plot(Timesec,TPS,'r');
grid on;
title('Abertura de la Mariposa');
xlabel('Tiempor <s>');
ylabel('TPS <%>');
%%axis([10 40 0 110]);
AvgNonDrivenWheelSpeedMetersPerSecon=AvgNonDrivenWheelSpeedMPH * 0.44704;
AvgDrivenWheelSpeedMetersPerSecon = AvgDrivenWheelSpeedMPH * 0.44704; 
AvgNonDrivenWheelSpeedKMetersPerSecon = AvgNonDrivenWheelSpeedMPH * 1.60943;
AvgDrivenWheelSpeedKMetersPH = AvgDrivenWheelSpeedMPH * 1.60943;

subplot(4,1,3), plot(Timesec,AvgDrivenWheelSpeedKMetersPH);
xlabel('Tiempor <s>');
ylabel ('Velocidad <Km/H>');
grid on;
hold on;
subplot(4,1,3), plot(Timesec,AvgNonDrivenWheelSpeedKMetersPerSecon);
%axis([10 40 0 50]);
legend('Velocidad ruedas traseras','Velocidad ruedas delanteras');
title('Diferencia entre velocidades')
subplot(4,1,4), plot(Timesec, ((AvgDrivenWheelSpeedMPH - AvgNonDrivenWheelSpeedMPH)./ AvgNonDrivenWheelSpeedMPH));
title('Slip Ratio <%>');
xlabel('Tiempor <s>');
ylabel ('Slip Ratio <%>');
%axis([10 40 0 60]);
grid on;

figure;
%%subplot(2,1,1), plot(Timesec, RPM./AvgDrivenWheelSpeedMPH); xlabel('Tiempo<s>'); ylabel('RPM/AvgDrivenWheelSpeedMPH') ;
subplot(2,1,1), plot(Timesec, AvgDrivenWheelSpeedMPH./RPM); xlabel('Tiempo<s>'); ylabel('AvgDrivenWheelSpeedMPH./RPM') ;
title('Velocidad de la caja de cambios');
grid on;
%axis([10 40 0 0.01]);
subplot(2,1,2), plot(Timesec,AvgDrivenWheelSpeedMPH);
xlabel('Tiempor <s>');
ylabel ('Velocidad <MPH>');
grid on;
hold on;
subplot(2,1,2), plot(Timesec, AvgNonDrivenWheelSpeedMPH);
%axis([10 40 0 50]);
legend('Velocidad ruedas traseras','Velocidad ruedas delanteras');
title('Diferencia entre velocidades');

%%Filtro pasa bajos 0.8 Hz
[b,a]=butter(3 , (0.8/50),'low');
NonDrivenWheelSpeedKmPSFiltered=filter(b,a,AvgNonDrivenWheelSpeedKMetersPerSecon);
filtrada=filter(b,a,AvgNonDrivenWheelSpeedMetersPerSecon);
figure;
subplot (2,1,1),plot(Timesec,filtrada);
AccelerationMeterPerS2 = diff(filtrada)/(1/100);
AccelerationMeterPerS2(length(AccelerationMeterPerS2)+1)= 0;
AccelerationsGs = AccelerationMeterPerS2 / 9.8;
title('Aceleraciones');
xlabel('Tiempo <s>');
ylabel('G');
plot(Timesec,AccelerationsGs);
title('Aceleraciones medidas de las ruedas delanteras');
xlabel('Tiempo <s>');
ylabel('G');
grid on;
subplot(2,1,2), plot(Timesec,AvgDrivenWheelSpeedKMetersPH);
xlabel('Tiempor <s>');
ylabel ('Velocidad <Km/H>');
grid on;
hold on;
subplot(2,1,2), plot(Timesec,AvgNonDrivenWheelSpeedKMetersPerSecon);
%axis([10 40 0 50]);
legend('Velocidad ruedas traseras','Velocidad ruedas delanteras');
title('Diferencia entre velocidades')

%%Debo acomodar el vector porque se desfasa luego de aplicar el filtro
%%(elimino las 42 primeras muestras (son nulas) y agrego 42 muestras luego)
%%esto debo hacerlo con todas los vectores que les pase el filtro
figure;
NonDrivenWheelSpeedKmPSFiltered(1:42)=[];
NonDrivenWheelSpeedKmPSFiltered(length(NonDrivenWheelSpeedKmPSFiltered)+42)=0;
subplot (4,1,1),plot(Timesec,NonDrivenWheelSpeedKmPSFiltered,'r');
title('Velocidad de ruedas delanteras filtradas');
xlabel('Tiempo <s>');
ylabel('Velocidad <Km/h>');
grid on;
subplot (4,1,2),plot(Timesec,AvgNonDrivenWheelSpeedKMetersPerSecon, 'b');
title('Velocidad de ruedas delanteras bruta');
xlabel('Tiempo <s>');
ylabel('Velocidad <Km/h>');
grid on;


DrivenWheelSpeedKmPSFiltered = filter(b,a,AvgDrivenWheelSpeedKMetersPH);
DrivenWheelSpeedKmPSFiltered(1:42)=[];
DrivenWheelSpeedKmPSFiltered(length(DrivenWheelSpeedKmPSFiltered)+42)=0;
subplot (4,1,3),plot(Timesec,DrivenWheelSpeedKmPSFiltered,'r');
grid on;
title('Velocidad de ruedas traseras filtradas');
xlabel('Tiempo <s>');
ylabel('Velocidad <Km/h>');
subplot (4,1,4),plot(Timesec,AvgDrivenWheelSpeedKMetersPH, 'b');
grid on;
title('Velocidad de ruedas traseras bruta');
xlabel('Tiempo <s>');
ylabel('Velocidad <Km/h>');

figure;
RPMFiltered=filter(b,a,RPM);
RPMFiltered(1:42)=[];
RPMFiltered(length(RPMFiltered)+42)=0;
plot(Timesec, RPMFiltered);
hold on;
plot(Timesec, RPM);
legend('RPM filtrada','RPM bruta');
title('Filtraje de RPM');
ylabel('Revolutions Per Minute');
xlabel('Tiempo <s>');
grid on;


figure;
subplot(4,1,1),plot(Timesec,AccelerationsGs);
xlabel('Tiempo <s>');
ylabel('Acceleraciones <g>');
grid on;
title('Aceleraciones a partir de ruedas delanteras');
%%axis([10 35 -1 1]);
SpeedandRPMRelation = filter(b,a, AvgDrivenWheelSpeedMPH)./(filter(b,a,RPM));
subplot(4,1,2); plot(Timesec,SpeedandRPMRelation,'b');
title('Relacion RPM/Velocidad promedio ruedas traseras (marcha) <rev/MPH>');
xlabel('Tiempo <s>');
ylabel('<rev/MPH>');
%%axis([10 35 0 0.005]);
grid on;
subplot (4,1,3),plot(Timesec,DrivenWheelSpeedKmPSFiltered,'r');
grid on;
title('Velocidad de ruedas traseras y delanteras filtradas');
xlabel('Tiempo <s>');
ylabel('Velocidad <Km/h>');
hold on;
plot(Timesec,NonDrivenWheelSpeedKmPSFiltered,'b');
legend('Velocidad promedio ruedas traseras', 'Velocidad promedio ruedas delanteras');
xlabel('Tiempo <s>');
ylabel('Velocidad <Km/h>');
grid on;
%axis([10 35 0 65]);
subplot(4,1,4), plot(Timesec,TPS,'r');
grid on;
title('Abertura de la Mariposa');
xlabel('Tiempor <s>');
ylabel('TPS <%>');
%axis([10 35 -0 110]);


