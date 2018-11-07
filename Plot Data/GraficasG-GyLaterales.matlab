
%AUTOCROSS AERO ON/OFF
    %Non Aero run
    lataccelNA=NonAeroAutox(:,3);
    longaccelNA=NonAeroAutox(:,2);
    speedNA=NonAeroAutox(:,7);
    timeNA=NonAeroAutox(:,1);
    
    %Aero run
    lataccelA=AeroAutox(:,3);
    longaccelA=AeroAutox(:,2);
    speedA=AeroAutox(:,7);
    timeA=AeroAutox(:,1);
    % Create figure
    figure1 = figure('Name','Limo');

    % Create axes
    axes1 = axes('Parent',figure1);
    hold(axes1,'on');

    % Create scatter
    hold on
    ratio=[1 1];
    daspect=ratio;
    xlim(axes1,[-2 2]);
    ylim(axes1,[-2 2]);
    scatter(lataccelA,longaccelA,'ob','DisplayName','Aero Package ON');
    scatter(lataccelNA,longaccelNA,'or','DisplayName','Aero Package OFF');
 
    % Create xlabel
    xlabel('Lateral Acceleration [g]','FontWeight','bold');

    % Create title
    title('Endurance practice g-g Diagram','FontSize',16);

    % Create ylabel
    ylabel('Longitudinal Acceleration [g]','FontWeight','bold');

    box(axes1,'on');
    % Set the remaining axes properties
    set(axes1,'XGrid','on','YGrid','on');
    % Create legend
    legend(axes1,'show');
  set(legend,'FontSize',10,'Location','best');
  GridLineStyle = '--';
  
  % Create figure
    figure2 = figure('Name','Limo2');

    % Create axes
    axes1 = axes('Parent',figure2);
    hold(axes1,'on');

    % Create scatter
    hold on
    %xlim(axes1,[0 300]);
    scatter(timeA-220,lataccelA,'ob','DisplayName','Aero Package ON');
    scatter(timeNA-155,lataccelNA,'or','DisplayName','Aero Package OFF');
 
    % Create xlabel
    xlabel('Time [s]','FontWeight','bold');

    % Create title
    title('Lateral Acceleration vs Time','FontSize',16);

    % Create ylabel
    ylabel('lat accel [g]','FontWeight','bold');

    box(axes1,'on');
    % Set the remaining axes properties
    set(axes1,'XGrid','on','YGrid','on');
    % Create legend
    legend(axes1,'show');
  set(legend,'FontSize',14,'Location','best');
  GridLineStyle = '--';
  
