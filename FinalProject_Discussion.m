clear; clc;

% Figure E: Spectrogram of Day 1
    load RBSP_add.mat
    dd1 = dc{1,1};
    dd2 = dc{1,2};
    dd3 = dc{1,3};
    dd4 = dc{1,4};
    dd5 = dc{1,5};

    % build day 1 array
    dn = datenum(dd1(:,1:3));
    dn = (dn-dn(1))*3600*24; 
    ms = dn + dd1(:,4)*60*60 + dd1(:,5)*60 + dd1(:,6);

    d1 = [ms(:),dd1(:,7)];
    Fs1 = d1(2,1)-d1(1,1);

    % Day 1 - 8 Nov 2012
    figure(1);
    plot((d1(1:12*3600/0.0160,1)-d1(1,1))/(3600*24),d1(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('8 Nov 2012 00:00-12:00');

    figure(2);
    spectrogram(d1(1:12*3600/0.0160,2)-mean(d1(1:12*3600/0.0160,2)),100,25,256,1/Fs1,'yaxis');
    title('8 Nov 2012 00:00-12:00')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;

    figure(3);
    plot((d1(1:12*3600/0.0160,1)-d1(1,1))/(3600*24),d1(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('8 Nov 2012 12:00-23:59');

    figure(4);
    spectrogram(d1(1:12*3600/0.0160,2)-mean(d1(1:12*3600/0.0160,2)),100,25,256,1/Fs1,'yaxis');
    title('8 Nov 2012 12:00-23:59')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;
    
% Figure F: Spectrogram of Day 2
    % build day 2 array
    dn = datenum(dd2(:,1:3));
    dn = (dn-dn(1))*3600*24; 
    ms = dn + dd2(:,4)*60*60 + dd2(:,5)*60 + dd2(:,6);

    d2 = [ms(:),dd2(:,7)];
    Fs2 = d2(2,1)-d2(1,1);

    % Day 2 - 9 Nov 2012
    figure(5);
    plot((d2(1:12*3600/0.0160,1)-d2(1,1))/(3600*24),d2(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('9 Nov 2012 00:00-12:00');

    figure(6);
    spectrogram(d2(1:12*3600/0.0160,2)-mean(d2(1:12*3600/0.0160,2)),100,25,256,1/Fs2,'yaxis');
    title('9 Nov 2012 00:00-12:00')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;

    figure(7);
    plot((d2(1:12*3600/0.0160,1)-d2(1,1))/(3600*24),d2(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('9 Nov 2012 12:00-23:59');

    figure(8);
    spectrogram(d2(1:12*3600/0.0160,2)-mean(d2(1:12*3600/0.0160,2)),100,25,256,1/Fs2,'yaxis');
    title('9 Nov 2012 12:00-23:59')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;
    
% Figure G: Spectrogram of Day 3
    % build day 3 array
    dn = datenum(dd3(:,1:3));
    dn = (dn-dn(1))*3600*24; 
    ms = dn + dd3(:,4)*60*60 + dd3(:,5)*60 + dd3(:,6);

    d3 = [ms(:),dd3(:,7)];
    Fs3 = d3(2,1)-d3(1,1);

    % Day 3 - 10 Nov 2012
    figure(9);
    plot((d3(1:12*3600/0.0160,1)-d3(1,1))/(3600*24),d3(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('10 Nov 2012 00:00-12:00');

    figure(10);
    spectrogram(d3(1:12*3600/0.0160,2)-mean(d3(1:12*3600/0.0160,2)),100,25,256,1/Fs3,'yaxis');
    title('10 Nov 2012 00:00-12:00')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;

    figure(11);
    plot((d3(1:12*3600/0.0160,1)-d3(1,1))/(3600*24),d3(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('10 Nov 2012 12:00-23:59');

    figure(12);
    spectrogram(d3(1:12*3600/0.0160,2)-mean(d3(1:12*3600/0.0160,2)),100,25,256,1/Fs3,'yaxis');
    title('10 Nov 2012 12:00-23:59')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;
    
% Figure H: Spectrogram of Day 4

    % build day 4 array
    dn = datenum(dd4(:,1:3));
    dn = (dn-dn(1))*3600*24; 
    ms = dn + dd4(:,4)*60*60 + dd4(:,5)*60 + dd4(:,6);

    d4 = [ms(:),dd4(:,7)];
    Fs4 = d4(2,1)-d4(1,1);

    % Day 4 - 11 Nov 2012
    figure(13);
    plot((d4(1:12*3600/0.0160,1)-d4(1,1))/(3600*24),d4(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('11 Nov 2012 00:00-12:00');

    figure(14);
    spectrogram(d4(1:12*3600/0.0160,2)-mean(d4(1:12*3600/0.0160,2)),100,25,256,1/Fs4,'yaxis');
    title('11 Nov 2012 00:00-12:00')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;

    figure(15);
    plot((d4(1:12*3600/0.0160,1)-d4(1,1))/(3600*24),d4(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('11 Nov 2012 12:00-23:59');

    figure(16);
    spectrogram(d4(1:12*3600/0.0160,2)-mean(d4(1:12*3600/0.0160,2)),100,25,256,1/Fs4,'yaxis');
    title('11 Nov 2012 12:00-23:59')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;
    
% Figure I: Spectrogram of Day 5

    % build day 5 array
    dn = datenum(dd5(:,1:3));
    dn = (dn-dn(1))*3600*24; 
    ms = dn + dd5(:,4)*60*60 + dd5(:,5)*60 + dd5(:,6);

    d5 = [ms(:),dd5(:,7)];
    Fs5 = d5(2,1)-d5(1,1);

    % Day 5 - 12 Nov 2012
    figure(17);
    plot((d5(1:12*3600/0.0160,1)-d5(1,1))/(3600*24),d5(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('11 Nov 2012 00:00-12:00');

    figure(18);
    spectrogram(d5(1:12*3600/0.0160,2)-mean(d5(1:12*3600/0.0160,2)),100,25,256,1/Fs5,'yaxis');
    title('11 Nov 2012 00:00-12:00')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;

    figure(19);
    plot((d5(1:12*3600/0.0160,1)-d5(1,1))/(3600*24),d5(1:12*3600/0.0160,2));
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('11 Nov 2012 12:00-23:59');

    figure(20);
    spectrogram(d5(1:12*3600/0.0160,2)-mean(d5(1:12*3600/0.0160,2)),100,25,256,1/Fs5,'yaxis');
    title('11 Nov 2012 12:00-23:59')
    ylabel('Frequency [Hz]');
    xlabel('Time [s]');
    colorbar;
