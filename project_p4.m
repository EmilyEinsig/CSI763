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
    
    dn = datenum(d(:,1:3,D,M,Y));
    dn = (dn-dn(1))*1000000*3600*24;

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


% CONDUCT FFT ON INTERPOLATED B

% stat1
Fs = (ti(2)-ti(1))*10^-6;% Sampling frequency, convert from microseconds to seconds
L1 = size(Bi_1,2); % Length of signal
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of array
ft_1 = fft(Bi_1-mean(Bi_1),NFFT1)/L1;
ft_p_1 = 1/Fs*[0:1/NFFT1:1/2];

% stat2
L2 = size(Bi_2,2); % Length of signal
NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of array
ft_2 = fft(Bi_2-mean(Bi_2),NFFT2)/L2;
ft_p_2 = 1/Fs*[0:1/NFFT2:1/2];

% stat3
L3 = size(Bi_3,2); % Length of signal
NFFT3 = 2^nextpow2(L3); % Next power of 2 from length of array
ft_3 = fft(Bi_3-mean(Bi_3),NFFT3)/L3;
ft_p_3 = 1/Fs*[0:1/NFFT3:1/2];

% stat4
L4 = size(Bi_4,2); % Length of signal
NFFT4 = 2^nextpow2(L4); % Next power of 2 from length of array
ft_4 = fft(Bi_4-mean(Bi_4),NFFT4)/L4;
ft_p_4 = 1/Fs*[0:1/NFFT4:1/2];

% stat5
L5 = size(Bi_5,2); % Length of signal
NFFT5 = 2^nextpow2(L5); % Next power of 2 from length of array
ft_5 = fft(Bi_5-mean(Bi_5),NFFT5)/L5;
ft_p_5 = 1/Fs*[0:1/NFFT5:1/2];



% REMOVE KNOWN PEAKS IN PERIODIOGRAM (0.1 Hz, 14.35 Hz)

% Zero out peaks
% stat1
ft_1_z = ft_1;
[max_value11, index11] = max(2*abs(ft_1(2:NFFT1/2+1)));
index11 = index11+1;
ft_1_z(index11-6:index11+12)=mean(ft_1(index11+13:index11+33));
ft_1_z(end-index11-12:end)=mean(ft_1(end-index11-33:end-index11-13)); % need to mirror zeroing
[max_value21, index21] = max(2*abs(ft_1(10:NFFT1/2+1)));
index21 = index21+9;
ft_1_z(index21-10:index21+12)=1/2*(abs(mean(ft_1(index21-19:index21-9)))+abs(mean(ft_1(index21+13:index21+23))));
ft_1_z(end-index21-10:end-index21+12)=1/2*(abs(mean(ft_1(end-index21-19:end-index21-9)))+abs(mean(ft_1(end-index21+13:end-index21+23)))); % need to mirror zeroing
 
% stat2
ft_2_z = ft_2;
[max_value12, index12] = max(2*abs(ft_2(2:NFFT2/2+1)));
index12 = index12+1;
ft_2_z(index12-6:index12+12)=mean(ft_2(index12+13:index12+33));
ft_2_z(end-index12-12:end)=mean(ft_2(end-index12-33:end-index12-13)); % need to mirror zeroing
[max_value22, index22] = max(2*abs(ft_2(10:NFFT2/2+1)));
index22 = index22+9;
ft_2_z(index22-10:index22+12)=1/2*(abs(mean(ft_2(index22-19:index22-9)))+abs(mean(ft_2(index22+13:index22+23))));
ft_2_z(end-index22-10:end-index22+12)=1/2*(abs(mean(ft_2(end-index22-19:end-index22-9)))+abs(mean(ft_2(end-index22+13:end-index22+23)))); % need to mirror zeroing
 
% stat3
ft_3_z = ft_3;
[max_value13, index13] = max(2*abs(ft_3(2:NFFT3/2+1)));
index13 = index13+1;
ft_3_z(index13-6:index13+12)=mean(ft_3(index13+13:index13+33));
ft_3_z(end-index13-12:end)=mean(ft_3(end-index13-33:end-index13-13)); % need to mirror zeroing
[max_value23, index23] = max(2*abs(ft_3(10:NFFT3/2+1)));
index23 = index23+9;
ft_3_z(index23-10:index23+14)=1/2*(abs(mean(ft_3(index23-19:index23-9)))+abs(mean(ft_3(index23+13:index23+23))));
ft_3_z(end-index23-10:end-index23+12)=1/2*(abs(mean(ft_3(end-index23-19:end-index23-9)))+abs(mean(ft_3(end-index23+13:end-index23+23)))); % need to mirror zeroing

% stat4
ft_4_z = ft_4;
[max_value14, index14] = max(2*abs(ft_4(2:NFFT4/2+1)));
index14 = index14+1;
ft_4_z(index14-6:index14+12)=mean(ft_4(index14+13:index14+33));
ft_4_z(end-index14-12:end)=mean(ft_4(end-index14-33:end-index14-13)); % need to mirror zeroing
[max_value24, index24] = max(2*abs(ft_4(10:NFFT4/2+1)));
index24 = index24+9;
ft_4_z(index24-10:index24+12)=1/2*(abs(mean(ft_4(index24-19:index24-9)))+abs(mean(ft_4(index24+13:index24+23))));
ft_4_z(end-index24-10:end-index24+12)=1/2*(abs(mean(ft_4(end-index24-19:end-index24-9)))+abs(mean(ft_4(end-index24+13:end-index24+23)))); % need to mirror zeroing
 
% stat5
ft_5_z = ft_5;
[max_value15, index15] = max(2*abs(ft_5(2:NFFT5/2+1)));
index15 = index15+1;
ft_5_z(index15-6:index15+12)=mean(ft_5(index15+13:index15+33));
ft_5_z(end-index15-12:end)=mean(ft_5(end-index15-33:end-index15-13)); % need to mirror zeroing
[max_value25, index25] = max(2*abs(ft_5(10:NFFT5/2+1)));
index25 = index25+9;
ft_5_z(index25-10:index25+12)=1/2*(abs(mean(ft_5(index25-19:index25-9)))+abs(mean(ft_5(index25+13:index25+23))));
ft_5_z(end-index25-10:end-index25+12)=1/2*(abs(mean(ft_5(end-index25-19:end-index25-9)))+abs(mean(ft_5(end-index25+13:end-index25+23)))); % need to mirror zeroing

% Plot zeroed FFTs
figure(1);
subplot(5,1,1);
plot(ft_p_1(2:end),2*abs(ft_1(2:NFFT1/2+1)),'b') 
hold on;
plot(ft_p_1(2:end),2*abs(ft_1_z(2:NFFT1/2+1)),'r')
title('Stationary 1')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')
axis([0 35 0 0.6]);
legend('Original FFT','Zeroed FFT');
hold off;

subplot(5,1,2);
plot(ft_p_2(2:end),2*abs(ft_2(2:NFFT2/2+1)),'b') 
hold on;
plot(ft_p_2(2:end),2*abs(ft_2_z(2:NFFT2/2+1)),'r')
title('Stationary 2')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')
axis([0 35 0 0.6]);
hold off;

subplot(5,1,3);
plot(ft_p_3(2:end),2*abs(ft_3(2:NFFT3/2+1)),'b') 
hold on;
plot(ft_p_3(2:end),2*abs(ft_3_z(2:NFFT3/2+1)),'r')
title('Stationary 3')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')
axis([0 35 0 0.6]);
hold off;

subplot(5,1,4);
plot(ft_p_4(2:end),2*abs(ft_4(2:NFFT4/2+1)),'b') 
hold on;
plot(ft_p_4(2:end),2*abs(ft_4_z(2:NFFT4/2+1)),'r')
title('Stationary 4')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')
axis([0 35 0 0.6]);
hold off;

subplot(5,1,5);
plot(ft_p_5(2:end),2*abs(ft_5(2:NFFT5/2+1)),'b') 
hold on;
plot(ft_p_5(2:end),2*abs(ft_5_z(2:NFFT5/2+1)),'r')
title('Stationary 5')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')
axis([0 35 0 0.6]);
hold off;



% Calculate inverse FFT
Bi_1_z = ifft(ft_1_z,NFFT1)*L1+mean(Bi_1);
Bi_2_z = ifft(ft_2_z,NFFT2)*L2+mean(Bi_2);
Bi_3_z = ifft(ft_3_z,NFFT3)*L3+mean(Bi_3);
Bi_4_z = ifft(ft_4_z,NFFT4)*L4+mean(Bi_4);
Bi_5_z = ifft(ft_5_z,NFFT5)*L5+mean(Bi_5);

% Plot results of inverse FFT

% stat1
figure(2);
subplot(5,1,1);
plot(ti_1/(1000000*3600*24),abs(Bi_1(1:size(ti_1,2))),'b');
hold on;
plot(ti_1/(1000000*3600*24),abs(Bi_1_z(1:size(ti_1,2))),'r');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Inverse FFT on B Magnitude - Stationary 1');
legend('Original','Zeroed');
hold off;

% stat2
subplot(5,1,2);
plot(ti_2/(1000000*3600*24),abs(Bi_2(1:size(ti_2,2))),'b');
hold on;
plot(ti_2/(1000000*3600*24),abs(Bi_2_z(1:size(ti_2,2))),'r');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Inverse FFT on B Magnitude - Stationary 2');
hold off;

% stat3
subplot(5,1,3);
plot(ti_3/(1000000*3600*24),abs(Bi_3(1:size(ti_3,2))),'b');
hold on;
plot(ti_3/(1000000*3600*24),abs(Bi_3_z(1:size(ti_3,2))),'r');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Inverse FFT on B Magnitude - Stationary 3');
hold off;

% stat4
subplot(5,1,4);
plot(ti_4/(1000000*3600*24),abs(Bi_4(1:size(ti_4,2))),'b');
hold on;
plot(ti_4/(1000000*3600*24),abs(Bi_4_z(1:size(ti_4,2))),'r');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Inverse FFT on B Magnitude - Stationary 4');
hold off;

% stat5
subplot(5,1,5);
plot(ti_5/(1000000*3600*24),abs(Bi_5(1:size(ti_5,2))),'b');
hold on;
plot(ti_5/(1000000*3600*24),abs(Bi_5_z(1:size(ti_5,2))),'r');
datetick('x','HH:MM:SS');
xlabel('Time');
ylabel('B Magnitude (nT)');
title('Inverse FFT on B Magnitude - Stationary 5');
hold off;


% CONDUCT FFT ON MOVING WINDOW OF INVERSED ZEROED B MAGNITUDE
% stat1
% Fs = (ti(2)-ti(1))*10^-6;% Sampling frequency, convert from microseconds to seconds
% L1 = size(Bi_1,2); % Length of signal
% NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of array
% ft_1 = fft(Bi_1-mean(Bi_1),NFFT1)/L1;
% ft_p_1 = 1/Fs*[0:1/NFFT1:1/2];

%  Plot single-sided amplitude spectrum
% figure(2);
% plot(ft_p_1(2:end),2*abs(ft_1(2:NFFT1/2+1))) 
% title('Single-Sided Amplitude Spectrum of B(t) - Stationary 1')
% xlabel('Frequency (Hz)')
% ylabel('|B(f)|')


