% Read in data, each column in its own array
[d, t, avg_mag, lat, long, bx, by, bz, px, py, pz] = textread('RBSP.txt','%s %s %f %f %f %f %f %f %f %f %f');

%Format date and time for plotting purposes
tt=cellfun(@(t) t(1:end-4),t,'UniformOutput',false); % remove microsecond from time column

% Average arrays to reduce resolution (~10 seconds instead of ~16 msec) 
% 230,399 data points: 360 rows, 640 columns
%
% GETTING RESHAPE ERROR: NUMBER OF ELEMENTS MUST MOT CHANGE
% tmp = reshape(d,360,640);
% d_s = mean(tmp,2);
% 
% tmp = reshape(t,360,640);
% t_s = mean(tmp,2);
% 
% tmp = reshape(avg_mag,360,640);
% avg_mag_s = mean(tmp,2);
% 
% tmp = reshape(lat,360,640);
% lat_s = mean(tmp,2);
% 
% tmp = reshape(long,360,640);
% long_s = mean(tmp,2);
% 
% tmp = reshape(bx,360,640);
% bx_s = mean(tmp,2);
% 
% tmp = reshape(by,360,640);
% by_s = mean(tmp,2);
% 
% tmp = reshape(bz,360,640);
% bz_s = mean(tmp,2);
% 
% tmp = reshape(px,360,640);
% px_s = mean(tmp,2);
% 
% tmp = reshape(py,360,640);
% py_s = mean(tmp,2);
% 
% tmp = reshape(pz,360,640);
% pz_s = mean(tmp,2);

dt = strcat(d,{' '},t); %Put date and time in same column, convert to number
num = datenum(dt,'mm/dd/yyyy HH:MM:SS.FFF');
A = datestr(num);
AA = datestr(num,'dd-mm-yyyy HH:MM:SS.FFF'); %Use datestr to convert back to date format

% CREATE GRAPHS

% Compute full manual autocorrelation
x = avg_mag;
 for k=0:30000-2
     x_m = x(k+1:size(x,1));
     x_p = x(1:size(x,1)-k);
     x_m = x_m-mean(x_m);
     x_p = x_p-mean(x_p);
     ttop = sum(x_m.*x_p);
     x_mm = mean(x_m);
     x_pm = mean(x_p);
     bottom1 = sum((x_m-x_mm).^2);
     bottom2 = sum((x_p-x_pm).^2);
    tbottom = sqrt(bottom1*bottom2);
     cc(k+1) = ttop/tbottom;
 end

c_lag=(0:30000-2);

% Plot autocorrelation
plot(c_lag,cc);
xlabel('Lags');
ylabel('Autocorrelation');
title('Autocorrelation Function');
 
% PLOT B MAGNITUDE
%Create 2-D plot of B magnitude over entire timespan
figure('Name','Average Magnetic Field Mangnitude');
plot(num,avg_mag);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - 1 hour');

% PLOT B VECTOR
% Create 2-D plot of magnetic field vector over entire timespan
bz_norm = bz-mean(bz);
figure('Name','Magnetic Field Vector');
plot(num,bx,'r');
hold on;
plot(num,by,'b');
plot(num,bz_norm,'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Vector Components for 11 August 2012 - 1 hour');
legend('B_x','B_y','B_z - avg(B_z)');

% PLOT P VECTOR
% Create 2-D plot of position vector over entire timespan
px_norm = px-mean(px);
py_norm = py-mean(py);
figure('Name','Spacecraft Position Vector');
plot(num,px_norm,'r');
hold on;
plot(num,py_norm,'b');
plot(num,pz,'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Position in GSM (km)');
title('Spacecraft Position Components for 11 August 2012 - 1 hour');
legend('P_x - avg(P_x)','P_y - avg(P_y)','P_z');

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
