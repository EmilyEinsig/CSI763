clear; clc;

% Read in data, each column in its own array
[d, t, avg_mag, lat, long, bx, by, bz, px, py, pz] = textread('RBSP.txt','%s %s %f %f %f %f %f %f %f %f %f');

%Format date and time for plotting purposes
tt=cellfun(@(t) t(1:end-4),t,'UniformOutput',false); % remove microsecond from time column

dt = strcat(d,{' '},tt); %Put date and time in same column, convert to number
num = datenum(dt,'mm/dd/yyyy HH:MM:SS.FFF');

% PLOT RAW B MAGNITUDE
%Create 2-D plots of stationary B magnitude throughout timespan
figure('Name','Raw B Magntiude Stationary Plots');
subplot(5,1,1);
plot(num(11522:15362),avg_mag(11522:15362));
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 1');

subplot(5,1,2);
plot(num(95681:99201),avg_mag(95681:99201));
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 2');

subplot(5,1,3);
plot(num(108929:111745),avg_mag(108929:111745));
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('BMagnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 3');

subplot(5,1,4);
plot(num(146881:149761),avg_mag(146881:149761));
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 4');

subplot(5,1,5);
plot(num(223681:227521),avg_mag(223681:227521));
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 5');


% USE INTERP1 TO STANDARDIZE TIME STEP SIZE
%  Create t, B_avg arrays for stationary sections
t_stat1 = num(11522:15362);
B_stat1 = avg_mag(11522:15362);

t_stat2 = num(95681:99201);
B_stat2 = avg_mag(95681:99201);

t_stat3 = num(108929:111745);
B_stat3 = avg_mag(108929:111745);

t_stat4 = num(146881:149761);
B_stat4 = avg_mag(146881:149761);

t_stat5 = num(223681:227521);
B_stat5 = avg_mag(223681:227521);

% Smooth out all arrays for each stationary section

% dt_1 = t_stat1(end) - t_stat1(1); AB1 = datestr(dt_1,'mm/dd/yyyy HH:MM:SS.FFF')
% dt_2 = t_stat2(end) - t_stat2(1); AB2 = datestr(dt_2,'mm/dd/yyyy HH:MM:SS.FFF')
% dt_3 = t_stat3(end) - t_stat3(1); AB3 = datestr(dt_3,'mm/dd/yyyy HH:MM:SS.FFF')
% dt_4 = t_stat4(end) - t_stat4(1); AB4 = datestr(dt_4,'mm/dd/yyyy HH:MM:SS.FFF')
% dt_5 = t_stat5(end) - t_stat5(1); AB5 = datestr(dt_5,'mm/dd/yyyy HH:MM:SS.FFF')

%  stat1
ti_1 = [t_stat1(1):1/(5487100):t_stat1(end)]'; %, 01:00.00 time delta,  0.0160 msec resolution

B_stat1_in = interp1(t_stat1,B_stat1,ti_1);
lat_stat1_in = interp1(t_stat1,lat(11522:15362),ti_1);
long_stat1_in = interp1(t_stat1,long(11522:15362),ti_1);
bx_stat1_in = interp1(t_stat1,bx(11522:15362),ti_1);
by_stat1_in = interp1(t_stat1,by(11522:15362),ti_1);
bz_stat1_in = interp1(t_stat1,bz(11522:15362),ti_1);
px_stat1_in = interp1(t_stat1,px(11522:15362),ti_1);
py_stat1_in = interp1(t_stat1,py(11522:15362),ti_1);
pz_stat1_in = interp1(t_stat1,pz(11522:15362),ti_1);

%  stat2
ti_2 = [t_stat2(1):1/(5463600):t_stat2(end)]'; %, 00:55.00 time delta, 0.0160 msec resolution

B_stat2_in = interp1(t_stat2,B_stat2,ti_2);
lat_stat2_in = interp1(t_stat2,lat(95681:99201),ti_2);
long_stat2_in = interp1(t_stat2,long(95681:99201),ti_2);
bx_stat2_in = interp1(t_stat2,bx(95681:99201),ti_2);
by_stat2_in = interp1(t_stat2,by(95681:99201),ti_2);
bz_stat2_in = interp1(t_stat2,bz(95681:99201),ti_2);
px_stat2_in = interp1(t_stat2,px(95681:99201),ti_2);
py_stat2_in = interp1(t_stat2,py(95681:99201),ti_2);
pz_stat2_in = interp1(t_stat2,pz(95681:99201),ti_2);

%  stat3
ti_3 = [t_stat3(1):1/(5511500):t_stat3(end)]'; %, 00:44.00 time delta, 0.0160 msec resolution

B_stat3_in = interp1(t_stat3,B_stat3,ti_3);
lat_stat3_in = interp1(t_stat3,lat(108929:111745),ti_3);
long_stat3_in = interp1(t_stat3,long(108929:111745),ti_3);
bx_stat3_in = interp1(t_stat3,bx(108929:111745),ti_3);
by_stat3_in = interp1(t_stat3,by(108929:111745),ti_3);
bz_stat3_in = interp1(t_stat3,bz(108929:111745),ti_3);
px_stat3_in = interp1(t_stat3,px(108929:111745),ti_3);
py_stat3_in = interp1(t_stat3,py(108929:111745),ti_3);
pz_stat3_in = interp1(t_stat3,pz(108929:111745),ti_3);

%  stat4
ti_4 = [t_stat4(1):1/(5516800):t_stat4(end)]'; %, 00:45.00 time delta, 0.0160 msec resolution

B_stat4_in = interp1(t_stat4,B_stat4,ti_4);
lat_stat4_in = interp1(t_stat4,lat(146881:149761),ti_4);
long_stat4_in = interp1(t_stat4,long(146881:149761),ti_4);
bx_stat4_in = interp1(t_stat4,bx(146881:149761),ti_4);
by_stat4_in = interp1(t_stat4,by(146881:149761),ti_4);
bz_stat4_in = interp1(t_stat4,bz(146881:149761),ti_4);
px_stat4_in = interp1(t_stat4,px(146881:149761),ti_4);
py_stat4_in = interp1(t_stat4,py(146881:149761),ti_4);
pz_stat4_in = interp1(t_stat4,pz(146881:149761),ti_4);

%  stat5
ti_5 = [t_stat5(1):1/(5487100):t_stat5(end)]'; %, 01:00.00 time delta, 0.0160 msec resolution

B_stat5_in = interp1(t_stat5,B_stat5,ti_5);
lat_stat5_in = interp1(t_stat5,lat(223681:227521),ti_5);
long_stat5_in = interp1(t_stat5,long(223681:227521),ti_5);
bx_stat5_in = interp1(t_stat5,bx(223681:227521),ti_5);
by_stat5_in = interp1(t_stat5,by(223681:227521),ti_5);
bz_stat5_in = interp1(t_stat5,bz(223681:227521),ti_5);
px_stat5_in = interp1(t_stat5,px(223681:227521),ti_5);
py_stat5_in = interp1(t_stat5,py(223681:227521),ti_5);
pz_stat5_in = interp1(t_stat5,pz(223681:227521),ti_5);

%  PLOT INTERPORALTED B FOR EACH SEGMENT

% stat1
figure('Name','Interpolated B Magntiude Stationary Plots');
subplot(5,1,1);
plot(ti_1,B_stat1_in);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 1');

% stat2
subplot(5,1,2);
plot(ti_2,B_stat2_in);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 2');

% stat3
subplot(5,1,3);
plot(ti_3,B_stat3_in);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('BMagnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 3');

% stat4
subplot(5,1,4);
plot(ti_4,B_stat4_in);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 4');

% stat5
subplot(5,1,5);
plot(ti_5,B_stat5_in);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 5');


% COMPUTE AUTOCORRELATION FOR STATIONARY SECTIONS

%  stat1
% Compute full manual autocorrelation
x = B_stat1_in;
 for k=0:size(B_stat1_in,1)-2
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
     cc_1(k+1) = ttop/tbottom;
 end

c_lag_1=(0:size(B_stat1_in,1)-2);

%  stat2
% Compute full manual autocorrelation
x = B_stat2_in;
 for k=0:size(B_stat2_in,1)-2
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
     cc_2(k+1) = ttop/tbottom;
 end

c_lag_2=(0:size(B_stat2_in,1)-2);

%  stat3
% Compute full manual autocorrelation
x = B_stat3_in;
 for k=0:size(B_stat3_in,1)-2
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
     cc_3(k+1) = ttop/tbottom;
 end

c_lag_3=(0:size(B_stat3_in,1)-2);

%  stat4
% Compute full manual autocorrelation
x = B_stat4_in;
 for k=0:size(B_stat4_in,1)-2
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
     cc_4(k+1) = ttop/tbottom;
 end

c_lag_4=(0:size(B_stat4_in,1)-2);

%  stat5
% Compute full manual autocorrelation
x = B_stat5_in;
 for k=0:size(B_stat5_in,1)-2
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
     cc_5(k+1) = ttop/tbottom;
 end

c_lag_5=(0:size(B_stat5_in,1)-2);

% Plot full autocorrelation
figure('Name','Autocorrelation Functions');
subplot(5,1,1);
plot(c_lag_1,cc_1);
axis([0 max(c_lag_1) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Autocorrelation Function - Stationary 1');

subplot(5,1,2);
plot(c_lag_2,cc_2);
axis([0 max(c_lag_2) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Autocorrelation Function - Stationary 2');

subplot(5,1,3);
plot(c_lag_3,cc_3);
axis([0 max(c_lag_3) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Autocorrelation Function - Stationary 3');

subplot(5,1,4);
plot(c_lag_4,cc_4);
axis([0 max(c_lag_4) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Autocorrelation Function - Stationary 4');

subplot(5,1,5);
plot(c_lag_5,cc_5);
axis([0 max(c_lag_5) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Autocorrelation Function - Stationary 5');


% %  PLOT B AND AUTOCORRELATION TOGETHER FOR EACH SEGMENT
% % stat1
% figure('Name','Stationary 1: Magrnitude and Autocorrelation');
% subplot(2,1,1);
% plot(ti_1,B_stat1_in);
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('B Magnitude (nT)');
% title('Magnetic Field Magnitude for 11 August 2012 - Stationary 1');
% 
% subplot(2,1,2);
% plot(c_lag_1,cc_1);
% xlabel('Lags');
% ylabel('Autocorrelation');
% title('Autocorrelation Function - Stationary 1');
% 
% % stat2
% figure('Name','Stationary 2: Magrnitude and Autocorrelation');
% subplot(2,1,1);
% plot(ti_2,B_stat2_in);
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('B Magnitude (nT)');
% title('Magnetic Field Magnitude for 11 August 2012 - Stationary 2');
% 
% subplot(2,1,2);
% plot(c_lag_2,cc_2);
% axis([0 max(c_lag_2) -1 1])
% xlabel('Lags');
% ylabel('Autocorrelation');
% title('Autocorrelation Function - Stationary 2');
% 
% % stat3
% figure('Name','Stationary 3: Magrnitude and Autocorrelation');
% subplot(2,1,1);
% plot(ti_3,B_stat3_in);
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('BMagnitude (nT)');
% title('Magnetic Field Magnitude for 11 August 2012 - Stationary 3');
% 
% subplot(2,1,2);
% plot(c_lag_3,cc_3);
% xlabel('Lags');
% ylabel('Autocorrelation');
% title('Autocorrelation Function - Stationary 3');
% 
% % stat4
% figure('Name','Stationary 4: Magrnitude and Autocorrelation');
% subplot(2,1,1);
% plot(ti_4,B_stat4_in);
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('B Magnitude (nT)');
% title('Magnetic Field Magnitude for 11 August 2012 - Stationary 4');
% 
% subplot(2,1,2);
% plot(c_lag_4,cc_4);
% xlabel('Lags');
% ylabel('Autocorrelation');
% title('Autocorrelation Function - Stationary 4');
% 
% % stat5
% figure('Name','Stationary 5: Magrnitude and Autocorrelation');
% subplot(2,1,1);
% plot(ti_5,B_stat5_in);
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('B Magnitude (nT)');
% title('Magnetic Field Magnitude for 11 August 2012 - Stationary 5');
% 
% subplot(2,1,2);
% plot(c_lag_5,cc_5);
% xlabel('Lags');
% ylabel('Autocorrelation');
% title('Autocorrelation Function - Stationary 5');


% CONDUCT POLYFIT ON AUTOCORR FUNCTIONS

% stat1
p1 = polyfit(c_lag_1,cc_1,10);
f1 = polyval(p1,c_lag_1);

figure('Name','Polyfit to Autocorrelation');
subplot(5,1,1)
plot(c_lag_1,cc_1,'b',c_lag_1,f1,'--r');
axis([0 max(c_lag_1) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Polyfit to Autocorrelation Function - Stationary 1');
legend('Autocorr','Poly p=10');

% stat2
p2 = polyfit(c_lag_2,cc_2,10);
f2 = polyval(p2,c_lag_2);

subplot(5,1,2)
plot(c_lag_2,cc_2,'b',c_lag_2,f2,'--r');
axis([0 max(c_lag_2) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Polyfit to Autocorrelation Function - Stationary 2');

% stat3
p3 = polyfit(c_lag_3,cc_3,10);
f3 = polyval(p3,c_lag_3);

subplot(5,1,3)
plot(c_lag_3,cc_3,'b',c_lag_3,f3,'--r');
axis([0 max(c_lag_3) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Polyfit to Autocorrelation Function - Stationary 3');

% stat4
p4 = polyfit(c_lag_4,cc_4,10);
f4 = polyval(p4,c_lag_4);

subplot(5,1,4)
plot(c_lag_4,cc_4,'b',c_lag_4,f4,'--r');
axis([0 max(c_lag_4) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Polyfit to Autocorrelation Function - Stationary 4');

% stat5
p5 = polyfit(c_lag_5,cc_5,10);
f5 = polyval(p5,c_lag_5);

subplot(5,1,5)
plot(c_lag_5,cc_5,'b',c_lag_5,f5,'--r');
axis([0 max(c_lag_5) -1 1])
xlabel('Lags');
ylabel('Autocorrelation');
title('Polyfit to Autocorrelation Function - Stationary 5');

% CONDUCT FFT ON INTERPOLATED B

% stat1
Fs = datenum('08/11/2012 00:00:00.016','mm/dd/yyyy HH:MM:SS.FFF');% Sampling frequency
L1 = size(B_stat1_in,1); % Length of signal
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of array
ft_1 = fft(B_stat1_in,NFFT1)/L1;
ft_p_1 = Fs/2*linspace(0,1,NFFT1/2+1);

%  Plot single-sided amplitude spectrum
figure();
plot(ft_p_1,2*abs(ft_1(1:NFFT1/2+1))) 
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 1')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

% stat2
L2 = size(B_stat2_in,1); % Length of signal
NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of array
ft_2 = fft(B_stat2_in,NFFT2)/L2;
ft_p_2 = Fs/2*linspace(0,1,NFFT2/2+1);

%  Plot single-sided amplitude spectrum
figure();
plot(ft_p_2,2*abs(ft_2(1:NFFT2/2+1))) 
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 2')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

% stat3
L3 = size(B_stat3_in,1); % Length of signal
NFFT3 = 2^nextpow2(L3); % Next power of 2 from length of array
ft_3 = fft(B_stat3_in,NFFT3)/L3;
ft_p_3 = Fs/2*linspace(0,1,NFFT3/2+1);

%  Plot single-sided amplitude spectrum
figure();
plot(ft_p_3,2*abs(ft_3(1:NFFT3/2+1))) 
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 3')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

% stat4
L4 = size(B_stat4_in,1); % Length of signal
NFFT4 = 2^nextpow2(L4); % Next power of 2 from length of array
ft_4 = fft(B_stat4_in,NFFT4)/L4;
ft_p_4 = Fs/2*linspace(0,1,NFFT4/2+1);

%  Plot single-sided amplitude spectrum
figure();
plot(ft_p_4,2*abs(ft_4(1:NFFT4/2+1))) 
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 4')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

% stat5
L5 = size(B_stat5_in,1); % Length of signal
NFFT5 = 2^nextpow2(L5); % Next power of 2 from length of array
ft_5 = fft(B_stat5_in,NFFT5)/L5;
ft_p_5 = Fs/2*linspace(0,1,NFFT5/2+1);

%  Plot single-sided amplitude spectrum
figure();
plot(ft_p_5,2*abs(ft_5(1:NFFT5/2+1))) 
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 5')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

