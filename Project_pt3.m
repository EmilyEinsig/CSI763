clear; clc;

% https://raw.githubusercontent.com/EmilyEinsig/CSI763/master/RBSP.txt

% Read in data, format date & time columns

if ~exist('RBSP.mat')
    fid = fopen('RBSP.txt');
    r = fscanf(fid,'%c');
    fclose(fid);
    
    r = regexprep(r,'/',' ');
    r = regexprep(r,':',' ');
    r = regexprep(r,' ([0-9][0-9])\.([0-9][0-9][0-9])\.([0-9][0-9][0-9])',' $1 $2 $3');
    d = str2num(r);
    
    dn = datenum(d(:,1:3));
    dn = (dn-dn(1))*1000000*86400;

    ms = dn + d(:,4)*1000000*60*60 + d(:,5)*1000000*60 + d(:,6)*1000000 + d(:,7)*1000 + d(:,8);
    save RBSP.mat
else
    load RBSP.mat
end

% Use interp1 to standardize step size for time, B_mag
ti = [ms(1):15625:ms(end)]; % ~16 msec time step

B = d(:,9);

Bi = interp1(ms,B,ti);


%  Create t, B_avg arrays for stationary sections
ti_1 = ti(11522:15362);
Bi_1 = Bi(11522:15362);

ti_2 = ti(95681:99201);
Bi_2 = Bi(95681:99201);

ti_3 = ti(108929:111745);
Bi_3 = Bi(108929:111745);

ti_4 = ti(146881:149761);
Bi_4 = Bi(146881:149761);

ti_5 = ti(223681:227521);
Bi_5 = Bi(223681:227521);


%  PLOT INTERPORALTED B FOR EACH SEGMENT

% stat1
figure('Name','Interpolated B Magntiude Stationary Plots');
subplot(5,1,1);
plot(ti_1,Bi_1);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 1');

% stat2
subplot(5,1,2);
plot(ti_2,Bi_2);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 2');

% stat3
subplot(5,1,3);
plot(ti_3,Bi_3);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('BMagnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 3');

% stat4
subplot(5,1,4);
plot(ti_4,Bi_4);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 4');

% stat5
subplot(5,1,5);
plot(ti_5,Bi_5);
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Magnetic Field Magnitude for 11 August 2012 - Stationary 5');


% COMPUTE AUTOCORRELATION FOR STATIONARY SECTIONS

%  stat1
% Compute full manual autocorrelation
x = Bi_1;
 for k=0:size(Bi_1,2)-2
     x_m = x(k+1:size(x,2));
     x_p = x(1:size(x,2)-k);
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

c_lag_1=(0:size(Bi_1,2)-2);

%  stat2
% Compute full manual autocorrelation
x = Bi_2;
 for k=0:size(Bi_2,2)-2
     x_m = x(k+1:size(x,2));
     x_p = x(1:size(x,2)-k);
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

c_lag_2=(0:size(Bi_2,2)-2);

%  stat3
% Compute full manual autocorrelation
x = Bi_3;
 for k=0:size(Bi_3,2)-2
     x_m = x(k+1:size(x,2));
     x_p = x(1:size(x,2)-k);
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

c_lag_3=(0:size(Bi_3,2)-2);

%  stat4
% Compute full manual autocorrelation
x = Bi_4;
 for k=0:size(Bi_4,2)-2
     x_m = x(k+1:size(x,2));
     x_p = x(1:size(x,2)-k);
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

c_lag_4=(0:size(Bi_4,2)-2);

%  stat5
% Compute full manual autocorrelation
x = Bi_5;
 for k=0:size(Bi_5,2)-2
     x_m = x(k+1:size(x,2));
     x_p = x(1:size(x,2)-k);
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

c_lag_5=(0:size(Bi_5,2)-2);

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


% CONDUCT FFT ON INTERPOLATED B

% stat1
Fs = (ti(2)-ti(1))*10^-6;% Sampling frequency, convert from microseconds to seconds
L1 = size(Bi_1,2); % Length of signal
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of array
ft_1 = fft(Bi_1-mean(Bi_1),NFFT1)/L1;
ft_p_1 = Fs/2*linspace(0,1,NFFT1/2+1);

% stat2
L2 = size(Bi_2,2); % Length of signal
NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of array
ft_2 = fft(Bi_2-mean(Bi_2),NFFT2)/L2;
ft_p_2 = Fs/2*linspace(0,1,NFFT2/2+1);

% stat3
L3 = size(Bi_3,2); % Length of signal
NFFT3 = 2^nextpow2(L3); % Next power of 2 from length of array
ft_3 = fft(Bi_3-mean(Bi_3),NFFT3)/L3;
ft_p_3 = Fs/2*linspace(0,1,NFFT3/2+1);

% stat4
L4 = size(Bi_4,2); % Length of signal
NFFT4 = 2^nextpow2(L4); % Next power of 2 from length of array
ft_4 = fft(Bi_4-mean(Bi_4),NFFT4)/L4;
ft_p_4 = Fs/2*linspace(0,1,NFFT4/2+1);

% stat5
L5 = size(Bi_5,2); % Length of signal
NFFT5 = 2^nextpow2(L5); % Next power of 2 from length of array
ft_5 = fft(Bi_5-mean(Bi_5),NFFT5)/L5;
ft_p_5 = Fs/2*linspace(0,1,NFFT5/2+1);


%  Plot single-sided amplitude spectrum
figure();
plot(ft_p_1(10:end),2*abs(ft_1(10:NFFT1/2+1)),ft_p_2(10:end),2*abs(ft_2(10:NFFT2/2+1)),ft_p_3(10:end),2*abs(ft_3(10:NFFT3/2+1)),ft_p_4(10:end),2*abs(ft_4(10:NFFT4/2+1)),ft_p_5(10:end),2*abs(ft_5(10:NFFT5/2+1))) 
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 1')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')
Legend('Stationary 1','Stationary 2','Stationary 3','Stationary 4','Stationary 5')

figure();
subplot(5,1,1);
plot(ft_p_1(10:end),2*abs(ft_1(10:NFFT1/2+1)))
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 1')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

subplot(5,1,2);
plot(ft_p_2(10:end),2*abs(ft_2(10:NFFT2/2+1)))
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 2')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

subplot(5,1,3);
plot(ft_p_3(10:end),2*abs(ft_3(10:NFFT3/2+1)))
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 3')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

subplot(5,1,4);
plot(ft_p_4(10:end),2*abs(ft_4(10:NFFT4/2+1)))
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 4')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')

subplot(5,1,5);
plot(ft_p_5(10:end),2*abs(ft_5(10:NFFT5/2+1)))
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 5')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')



