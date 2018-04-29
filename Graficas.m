particular = menu('Do you want a specific graphic?', 'yes', 'no');
if (particular == 1)
    
    disp('Which graphic do you want?');
    disp('1. RPM');
    disp('2. TPS');
    disp('3. Speed');
    disp('4. Gearbox');
    disp('5. Longitudinal Acceleration');
    disp('6. Lateral Acceleration');
    disp('7. Steering Potentiometer');
    disp('8. Wheel Acceleration');
    disp('9. Engine Temperature');
    disp('10. Battery Voltage');
    disp('11. Suspension Potentiometer');
    disp('12. Curve Ratio');
    disp('13. Longitudinal vs Lateral Acceleration');
    disp('14. Desired Percent Slip');


    eleccion = input('Choose your option: ');
    
    switch(eleccion)
        
         case 1

            figure;
            plot(Timesec, RPM);
            grid on;
            title('RPM');
            xlabel('Time <s>');
            ylabel('RPM');
            
        case 2    
                   
            figure;
            plot(Timesec,TPS,'r');
            grid on;
            title('Throttle position');
            xlabel('Time <s>');
            ylabel('TPS <%>');
           
            
        case 3
            
            VelocidadLineal = 1.60934*(Freq2/(2*3.14));

            figure;            
            plot(Timesec,VelocidadLineal);
            grid on;
            title('Speed');
            xlabel('Time <s>');
            ylabel('Speed <KPH>');
            
        case 4
            
            figure;
            %RPM/velocidad lineal
            plot(Timesec,RPM./VelocidadLineal);
            grid on;
            title('Gearbox Speed');
            xlabel('Time <s>');
            ylabel('Gearbox <KPH>');
            
        case 5
            
            figure;
            plot(times1,longaccelg);
            grid on;
            title('Longitudinal Acceleration');
            xlabel('Time <s>');
            ylabel('Acceleration <g>');
            
        case 6
            
            figure;
            plot(times1,lataccelg);
            grid on;
            title('Lateral Acceleration');
            xlabel('Time <s>');
            ylabel('Acceleration <g>');
            
        case 7
            
            figure;
            title('Steering Potentiometer');
            
        case 8

            aceleracion=diff(VelocidadLineal)./diff(Timesec);
            plot(Timesec(2:end),acceleracion);            
            figure;
            title('Wheel acceleracion');
            xlabel('Time <s>');
            ylabel('Acceleration');
            
        case 9
            
            figure;
            plot(Timesec, CoolantTempC,'xr');
            grid on;
            title('Engine Temperature');
            axis([0 200 70 110]);
            xlabel('Time <s>');
            ylabel('Temperature <C>');
            
        case 10

            figure;
            plot(Timesec, BatteryVoltV);
            grid on;
            title('Battery Voltage');
            xlabel('Time <s>');
            ylabel('Voltage <v>');

            
        case 11
            
            figure;
            title('Suspension Potentiometer');
            
        case 12
            
            figure;
            %(velocidad lineal)^2/aceleracion lateral
            title('Curve Ratio');
            
        case 13
            
            figure;
            plot(longaccelg,lataccelg,'xr');
            title('Lateral Acceleration vs Longitudinal Acceleration');
            xlabel('Lateral Acceleration');
            ylabel('Longitudinal Acceleration');
            grid on;

        case 14
            
            figure;
            title('Desired Percent Slip');
            plot(Timesec, ((AvgDrivenWheelSpeedMPH - AvgNonDrivenWheelSpeedMPH)./ AvgNonDrivenWheelSpeedMPH)*100);
			title('Slip Ratio <%>');
			xlabel('Time <s>');
			ylabel ('Slip Ratio <%>');
			grid on;
            
            
        otherwise
            
            disp('Incorrect Option');
            
    end
    
elseif particular==2
  
                    
            figure;
            plot(Timesec, RPM);
            grid on;
            title('RPM');
            xlabel('Time <s>');
            ylabel('RPM');
            
            
                   
            figure;
            plot(Timesec,TPS,'r');
            grid on;
            title('Throttle Position');
            xlabel('Time <s>');
            ylabel('TPS <%>');
           
            
                    
            VelocidadLineal = 1.60934*AvgNonDrivenWheelSpeedMPH;

            figure;            
            plot(Timesec,VelocidadLineal);
            grid on;
            title('Speed');
            xlabel('Time <s>');
            ylabel('Speed <KPH>');
            
        
            
            figure;
            %RPM/velocidad lineal
            plot(Timesec,RPM./VelocidadLineal);
            grid on;
            title('Gearbox Speed');
            xlabel('Time <s>');
            ylabel('Speed <KPH>');
            
        
            
            figure;
            plot(times1,longaccelg);
            grid on;
            title('Longitudinal Acceleration');
            xlabel('Time <s>');
            ylabel('Acceleration <g>');
            
        
            
            figure;
            plot(times1,lataccelg);
            grid on;
            title('Lateral Acceleration');
            xlabel('Time <s>');
            ylabel('Acceleration <g>');
            
       
            
            figure;
            plot(Timesec, CoolantTempC);
            grid on;
            title('Engine Temperature');
            xlabel('Time <s>');
            ylabel('Temperature <C>');
            
       

            figure;
            plot(Timesec, BatteryVoltV);
            grid on;
            title('Battery Voltage');
            xlabel('Time <s>');
            ylabel('Voltage <v>');         
                   
        
            
            figure;
            plot(longaccelg,lataccelg);
            title('Lateral Acceleration vs Longitudinal Acceleration');
            xlabel('Lateral Acceleration');
            ylabel('Longitudinal Acceleration');
            grid on;

        
            
            figure;
            title('Desired Percent Slip');
            plot(Timesec, ((AvgDrivenWheelSpeedMPH - AvgNonDrivenWheelSpeedMPH)./ AvgNonDrivenWheelSpeedMPH)*100);
            title('Slip Ratio <%>');
            xlabel('Time <s>');
            ylabel ('Slip Ratio <%>');
            grid on;  
    
    
    
    
end

