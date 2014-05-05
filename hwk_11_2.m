clear; clc;

% Build compounded sinusoidal curve
t = [0:1/100:100*pi];
A1 = 1;
A2 = 5;
f1 = 3;
f2 = 0.5;
y1 = A1*sin(2*pi*t*f1);
y2 = A2*sin(2*pi*t*f2)+5*randn(1,size(t,2));
y_c = y1+y2;

figure(1);
subplot(2,1,1);
plot(t(1:300*4),y_c(1:300*4));
title('Compounded Sinusoidal Wave: f1 = 3, f2 = 0.5')
xlabel('time (s)')
ylabel('Y(t)')

% Conduct FFT on compounded data, iterated over the sample size
Fs = t(2)-t(1);% Sampling frequency
k=0;
p1=zeros(100,1);
p2=zeros(100,1);
for i=300:300:300*100
    k=k+1; % run number
    L2 = size(y_c(1:i),2); % Length of signal
    NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of array
    ft_2 = fft(y_c(1:i)-mean(y_c(1:i)),NFFT2)/L2;
    ft_p_2 = 1/Fs*[0:1/NFFT2:1/2];
    
    % Find peak values
    [pks1,locs1] = findpeaks(2*abs(ft_2(2:NFFT2/2+1)),'MINPEAKDISTANCE',round((f1-f2)*size(ft_p_2,2)/ft_p_2(end))-1,'NPEAKS',2);
     p1(k) = pks1(1,1);
     p2(k) = pks1(1,2);
end


figure(1);
subplot(2,1,2);
kk = [1:100];
plot(kk,p1,'bo',kk,p2,'ro') 
title('Compounded Sinusoidal Wave Amplitude')
xlabel('Runs')
ylabel('|Y(f)| Peak Value')


% Compute stddev
jj = [1:20];
m=0;
for j=5:5:100
    m=m+1;
    v1(m) = std(p1(j-5+1:j));
    v2(m) = std(p2(j-5+1:j));
end

figure(2);
plot(jj,v1,'bo',jj,v2,'ro');
title('Peak Magnitude Variance: Every 5 bins')
xlabel('Bin Counter')
ylabel('Variance in |Y(f)| Peak Value')
