clear; clc;

% Build single sinusoidal curve
t = [0:1/100:4*pi];
A = 1;
f = 5;
y = A*sin(2*pi*t*f);

figure(1);
subplot(2,1,1);
plot(t,y);
title('Single Sinusoidal Wave: f = 5')
xlabel('time (s)')
ylabel('Y(t)')

% Conduct FFT on data
Fs = t(2)-t(1);% Sampling frequency
L1 = size(y,2); % Length of signal
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of array
ft_1 = fft(y-mean(y),NFFT1)/L1;
ft_p_1 = 1/Fs*[0:1/NFFT1:1/2];

subplot(2,1,2);
plot(ft_p_1(2:end),2*abs(ft_1(2:NFFT1/2+1))) 
title('Single Sinusoidal Wave Amplitude')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


% Build compounded sinusoidal curve
t = [0:1/100:4*pi];
A = 1;
f1 = 5;
f2 = 0.5;
y1 = A*sin(2*pi*t*f1);
y2 = A*sin(2*pi*t*f2);
y_c = y1+y2;

figure(2);
subplot(2,1,1);
plot(t,y_c);
title('Compounded Sinusoidal Wave: f1 = 5, f2 = 0.5')
xlabel('time (s)')
ylabel('Y(t)')

% Conduct FFT on compounded data
Fs = t(2)-t(1);% Sampling frequency
L2 = size(y_c,2); % Length of signal
NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of array
ft_2 = fft(y_c-mean(y_c),NFFT2)/L2;
ft_p_2 = 1/Fs*[0:1/NFFT2:1/2];

subplot(2,1,2);
plot(ft_p_2(2:end),2*abs(ft_2(2:NFFT2/2+1))) 
title('Compounded Sinusoidal Wave Amplitude')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


% Build non-periodic sinusoidal curve
t = [0:1/100:4*pi];
A = 1;
f3 = randn(1257);
y_n = A*sin(2*pi*t*f3);

figure(3);
subplot(2,1,1);
plot(t,y_n);
title('Non-Periodic Sinusoidal Wave')
xlabel('time (s)')
ylabel('Y(t)')

% Conduct FFT on compounded data
Fs = t(2)-t(1);% Sampling frequency
L3 = size(y_n,2); % Length of signal
NFFT3 = 2^nextpow2(L3); % Next power of 2 from length of array
ft_3 = fft(y_n-mean(y_n),NFFT3)/L3;
ft_p_3 = 1/Fs*[0:1/NFFT3:1/2];

subplot(2,1,2);
plot(ft_p_3(2:end),2*abs(ft_3(2:NFFT2/2+1))) 
title('Non-periodic Sinusoidal Wave Amplitude')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')