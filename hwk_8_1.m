clear; clc;

% Show the when a periodogram is smoothed, there is a loss in resolution in frequency

% Build single sinusoidal curve
 t = [0:1/100:4*pi];
 A = 0.1;
 f = 5;

for i = 1:100
    y(:,i) = randn(1,size(t,2)) + A*sin(2*pi*t*f);
end

for j=1:size(t,2)
    y_m(j) = mean(y(j,:));
end

% Conduct FFT on raw data
Fs = t(2)-t(1);% Sampling frequency
L = size(y_m,2); % Length of signal
NFFT = 2^nextpow2(L); % Next power of 2 from length of array
ft = fft(y_m-mean(y_m),NFFT)/L;
ft_p = 1/Fs*[0:1/NFFT:1/2];

% Smooth periodiogram using filter function
y_s = filter([0.15 0.24 0.25 0.2 0.18],1,y_m);
y_s=y_s(6:end);

% Conduct FFT on smoothed data
L_s = size(y_s,2); % Length of signal
NFFT_s = 2^nextpow2(L_s); % Next power of 2 from length of array
ft_s = fft(y_s-mean(y_s),NFFT_s)/L_s;
ft_p_s = 1/Fs*[0:1/NFFT_s:1/2];

% Display results
figure(1);
subplot(2,1,1);
plot(t,y_m,'b',t(6:end),y_s,'r');
title('Weak Sinusoidal Wave: A = 0.1, f = 5 Hz')
xlabel('time (s)')
ylabel('Y(t)')
legend('Original','Smoothed');

figure(1);
subplot(2,1,2);
plot(ft_p(2:end),2*abs(ft(2:NFFT/2+1)),'b')
hold on;
plot(ft_p_s(2:end),2*abs(ft_s(2:NFFT_s/2+1)),'r') 
title('Single Sinusoidal Wave Amplitude')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
legend('Original','Smoothed');
hold off;


