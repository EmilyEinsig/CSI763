clear; clc;

N  = 10^3;
t  = [0:N-1]';
f1 = (N/100)/N;
f2 = (N/8)/N;

x1 = 1.0*sin(2*pi*f1*t);
x2 = 1.0*sin(2*pi*f2*t);

Iz1     = [1:400,501:N];
Iz2     = [1:400,409:N];
x1(Iz1) = 0;
x2(Iz2) = 0;
x = x1+x2;

for i = 1:10
  a = 1+100*(i-1);
  b = a+99;
  tr(i) = a+50-1;
  [Ir,fr] = periodogramraw(x(a:b)); 
  Sr(:,i) = Ir;
end

figure(7);clf;
pcolor(tr,fr,log10(Sr));   
axis xy; axis tight; colormap(jet);
ylabel('Frequency');
xlabel('t (time step)');
colorbar;caxis([-2 1]);
title('log_{10} of raw spectrogram amplitudes for all data')
