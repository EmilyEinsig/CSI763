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
 ft_1_z = 2*abs(ft_1(2:NFFT1/2+1));
[max_value11, index11] = max(ft_1_z(1:end));
ft_1_z(index11-1:index11+1)=0;
[max_value21, index21] = max(ft_1_z(10:end));
ft_1_z(index21-1:index21+1)=0;


figure(1);
subplot(2,1,1);
plot(ft_p_1(2:end),2*abs(ft_1(2:NFFT1/2+1))) 
hold on;
plot([ft_p_1(index21),ft_p_1(index21)],[0,0.6],'k-');
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 1')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')
hold off;
subplot(2,1,2);
plot(ft_p_1(2:end),ft_1_z) 
title('Single-Sided Amplitude Spectrum of B(t) - Stationary 1')
xlabel('Frequency (Hz)')
ylabel('|B(f)|')
axis([0 35 0 0.6]);

 
%  % stat2
%  ft_2_z = 2*abs(ft_2(2:NFFT2/2+1));
% [max_value12, index12] = max(ft_2_z(1:end));
% ft_2_z(index12-1:index12+1)=0;
% [max_value22, index22] = max(ft_2_z(10:end));
% ft_2_z(index22-1:index22+1)=0;
%  
%  % stat3
%  ft_3_z = ft_3;
% [max_value13, index13] = max(2*abs(ft_3_z(2:NFFT3/2+1)));
% ft_3_z(index13:index13+2)=0;
% [max_value23, index23] = max(2*abs(ft_3_z(10:NFFT3/2+1)));
% ft_3_z(index23:index23+2)=0;
%  
%  % stat4
%  ft_4_z = ft_4;
% [max_value14, index14] = max(2*abs(ft_4_z(2:NFFT4/2+1)));
% ft_4_z(index14:index14+2)=0;
% [max_value24, index24] = max(2*abs(ft_4_z(10:NFFT4/2+1)));
% ft_4_z(index24:index24+2)=0;
%  
%  % stat5
%  ft_5_z = ft_5;
% [max_value15, index15] = max(2*abs(ft_5_z(2:NFFT5/2+1)));
% ft_5_z(index15:index15+2)=0;
% [max_value25, index25] = max(2*abs(ft_5_z(10:NFFT5/2+1)));
% ft_5_z(index25:index25+2)=0;


% Calculate inverse FFT
% Bi_1_z = ifft(ft_1_z,NFFT1)*L1+mean(Bi_1);
% Bi_2_z = ifft(ft_2_z,NFFT2)*L2+mean(Bi_2);
% Bi_3_z = ifft(ft_3_z,NFFT3)*L3+mean(Bi_3);
% Bi_4_z = ifft(ft_4_z,NFFT4)*L4+mean(Bi_4);
% Bi_5_z = ifft(ft_5_z,NFFT5)*L5+mean(Bi_5);

% Plot results of inverse FFT

% stat1
% figure(1);
% subplot(5,1,1);
% plot(ti_1,abs(Bi_1_z(1:size(ti_1,2))));
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('B Magnitude (nT)');
% title('Inverse FFT on B Magnitude - Stationary 1');
% 
% % stat2
% subplot(5,1,2);
% plot(ti_2,abs(Bi_2_z(1:size(ti_2,2))));
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('B Magnitude (nT)');
% title('Inverse FFT on B Magnitude - Stationary 2');
% 
% % stat3
% subplot(5,1,3);
% plot(ti_3,abs(Bi_3_z(1:size(ti_3,2))));
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('BMagnitude (nT)');
% title('Inverse FFT on B Magnitude - Stationary 3');
% 
% % stat4
% subplot(5,1,4);
% plot(ti_4,abs(Bi_4_z(1:size(ti_4,2))));
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('B Magnitude (nT)');
% title('Inverse FFT on B Magnitude - Stationary 4');
% 
% % stat5
% subplot(5,1,5);
% plot(ti_5,abs(Bi_5_z(1:size(ti_5,2))));
% datetick('x','HH:MM:SS');
% xlabel('Time');
% ylabel('B Magnitude (nT)');
% title('Inverse FFT on B Magnitude - Stationary 5');


% CONDUCT FFT ON MOVING WINDOW OF INVERSED B MAGNITUDE
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


