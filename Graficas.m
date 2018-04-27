particular = menu('Quieres una grafica en particular?', 'si', 'no');
if (particular == 1)
    
    disp('Que quieres graficar');
    disp('1. RPM');
    disp('2. TPS');
    disp('3. Velocidad Lineal');
    disp('4. Velocidad de la caja');
    disp('5. Aceleracion longitudinal');
    disp('6. Aceleracion lateral');
    disp('7. Potenciometro de la direccion');
    disp('8. Aceleracion de las ruedas');
    disp('9. Temperatura del motor');
    disp('10. Voltaje de la bateria');
    disp('11. Potenciometro de la suspension');
    disp('12. Radio de la curvatura');
    disp('13. Aceleraciones longitudinales vs laterales');
    disp('14. Porcentaje de deslizamiento');


    eleccion = input('elija su opcion: ');
    
    switch(eleccion)
        
         case 1

            figure;
            plot(Timesec, RPM);
            grid on;
            title('Revoluciones por Minuto');
            xlabel('Tiempo <s>');
            ylabel('RPM');
            
        case 2    
                   
            figure;
            plot(Timesec,TPS,'r');
            grid on;
            title('Abertura de la Mariposa');
            xlabel('Tiempo <s>');
            ylabel('TPS <%>');
           
            
        case 3
            
            VelocidadLineal = 1.60934*(Freq2/(2*3.14));

            figure;            
            plot(Timesec,VelocidadLineal);
            grid on;
            title('Velocidad Lineal');
            xlabel('Tiempo <s>');
            ylabel('Velocidad <KPH>');
            
        case 4
            
            figure;
            %RPM/velocidad lineal
            plot(Timesec,RPM./VelocidadLineal);
            grid on;
            title('Velocidad de la Caja');
            xlabel('Tiempo <s>');
            ylabel('Velocidad <KPH>');
            
        case 5
            
            figure;
            plot(times1,longaccelg);
            grid on;
            title('Aceleracion longitudinal');
            xlabel('Tiempo <s>');
            ylabel('Aceleración <g>');
            
        case 6
            
            figure;
            plot(times1,lataccelg);
            grid on;
            title('Aceleracion lateral');
            xlabel('Tiempo <s>');
            ylabel('Aceleración <g>');
            
        case 7
            
            figure;
            title('Potenciometro de la direccion');
            
        case 8

            aceleracion=diff(VelocidadLineal)./diff(Timesec);
            plot(Timesec(2:end),acceleracion);            
            figure;
            title('Aceleracion de las ruedas');
            xlabel('Tiempo <s>');
            ylabel('Aceleración');
            
        case 9
            
            figure;
            plot(Timesec, CoolantTempC,'xr');
            grid on;
            title('Temperatura del motor');
            axis([0 200 70 110]);
            xlabel('Tiempo <s>');
            ylabel('Temperatura <C>');
            
        case 10

            figure;
            plot(Timesec, BatteryVoltV);
            grid on;
            title('Voltaje de bateria');
            xlabel('Tiempo <s>');
            ylabel('Voltaje <v>');

            
        case 11
            
            figure;
            title('Potenciometro de suspension');
            
        case 12
            
            figure;
            %(velocidad lineal)^2/aceleracion lateral
            title('Radio de curvatura');
            
        case 13
            
            figure;
            plot(longaccelg,lataccelg,'xr');
            title('Aceleraciones longitudinales vs Aceleraciones laterales');
            xlabel('Aceleraciones laterales');
            ylabel('Aceleraciones longitudinales');
            grid on;

        case 14
            
            figure;
            title('Porcentaje de deslizamiento');
            plot(Timesec, ((AvgDrivenWheelSpeedMPH - AvgNonDrivenWheelSpeedMPH)./ AvgNonDrivenWheelSpeedMPH)*100);
			title('Slip Ratio <%>');
			xlabel('Tiempo <s>');
			ylabel ('Slip Ratio <%>');
			grid on;
            
            
        otherwise
            
            disp('No existe esa opcion');
            
    end
    
elseif particular==2
  
                    
            figure;
            plot(Timesec, RPM);
            grid on;
            title('Revoluciones por Minuto');
            xlabel('Tiempo <s>');
            ylabel('RPM');
            
            
                   
            figure;
            plot(Timesec,TPS,'r');
            grid on;
            title('Abertura de la Mariposa');
            xlabel('Tiempo <s>');
            ylabel('TPS <%>');
           
            
                    
            VelocidadLineal = 1.60934*AvgNonDrivenWheelSpeedMPH;

            figure;            
            plot(Timesec,VelocidadLineal);
            grid on;
            title('Velocidad Lineal');
            xlabel('Tiempo <s>');
            ylabel('Velocidad <KPH>');
            
        
            
            figure;
            %RPM/velocidad lineal
            plot(Timesec,RPM./VelocidadLineal);
            grid on;
            title('Velocidad de la Caja');
            xlabel('Tiempo <s>');
            ylabel('Velocidad <KPH>');
            
        
            
            figure;
            plot(times1,longaccelg);
            grid on;
            title('Aceleracion longitudinal');
            xlabel('Tiempo <s>');
            ylabel('Aceleración <g>');
            
        
            
            figure;
            plot(times1,lataccelg);
            grid on;
            title('Aceleracion lateral');
            xlabel('Tiempo <s>');
            ylabel('Aceleración <g>');
            
       
            
            figure;
            plot(Timesec, CoolantTempC);
            grid on;
            title('Temperatura del motor');
            xlabel('Tiempo <s>');
            ylabel('Temperatura <C>');
            
       

            figure;
            plot(Timesec, BatteryVoltV);
            grid on;
            title('Voltaje de bateria');
            xlabel('Tiempo <s>');
            ylabel('Voltaje <v>');         
                   
        
            
            figure;
            plot(longaccelg,lataccelg);
            title('Aceleraciones longitudinales vs Aceleraciones laterales');
            xlabel('Aceleraciones laterales');
            ylabel('Aceleraciones longitudinales');
            grid on;

        
            
            figure;
            title('Porcentaje de deslizamiento');
            plot(Timesec, ((AvgDrivenWheelSpeedMPH - AvgNonDrivenWheelSpeedMPH)./ AvgNonDrivenWheelSpeedMPH)*100);
            title('Slip Ratio <%>');
            xlabel('Tiempo <s>');
            ylabel ('Slip Ratio <%>');
            grid on;  
    
    
    
    
end

