clear; clc;

% Create sine wave
N  = 10^3;
t  = [0:N-1]';
f1 = 1/100;
f2 = 1/8;

x1 = 1.0*sin(2*pi*f1*t);
x2 = 1.0*sin(2*pi*f2*t);

Iz1     = [1:400,501:N];
Iz2     = [1:400,409:N];
x1(Iz1) = 0;
x2(Iz2) = 0;
x = x1+x2;

% Calculate periodogram
for i = 1:10
  a = 1+100*(i-1);
  b = a+99;
  tr(i) = a+50-1;
  [Ir,fr] = periodogramraw(x(a:b)); 
  Sr(:,i) = Ir;
end


%WAVETEST Example Matlab script for WAVELET

%------------------------------------------------------ Computation

% normalize by standard deviation (not necessary, but makes it easier
% to compare with plot on Interactive Wavelet page, at
% "http://paos.colorado.edu/research/wavelets/plot/"
variance = std(x)^2;
sst = (x - mean(x))/sqrt(variance) ;

n = length(sst);
dt = 1;
time = t;  % construct time array
xlim = [0,N];  % plotting range
pad = 1;      % pad the time series with zeroes (recommended)
dj = 0.25;    % this will do 4 sub-octaves per octave
s0 = 2*dt;    % this says start at a scale of 6 months
j1 = 7/dj;    % this says do 7 powers-of-two with dj sub-octaves each
lag1 = 0.72;  % lag-1 autocorrelation for red noise background
mother = 'Morlet';

% Wavelet transform:
[wave,period,scale,coi] = wavelet(sst,dt,pad,dj,s0,j1,mother);
power = (abs(wave)).^2 ;        % compute wavelet power spectrum

% Significance levels: (variance=1 for the normalized SST)
[signif,fft_theor] = wave_signif(1.0,dt,scale,0,lag1,-1,-1,mother);
sig95 = (signif')*(ones(1,n));  % expand signif --> (J+1)x(N) array
sig95 = power ./ sig95;         % where ratio > 1, power is significant

% Global wavelet spectrum & significance levels:
global_ws = variance*(sum(power')/n);   % time-average over all times
dof = n - scale;  % the -scale corrects for padding at edges
global_signif = wave_signif(variance,dt,scale,1,lag1,-1,dof,mother);

% Scale-average between El Nino periods of 2--8 years
avg = find((scale >= 2) & (scale < 8));
Cdelta = 0.776;   % this is for the MORLET wavelet
scale_avg = (scale')*(ones(1,n));  % expand scale --> (J+1)x(N) array
scale_avg = power ./ scale_avg;   % [Eqn(24)]
scale_avg = variance*dj*dt/Cdelta*sum(scale_avg(avg,:));   % [Eqn(24)]
scaleavg_signif = wave_signif(variance,dt,scale,2,lag1,-1,[2,7.9],mother);

%------------------------------------------------------ Plotting

%--- Plot time series
figure(2);
subplot('position',[0.1 0.75 0.85 0.2])
plot(time,sst)
set(gca,'XLim',xlim(:))
xlabel('Time (seconds)')
ylabel('Amplitude')
title('Sine Wave: f1 = 0.01, P1 = 100; f2 = 0.125, P2 = 8')
hold off

%--- Plot periodogram
subplot('position',[0.1 0.37 0.85 0.25])
pcolor(tr,fr,log10(Sr));   
axis xy;axis tight;colormap(jet);
ylabel('Frequency');
xlabel('t (time step)');
colorbar;caxis([-2 1]);
title('log_{10} of raw spectrogram amplitudes for all data')

%--- Contour plot wavelet power spectrum
subplot('position',[0.1 0.07 0.65 0.2])
levels = [0.0625,0.125,0.25,0.5,1,2,4,8,16] ;
Yticks = 2.^(fix(log2(min(period))):fix(log2(max(period))));
%contour(time,log2(period),log2(power),log2(levels));  %*** or use 'contourfill'
imagesc(time,log2(period),log2(power));  %*** uncomment for 'image' plot
xlabel('Time (seconds)')
ylabel('Period (seconds)')
title('Sine Wave Wavelet Power Spectrum')
set(gca,'XLim',xlim(:))
set(gca,'YLim',log2([min(period),max(period)]), ...
	'YDir','reverse', ...
	'YTick',log2(Yticks(:)), ...
	'YTickLabel',Yticks)
% 95% significance contour, levels at -99 (fake) and 1 (95% signif)
hold on
contour(time,log2(period),sig95,[-99,1],'k');
hold on
% cone-of-influence, anything "below" is dubious
plot(time,log2(coi),'k')
hold off

%--- Plot global wavelet spectrum
subplot('position',[0.8 0.07 0.15 0.2])
plot(global_ws,log2(period))
hold on
plot(global_signif,log2(period),'--')
hold off
xlabel('Power')
title('Overall Wavelet Spectrum')
set(gca,'YLim',log2([min(period),max(period)]), ...
	'YDir','reverse', ...
	'YTick',log2(Yticks(:)), ...
	'YTickLabel','')
set(gca,'XLim',[0,1.25*max(global_ws)])
