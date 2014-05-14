clear; clc;

% Figure 3: FFT on stationary sections

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


    %  Plot single-sided amplitude spectrum
    figure(1);
    plot(ft_p_1(2:end),2*abs(ft_1(2:NFFT1/2+1)),ft_p_2(2:end),2*abs(ft_2(2:NFFT2/2+1)),ft_p_3(2:end),2*abs(ft_3(2:NFFT3/2+1)),ft_p_4(2:end),2*abs(ft_4(2:NFFT4/2+1)),ft_p_5(2:end),2*abs(ft_5(2:NFFT5/2+1))) 
    title('Figure 3: Single-Sided Amplitude Spectrum of B(t) - Stationary 1')
    xlabel('Frequency (Hz)')
    ylabel('|B(f)|')
    legend('Stationary 1','Stationary 2','Stationary 3','Stationary 4','Stationary 5')
    
% Figure 4: Spectrogram of stationary sections

    % Display spectrogram for all sections

    % stat 1
    figure(2);
    
    subplot(1,5,1);
    spectrogram(Bi_1-mean(Bi_1),256,250,NFFT1,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 1');
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');

    % stat 2
    subplot(1,5,2);
    spectrogram(Bi_2-mean(Bi_2),256,250,NFFT2,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 2')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');

    % stat 3
    subplot(1,5,3);
    spectrogram(Bi_3-mean(Bi_3),256,250,NFFT3,1/Fs,'yaxis'); % Display the spectrogram
    title(sprintf('Figure 4: Spectrograms\nStationary 3'));
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');

    % stat 4
    subplot(1,5,4);
    spectrogram(Bi_4-mean(Bi_4),256,250,NFFT4,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 4')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');

    % stat 5
    subplot(1,5,5);
    spectrogram(Bi_5-mean(Bi_5),256,250,NFFT5,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 5')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    
    % Set colorbar
    ax(1)=subplot(1,5,1);
    ax(2)=subplot(1,5,2);
    ax(3)=subplot(1,5,3);
    ax(4)=subplot(1,5,4);
    ax(5)=subplot(1,5,5);
    h=colorbar;
    set(h, 'Position', [.9 .11 .0581 .8150])
    for i=1:5
          pos=get(ax(i), 'Position');
          set(ax(i), 'Position', [pos(1) pos(2) 0.85*pos(3) pos(4)]);
    end
    
% Figure B: Partially zeroed B data

    % Zero out 14.35 Hz peak
    
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

    % Create figure
    % Plot results of inverse FFT

    % stat1
    figure(3);
    subplot(5,1,1);
    plot(ti_1/(1000000*3600*24),abs(Bi_1(1:size(ti_1,2))),'b');
    hold on;
    plot(ti_1/(1000000*3600*24),abs(Bi_1_z(1:size(ti_1,2))),'r');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('Figure B: Partially Smoothed B Magnitude - Stationary 1');
    legend('Original','Partially Smoothed');
    hold off;

    % stat2
    subplot(5,1,2);
    plot(ti_2/(1000000*3600*24),abs(Bi_2(1:size(ti_2,2))),'b');
    hold on;
    plot(ti_2/(1000000*3600*24),abs(Bi_2_z(1:size(ti_2,2))),'r');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('Partially Smoothed B Magnitude - Stationary 2');
    hold off;

    % stat3
    subplot(5,1,3);
    plot(ti_3/(1000000*3600*24),abs(Bi_3(1:size(ti_3,2))),'b');
    hold on;
    plot(ti_3/(1000000*3600*24),abs(Bi_3_z(1:size(ti_3,2))),'r');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('Partially Smoothed B Magnitude - Stationary 3');
    hold off;

    % stat4
    subplot(5,1,4);
    plot(ti_4/(1000000*3600*24),abs(Bi_4(1:size(ti_4,2))),'b');
    hold on;
    plot(ti_4/(1000000*3600*24),abs(Bi_4_z(1:size(ti_4,2))),'r');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('Partially Smoothed B Magnitude - Stationary 4');
    hold off;

    % stat5
    subplot(5,1,5);
    plot(ti_5/(1000000*3600*24),abs(Bi_5(1:size(ti_5,2))),'b');
    hold on;
    plot(ti_5/(1000000*3600*24),abs(Bi_5_z(1:size(ti_5,2))),'r');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('Partially Smoothed B Magnitude - Stationary 5');
    hold off;
    
% Figure C: Partially Smoothed Spectrogram
    
    % Create full figure
    figure(4);
    subplot(1,5,1);
    spectrogram(Bi_1_z(1:size(ti_1,2))-mean(Bi_1_z(1:size(ti_1,2))),256,250,NFFT1,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 1')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 35]);

    % stat 2
    subplot(1,5,2);
    spectrogram(Bi_2_z(1:size(ti_2,2))-mean(Bi_2_z(1:size(ti_2,2))),256,250,NFFT2,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 2')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 35]);

    % stat 3
    subplot(1,5,3);
    spectrogram(Bi_3_z(1:size(ti_3,2))-mean(Bi_3_z(1:size(ti_3,2))),256,250,NFFT3,1/Fs,'yaxis'); % Display the spectrogram
    title(sprintf('Figure C: Partially Smoothed Spectrograms\nStationary 3'));
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 35]);

    % stat 4
    subplot(1,5,4);
    spectrogram(Bi_4_z(1:size(ti_4,2))-mean(Bi_4_z(1:size(ti_4,2))),256,250,NFFT4,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 4')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 35]);

    % stat 5
    subplot(1,5,5);
    spectrogram(Bi_5_z(1:size(ti_5,2))-mean(Bi_5_z(1:size(ti_5,2))),256,250,NFFT5,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 5')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 35]);
    
    % Set colorbar
    ax(1)=subplot(1,5,1);
    ax(2)=subplot(1,5,2);
    ax(3)=subplot(1,5,3);
    ax(4)=subplot(1,5,4);
    ax(5)=subplot(1,5,5);
    h=colorbar;
    set(h, 'Position', [.9 .11 .0581 .8150])
    for i=1:5
          pos=get(ax(i), 'Position');
          set(ax(i), 'Position', [pos(1) pos(2) 0.85*pos(3) pos(4)]);
    end
    
    % Create zoomed figure
    figure(5);
    subplot(1,5,1);
    spectrogram(Bi_1_z(1:size(ti_1,2))-mean(Bi_1_z(1:size(ti_1,2))),256,250,NFFT1,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 1')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 5]);

    % stat 2
    subplot(1,5,2);
    spectrogram(Bi_2_z(1:size(ti_2,2))-mean(Bi_2_z(1:size(ti_2,2))),256,250,NFFT2,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 2')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 5]);

    % stat 3
    subplot(1,5,3);
    spectrogram(Bi_3_z(1:size(ti_3,2))-mean(Bi_3_z(1:size(ti_3,2))),256,250,NFFT3,1/Fs,'yaxis'); % Display the spectrogram
    title(sprintf('Figure C: Partially Smoothed Spectrograms (Zoomed)\nStationary 3'));
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 5]);

    % stat 4
    subplot(1,5,4);
    spectrogram(Bi_4_z(1:size(ti_4,2))-mean(Bi_4_z(1:size(ti_4,2))),256,250,NFFT4,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 4')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 5]);

    % stat 5
    subplot(1,5,5);
    spectrogram(Bi_5_z(1:size(ti_5,2))-mean(Bi_5_z(1:size(ti_5,2))),256,250,NFFT5,1/Fs,'yaxis'); % Display the spectrogram
    title('Stationary 5')
    ylabel('Frequency (Hz)');
    xlabel('Time (s)');
    ylim([0 5]);
    
    % Set colorbar
    ax(1)=subplot(1,5,1);
    ax(2)=subplot(1,5,2);
    ax(3)=subplot(1,5,3);
    ax(4)=subplot(1,5,4);
    ax(5)=subplot(1,5,5);
    h=colorbar;
    set(h, 'Position', [.9 .11 .0581 .8150])
    for i=1:5
          pos=get(ax(i), 'Position');
          set(ax(i), 'Position', [pos(1) pos(2) 0.85*pos(3) pos(4)]);
    end
  
% Figure 5: Confidence level of sprectrogram peask below 0.5 Hz
    
    % Calculate spectrograms
    [S1,F1,T1,P1] = spectrogram(Bi_1_z(1:size(ti_1,2))-mean(Bi_1_z(1:size(ti_1,2))),256,250,NFFT1,1/Fs,'yaxis');
    [S2,F2,T2,P2] = spectrogram(Bi_2_z(1:size(ti_2,2))-mean(Bi_2_z(1:size(ti_2,2))),256,250,NFFT2,1/Fs,'yaxis');
    [S3,F3,T3,P3] = spectrogram(Bi_3_z(1:size(ti_3,2))-mean(Bi_3_z(1:size(ti_3,2))),256,250,NFFT3,1/Fs,'yaxis');
    [S4,F4,T4,P4] = spectrogram(Bi_4_z(1:size(ti_4,2))-mean(Bi_4_z(1:size(ti_4,2))),256,250,NFFT4,1/Fs,'yaxis');
    [S5,F5,T5,P5] = spectrogram(Bi_5_z(1:size(ti_5,2))-mean(Bi_5_z(1:size(ti_5,2))),256,250,NFFT5,1/Fs,'yaxis');

    % Truncate results to show magnitude below 0.5 Hz
    loc1 = find(F1==0.5);
    loc2 = find(F2==0.5);
    loc3 = find(F3==0.5);
    loc4 = find(F4==0.5);
    loc5 = find(F5==0.5);

    P1_t = mean(P1(1:loc1,:)); 
    P2_t = mean(P2(1:loc2,:)); 
    P3_t = mean(P3(1:loc3,:)); 
    P4_t = mean(P4(1:loc4,:)); 
    P5_t = mean(P5(1:loc5,:)); 

    % Calcuate error bars
    P1_l = 10*log10(abs(P1_t)/3.69);
    P1_u = 10*log10(abs(P1_t)*39.22);

    P2_l = 10*log10(abs(P2_t)/3.69);
    P2_u = 10*log10(abs(P2_t)*39.22);

    P3_l = 10*log10(abs(P3_t)/3.69);
    P3_u = 10*log10(abs(P3_t)*39.22);

    P4_l = 10*log10(abs(P4_t)/3.69);
    P4_u = 10*log10(abs(P4_t)*39.22);

    P5_l = 10*log10(abs(P5_t)/3.69);
    P5_u = 10*log10(abs(P5_t)*39.22);

    % Plot ampltiude of spectrogram below 0.5 Hz
    figure(6);
    % stat 1
    subplot(5,1,1); hold on;
    P1_X = [T1,fliplr(T1)];
    P1_Y = [P1_l,fliplr(P1_u)];
    fill(P1_X,P1_Y,'c','edgecolor','c');
    plot(T1,10*log10(abs(P1_t)),'b');
    title(sprintf('Figure 5: Magnitude of Averaged Intensity Below 0.5 Hz\n Stationary 1'));
    ylabel('log(I)');
    xlabel('Time (s)');
    ylim([-30 20]);
    hold off;

    % stat 2
    subplot(5,1,2);hold on;
    P2_X = [T2,fliplr(T2)];
    P2_Y = [P2_l,fliplr(P2_u)];
    fill(P2_X,P2_Y,'c','edgecolor','c');
    plot(T2,10*log10(abs(P2_t)));
    title('Stationary 2')
    ylabel('log(I)');
    xlabel('Time (s)');
    ylim([-30 20]);
    hold off;

    % stat 3
    subplot(5,1,3);hold on;
    P3_X = [T3,fliplr(T3)];
    P3_Y = [P3_l,fliplr(P3_u)];
    fill(P3_X,P3_Y,'c','edgecolor','c');
    plot(T3,10*log10(abs(P3_t)));
    title('Stationary 3')
    ylabel('log(I)');
    xlabel('Time (s)');
    ylim([-30 20]);
    hold off;

    % stat 4
    subplot(5,1,4);hold on;
    P4_X = [T4,fliplr(T4)];
    P4_Y = [P4_l,fliplr(P4_u)];
    fill(P4_X,P4_Y,'c','edgecolor','c');
    plot(T4,10*log10(abs(P4_t)));
    title('Stationary 4')
    ylabel('log(I)');
    xlabel('Time (s)');
    ylim([-30 20]);
    xlim([0 45]);
    hold off;

    % stat 5
    subplot(5,1,5);hold on;
    P5_X = [T5,fliplr(T5)];
    P5_Y = [P5_l,fliplr(P5_u)];
    fill(P5_X,P5_Y,'c','edgecolor','c');
    plot(T5,10*log10(abs(P5_t)));
    title('Stationary 5')
    ylabel('log(I)');
    xlabel('Time (s)');
    ylim([-30 20]);
    hold off;
 
% Figure 6: B mag over Confidence level of sprectrogram peaks below 0.5 Hz

    % Create figure
    
    % stat 1
    figure(7);
    [AX1,H1,H2] = plotyy(T1+(ti_1(1)/(1000000*3600*24)),10*log10(abs(P1_t)),(ti_1-ti_1(1))/(1000000*3600*24),abs(Bi_1_z(1:size(ti_1,2))),'plot');
    set(get(AX1(1),'Ylabel'),'String','log(I)');
    set(get(AX1(2),'Ylabel'),'String','Magnetic Field (nT)');
    %datetick(AX1(1),'x','SS');
    datetick(AX1(2),'x','SS');
    hold on;
    line(T1+(ti_1(1)/(1000000*3600*24)),P1_l,'parent',AX1(1),'color','r');
    xlabel('Time (s)');
    title(sprintf('Figure 6: B Magnitude overlaid on Spectrogram Intensity:\n Stationary 1'));
    legend('log(I)','log(I) lower bound','B_{mag}');
    hold off;

    % stat 2
    figure(8);
    [AX2,H2,H2] = plotyy(T2+(ti_2(1)/(1000000*3600*24)),10*log10(abs(P2_t)),(ti_2-ti_2(1))/(1000000*3600*24),abs(Bi_2_z(1:size(ti_2,2))),'plot');
    set(get(AX2(1),'Ylabel'),'String','log(I)');
    set(get(AX2(2),'Ylabel'),'String','Magnetic Field (nT)');
    %datetick(AX2(1),'x','SS');
    datetick(AX2(2),'x','SS');
    hold on;
    line(T2+(ti_2(1)/(1000000*3600*24)),P2_l,'parent',AX2(1),'color','r');
    xlabel('Time (s)');
    title(sprintf('Figure 6: B Magnitude overlaid on Spectrogram Intensity:\n Stationary 2'));
    legend('log(I)','log(I) lower bound','B_{mag}');
    hold off;
    
    % stat 3
    figure(9);
    [AX3,H3,H3] = plotyy(T3+(ti_3(1)/(1000000*3600*24)),10*log10(abs(P3_t)),(ti_3-ti_3(1))/(1000000*3600*24),abs(Bi_3_z(1:size(ti_3,2))),'plot');
    set(get(AX3(1),'Ylabel'),'String','log(I)');
    set(get(AX3(2),'Ylabel'),'String','Magnetic Field (nT)');
    %datetick(AX3(1),'x','SS');
    datetick(AX3(2),'x','SS');
    hold on;
    line(T3+(ti_3(1)/(1000000*3600*24)),P3_l,'parent',AX3(1),'color','r');
    xlabel('Time (s)');
    title(sprintf('Figure 6: B Magnitude overlaid on Spectrogram Intensity:\n Stationary 3'));
    legend('log(I)','log(I) lower bound','B_{mag}');
    hold off;
    
    % stat 4
    figure(10);
    [AX4,H4,H4] = plotyy(T4+(ti_4(1)/(1000000*3600*24)),10*log10(abs(P4_t)),(ti_4-ti_4(1))/(1000000*3600*24),abs(Bi_4_z(1:size(ti_4,2))),'plot');
    set(get(AX4(1),'Ylabel'),'String','log(I)');
    set(get(AX4(2),'Ylabel'),'String','Magnetic Field (nT)');
    %datetick(AX4(1),'x','SS');
    datetick(AX4(2),'x','SS');
    hold on;
    line(T4+(ti_4(1)/(1000000*3600*24)),P4_l,'parent',AX4(1),'color','r');
    xlabel('Time (s)');
    title(sprintf('Figure 6: B Magnitude overlaid on Spectrogram Intensity:\n Stationary 4'));
    legend('log(I)','log(I) lower bound','B_{mag}');
    hold off;
    
    % stat 5
    figure(11);
    [AX5,H5,H5] = plotyy(T5+(ti_5(1)/(1000000*3600*24)),10*log10(abs(P5_t)),(ti_5-ti_5(1))/(1000000*3600*24),abs(Bi_5_z(1:size(ti_5,2))),'plot');
    set(get(AX5(1),'Ylabel'),'String','log(I)');
    set(get(AX5(2),'Ylabel'),'String','Magnetic Field (nT)');
    %datetick(AX5(1),'x','SS');
    datetick(AX5(2),'x','SS');
    hold on;
    line(T5+(ti_5(1)/(1000000*3600*24)),P5_l,'parent',AX5(1),'color','r');
    xlabel('Time (s)');
    title(sprintf('Figure 6: B Magnitude overlaid on Spectrogram Intensity:\n Stationary 5'));
    legend('log(I)','log(I) lower bound','B_{mag}');
    hold off;
    
% Figure D: Spectrogram of entire dataset
    % Calcuate spectrogram of entire data set
    figure(12);
    spectrogram(Bi(1:size(ti,2))-mean(Bi(1:size(ti,2))),100,25,256,1/Fs,'yaxis');
    title('Entire Dataset - 8 Nov 2012 14:00-15:00')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');