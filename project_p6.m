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


% Zero out data (partially zeroed data: take out ~14.35 Hz peak)
    % 14.35 Hz peak due to knonw instrumentation bias, 0.1 Hz due to
    % satellite's rotation

% Calculate FFTs
Fs = (ti(2)-ti(1))*10^-6;% Sampling frequency, convert from microseconds to seconds

% stat 1
L1 = size(Bi_1,2); % Length of signal
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of array
ft_1 = fft(Bi_1-mean(Bi_1),NFFT1)/L1;
ft_p_1 = 1/Fs*[0:1/NFFT1:1/2];

% stat 2
L2 = size(Bi_2,2); % Length of signal
NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of array
ft_2 = fft(Bi_2-mean(Bi_2),NFFT2)/L2;
ft_p_2 = 1/Fs*[0:1/NFFT2:1/2];
    
% stat 3
L3 = size(Bi_3,2); % Length of signal
NFFT3 = 2^nextpow2(L3); % Next power of 2 from length of array
ft_3 = fft(Bi_3-mean(Bi_3),NFFT3)/L3;
ft_p_3 = 1/Fs*[0:1/NFFT3:1/2];

% stat 4
L4 = size(Bi_4,2); % Length of signal
NFFT4 = 2^nextpow2(L4); % Next power of 2 from length of array
ft_4 = fft(Bi_4-mean(Bi_4),NFFT4)/L4;
ft_p_4 = 1/Fs*[0:1/NFFT4:1/2];

% stat 5
L5 = size(Bi_5,2); % Length of signal
NFFT5 = 2^nextpow2(L5); % Next power of 2 from length of array
ft_5 = fft(Bi_5-mean(Bi_5),NFFT5)/L5;
ft_p_5 = 1/Fs*[0:1/NFFT5:1/2];


% Zero out peaks  

% stat1
ft_1_z = ft_1;
[max_value21, index21] = max(2*abs(ft_1(10:NFFT1/2+1)));
index21 = index21+9;
ft_1_z(index21-10:index21+12)=1/2*(abs(mean(ft_1(index21-19:index21-9)))+abs(mean(ft_1(index21+13:index21+23))));
ft_1_z(end-index21-10:end-index21+12)=1/2*(abs(mean(ft_1(end-index21-19:end-index21-9)))+abs(mean(ft_1(end-index21+13:end-index21+23)))); % need to mirror zeroing
 
% stat2
ft_2_z = ft_2;
[max_value22, index22] = max(2*abs(ft_2(10:NFFT2/2+1)));
index22 = index22+9;
ft_2_z(index22-10:index22+12)=1/2*(abs(mean(ft_2(index22-19:index22-9)))+abs(mean(ft_2(index22+13:index22+23))));
ft_2_z(end-index22-10:end-index22+12)=1/2*(abs(mean(ft_2(end-index22-19:end-index22-9)))+abs(mean(ft_2(end-index22+13:end-index22+23)))); % need to mirror zeroing
 
% stat3
ft_3_z = ft_3;
[max_value23, index23] = max(2*abs(ft_3(10:NFFT3/2+1)));
index23 = index23+9;
ft_3_z(index23-10:index23+14)=1/2*(abs(mean(ft_3(index23-19:index23-9)))+abs(mean(ft_3(index23+13:index23+23))));
ft_3_z(end-index23-10:end-index23+12)=1/2*(abs(mean(ft_3(end-index23-19:end-index23-9)))+abs(mean(ft_3(end-index23+13:end-index23+23)))); % need to mirror zeroing

% stat4
ft_4_z = ft_4;
[max_value24, index24] = max(2*abs(ft_4(10:NFFT4/2+1)));
index24 = index24+9;
ft_4_z(index24-10:index24+12)=1/2*(abs(mean(ft_4(index24-19:index24-9)))+abs(mean(ft_4(index24+13:index24+23))));
ft_4_z(end-index24-10:end-index24+12)=1/2*(abs(mean(ft_4(end-index24-19:end-index24-9)))+abs(mean(ft_4(end-index24+13:end-index24+23)))); % need to mirror zeroing
 
% stat5
ft_5_z = ft_5;
[max_value25, index25] = max(2*abs(ft_5(10:NFFT5/2+1)));
index25 = index25+9;
ft_5_z(index25-10:index25+12)=1/2*(abs(mean(ft_5(index25-19:index25-9)))+abs(mean(ft_5(index25+13:index25+23))));
ft_5_z(end-index25-10:end-index25+12)=1/2*(abs(mean(ft_5(end-index25-19:end-index25-9)))+abs(mean(ft_5(end-index25+13:end-index25+23)))); % need to mirror zeroing

% Calculate inverse FFT
Bi_1_z = ifft(ft_1_z,NFFT1)*L1+mean(Bi_1);
Bi_2_z = ifft(ft_2_z,NFFT2)*L2+mean(Bi_2);
Bi_3_z = ifft(ft_3_z,NFFT3)*L3+mean(Bi_3);
Bi_4_z = ifft(ft_4_z,NFFT4)*L4+mean(Bi_4);
Bi_5_z = ifft(ft_5_z,NFFT5)*L5+mean(Bi_5);


% % FIND PEAK MAGNITUDES
[pks1,locs1] = findpeaks(abs(Bi_1_z)-mean(abs(Bi_1_z)),'MINPEAKDISTANCE',500,'NPEAKS',6);
[pks2,locs2] = findpeaks(abs(Bi_2_z)-mean(abs(Bi_2_z)),'MINPEAKDISTANCE',500,'NPEAKS',6);
[pks3,locs3] = findpeaks(abs(Bi_3_z)-mean(abs(Bi_3_z)),'MINPEAKDISTANCE',500,'NPEAKS',5);
[pks4,locs4] = findpeaks(abs(Bi_4_z)-mean(abs(Bi_4_z)),'MINPEAKDISTANCE',500,'NPEAKS',5);
[pks5,locs5] = findpeaks(abs(Bi_5_z)-mean(abs(Bi_5_z)),'MINPEAKDISTANCE',500,'NPEAKS',6);


% Plot Peak magntides
t_p6 = [1:6];
t_p5 = [1:5];

figure(1);
plot((ti_1(locs1)-ti_1(1))/(1000000*3600*24),pks1,'-bo'); hold on;
plot((ti_2(locs2)-ti_2(1))/(1000000*3600*24),pks2,'-ro');
plot((ti_3(locs3)-ti_3(1))/(1000000*3600*24),pks3,'-go');
plot((ti_4(locs4)-ti_4(1))/(1000000*3600*24),pks4,'-ko');
plot((ti_5(locs5)-ti_5(1))/(1000000*3600*24),pks5,'-mo');
xlabel('Time (s)');
ylabel('Relative (to mean) Peak Magnitude');
datetick('x','SS');
legend('Stationary 1','Stationary 2','Stationary 3','Stationary 4','Stationary 5');