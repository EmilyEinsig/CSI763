clear; clc;

% Read in data, each column in its own array
[d, t, avg_mag, lat, long, bx, by, bz, px, py, pz] = textread('RBSP.txt','%s %s %f %f %f %f %f %f %f %f %f');

%Format date and time for plotting purposes
tt=cellfun(@(t) t(1:end-4),t,'UniformOutput',false); % remove microsecond from time column

% Average arrays to reduce resolution (~10 seconds instead of ~16 msec) 
% 230,399 data points: 360 rows, 639 columns

dt = strcat(d,{' '},tt); %Put date and time in same column, convert to number
num = datenum(dt,'mm/dd/yyyy HH:MM:SS.FFF');

num = num(1:360*639);
tmp = reshape(num,639,360);
tmp = tmp';
num_s = mean(tmp,2);

avg_mag = avg_mag(1:360*639);
tmp = reshape(avg_mag,639,360);
tmp = tmp';
avg_mag_s = mean(tmp,2);

lat = lat(1:360*639);
tmp = reshape(lat,639,360);
tmp = tmp';
lat_s = mean(tmp,2);

long = long(1:360*639);
tmp = reshape(long,639,360);
long_s = mean(tmp,2);

bx = bx(1:360*639);
tmp = reshape(bx,639,360);
tmp = tmp';
bx_s = mean(tmp,2);

by = by(1:360*639);
tmp = reshape(by,639,360);
tmp = tmp';
by_s = mean(tmp,2);

bz = bz(1:360*639);
tmp = reshape(bz,639,360);
tmp = tmp';
bz_s = mean(tmp,2);

px = px(1:360*639);
tmp = reshape(px,639,360);
tmp = tmp';
px_s = mean(tmp,2);

py = py(1:360*639);
tmp = reshape(py,639,360);
tmp = tmp';
py_s = mean(tmp,2);

pz = pz(1:360*639);
tmp = reshape(pz,639,360);
tmp = tmp';
pz_s = mean(tmp,2);

% Use interpl to standardize time step size
ti = [num_s(1):1/(360*24):num_s(end)]';
AB = datestr(ti,'mm/dd/yyyy HH:MM:SS.FFF'); %Use datestr to convert back to date format

avg_mag_si = interp1(num_s,avg_mag_s,ti);
lat_si = interp1(num_s(1:359),lat_s(1:359),ti);
long_si = interp1(num_s(1:359),long_s(1:359),ti);
bx_si = interp1(num_s(1:359),bx_s(1:359),ti);
by_si = interp1(num_s(1:359),by_s(1:359),ti);
bz_si = interp1(num_s(1:359),bz_s(1:359),ti);
px_si = interp1(num_s(1:359),px_s(1:359),ti);
py_si = interp1(num_s(1:359),py_s(1:359),ti);
pz_si = interp1(num_s(1:359),pz_s(1:359),ti);

% CREATE GRAPHS

% Compute full manual autocorrelation
x = avg_mag_si;
 for k=0:360-2
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

c_lag=(0:360-2);

% Plot full autocorrelation
figure('Name','Full Autocorrelation Function');
plot(c_lag,cc);
xlabel('Lags');
ylabel('Autocorrelation');
title('Autocorrelation Function');

% Plot zoomed autocorrelation
figure('Name','Zoomed-in Autocorrelation Function');
plot(c_lag(1:200),cc(1:200));
xlabel('Lags');
ylabel('Autocorrelation');
title('Autocorrelation Function - 1st 200 lags');
 
% PLOT B MAGNITUDE
%Create 2-D plot of B magnitude over entire timespan
figure('Name','Average Magnetic Field Mangnitude');
plot(ti,avg_mag_si);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - 1 hour');

% PLOT B VECTOR
% Create 2-D plot of magnetic field vector over entire timespan
bz_norm = bz_si-nanmean(bz_si);
figure('Name','Magnetic Field Vector');
plot(ti,bx_si,'r');
hold on;
plot(ti,by_si,'b');
plot(ti,bz_norm,'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Magnetic Field Magnitude (nT)');
title('Magnetic Field Vector Components for 11 August 2012 - 1 hour');
legend('B_x','B_y','B_z - avg(B_z)');

% PLOT P VECTOR
% Create 2-D plot of position vector over entire timespan
px_norm = px_si-nanmean(px_si);
py_norm = py_si-nanmean(py_si);
figure('Name','Spacecraft Position Vector');
plot(ti,px_norm,'r');
hold on;
plot(ti,py_norm,'b');
plot(ti,pz_si,'g');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('Position in GSM (km)');
title('Spacecraft Position Components for 11 August 2012 - 1 hour');
legend('P_x - avg(P_x)','P_y - avg(P_y)','P_z');

% B MAGNITUDE AND POSITION MAGNITUDE
figure('Name','Magnetic Field Magnitude and Position Magnitude');
p_mag = sqrt(px_si.^2 + py_si.^2 + pz_si.^2);
[AX,H1,H2] = plotyy(ti,avg_mag_si,ti,p_mag,'plot');
set(get(AX(1),'Ylabel'),'String','Magnetic Field (nT)') 
set(get(AX(2),'Ylabel'),'String','GSM Position (km)') 
datetick(AX(1),'x','HH:MM:SS');
datetick(AX(2),'x','HH:MM:SS');
xlabel('Time');
title('Magnetic Field and Position Magntiudes for 11 August 2012 - 1 hour');
legend('B_{mag}','P_{mag}');
