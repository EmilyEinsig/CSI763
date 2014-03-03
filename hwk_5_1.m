clear; clc;

% Read in data, each column in its own array
[d, t, avg_mag, lat, long, bx, by, bz, px, py, pz] = textread('RBSP.txt','%s %s %f %f %f %f %f %f %f %f %f');

%Format date and time for plotting purposes
tt=cellfun(@(t) t(1:end-4),t,'UniformOutput',false); % remove microsecond from time column

dt = strcat(d,{' '},t); %Put date and time in same column, convert to number
num = datenum(dt,'mm/dd/yyyy HH:MM:SS.FFF');
A = datestr(num);
AA = datestr(num,'dd-mm-yyyy HH:MM:SS.FFF'); %Use datestr to convert back to date format


% PLOT B MAGNITUDE
%Create 2-D plot of B magnitude over entire timespan
figure('Name','Average Magnetic Field Mangnitude');
subplot(3,1,1);
plot(num,avg_mag);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - 1 hour');

%Create 2-D plot of B magnitude over first 10 minute timespan
subplot(3,1,2);
plot(num(1:38399),avg_mag(1:38399));
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - 10 minutes');

%Create 2-D plot of B magnitude over first 1 minute timespan
subplot(3,1,3);
plot(num(1:3840),avg_mag(1:3840));
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - 1 minute');

% PLOT B VECTOR
% Create 2-D plot of magnetic field vector over entire timespan
figure('Name','Magnetic Field Vector');
subplot(3,1,1);
plot(num,bx,'r');
hold on;
plot(num,by,'b');
plot(num,bz,'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Vector Components for 11 August 2012 - 1 hour');
legend('B_x','B_y','B_z');

% Create 2-D plot of magnetic field vector over first 10 minute timespan
subplot(3,1,2);
plot(num(1:38399),bx(1:38399),'r');
hold on;
plot(num(1:38399),by(1:38399),'b');
plot(num(1:38399),bz(1:38399),'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Vector Components for 11 August 2012 - 10 minutes');
legend('B_x','B_y','B_z');

subplot(3,1,3);
plot(num(1:3840),bx(1:3840),'r');
hold on;
plot(num(1:3840),by(1:3840),'b');
plot(num(1:3840),bz(1:3840),'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Vector Components for 11 August 2012 - 1 minute');
legend('B_x','B_y','B_z');

% PLOT P VECTOR
% Create 2-D plot of position vector over entire timespan
figure('Name','Spacecraft Position Vector');
subplot(3,1,1);
plot(num,px,'r');
hold on;
plot(num,py,'b');
plot(num,pz,'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Position in GSM (km)');
title('Spacecraft Position Components for 11 August 2012 - 1 hour');
legend('P_x','P_y','P_z');

% Create 2-D plot of position vector over first 10 minute timespan
subplot(3,1,2);
plot(num(1:38399),px(1:38399),'r');
hold on;
plot(num(1:38399),py(1:38399),'b');
plot(num(1:38399),pz(1:38399),'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Position in GSM (km)');
title('Spacecraft Position Vector Components for 11 August 2012 - 10 minutes');
legend('P_x','P_y','P_z');

subplot(3,1,3);
plot(num(1:3840),px(1:3840),'r');
hold on;
plot(num(1:3840),py(1:3840),'b');
plot(num(1:3840),pz(1:3840),'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Position in GSM (km)');
title('Spacecraft Position Vector Components for 11 August 2012 - 1 minute');
legend('P_x','P_y','P_z');

% B MAGNITUDE AND VECTOR
figure('Name','Magnetic Field Magnitude and Vector');
plot(num,avg_mag,'k');
hold on;
plot(num,bx,'r');
plot(num,by,'b');
plot(num,bz,'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Vector and Magntiude for 11 August 2012 - 1 hour');
legend('B_{mag}','B_x','B_y','B_z');

% B MAGNITUDE AND POSITION MAGNITUDE
figure('Name','Magnetic Field Magnitude and Position Magnitude');
p_mag = sqrt(px.^2 + py.^2 + pz.^2);
[AX,H1,H2] = plotyy(num,avg_mag,num,p_mag,'plot');
set(get(AX(1),'Ylabel'),'String','Magnetic Field (nT)') 
set(get(AX(2),'Ylabel'),'String','GSM Position (km)') 
datetick(AX(1),'x','HH:MM:SS');
datetick(AX(2),'x','HH:MM:SS');
xlabel('Time');
title('Magnetic Field and Position Magntiudes for 11 August 2012 - 1 hour');
legend('B_{mag}','P_{mag}');
