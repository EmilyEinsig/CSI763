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

figure(1);
subplot(2,1,1);
plot(t,y(:,1),'-b',t,y_m,'r');
title('Weak Sinusoidal Wave: A = 0.1, f = 5 Hz')
xlabel('time (s)')
ylabel('Y(t)')
legend('Single Batch','Averaged over 100 runs');

% Conduct FFT on data
Fs = t(2)-t(1);% Sampling frequency
L1 = size(y,2); % Length of signal
NFFT1 = 2^nextpow2(L1); % Next power of 2 from length of array
ft_1 = fft(y(:,1)-mean(y(:,1)),NFFT1)/L1;
ft_p_1 = 1/Fs*[0:1/NFFT1:1/2];

L2 = size(y_m,2); % Length of signal
NFFT2 = 2^nextpow2(L2); % Next power of 2 from length of array
ft_2 = fft(y_m-mean(y_m),NFFT2)/L2;
ft_p_2 = 1/Fs*[0:1/NFFT2:1/2];

figure(1);
subplot(2,1,2);
plot(ft_p_1(2:end),2*abs(ft_1(2:NFFT1/2+1))-mean(2*abs(ft_1(2:NFFT1/2+1))),'b',ft_p_2(2:end),2*abs(ft_2(2:NFFT2/2+1)),'r') 
title('Single Sinusoidal Wave Amplitude')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
legend('Single Batch','Averaged over 100 runs');


