clear; clc;

% Figure A: Entire interpolated data set

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
    
    % Create figure
    figure(1);
    plot((ti-ti(1))/(1000000*3600*24),Bi);
    datetick('x','HH:MM:SS');
    xlabel('Time [s]');
    ylabel('B Magnitude [nT]');
    title('Figure A: Interpolated Entire Dataset - 8 Nov 2012 14:00-15:00');
    
% Figure 1: Stationary Sections

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
    
    % Create figure

    % stat1
    figure(2);
    subplot(5,1,1);
    plot(ti_1/(1000000*3600*24),abs(Bi_1(1:size(ti_1,2))),'b');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('Figure 1: B Magnitude - Stationary 1');

    % stat2
    subplot(5,1,2);
    plot(ti_2/(1000000*3600*24),abs(Bi_2(1:size(ti_2,2))),'b');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('B Magnitude - Stationary 2');

    % stat3
    subplot(5,1,3);
    plot(ti_3/(1000000*3600*24),abs(Bi_3(1:size(ti_3,2))),'b');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('B Magnitude - Stationary 3');

    % stat4
    subplot(5,1,4);
    plot(ti_4/(1000000*3600*24),abs(Bi_4(1:size(ti_4,2))),'b');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('B Magnitude - Stationary 4');

    % stat5
    subplot(5,1,5);
    plot(ti_5/(1000000*3600*24),abs(Bi_5(1:size(ti_5,2))),'b');
    datetick('x','HH:MM:SS');
    xlabel('Time');
    ylabel('B Magnitude (nT)');
    title('B Magnitude - Stationary 5');
    
% Figure 2: Autocorrelation

    % COMPUTE AUTOCORRELATION FOR STATIONARY SECTIONS

    %  stat1
    % Compute full manual autocorrelation
    x = Bi_1;
    for k=0:size(Bi_1,2)-2
         x_m = x(k+1:size(x,2));
         x_p = x(1:size(x,2)-k);
         x_m = x_m-mean(x_m);
         x_p = x_p-mean(x_p);
         ttop = sum(x_m.*x_p);
         x_mm = mean(x_m);
         x_pm = mean(x_p);
         bottom1 = sum((x_m-x_mm).^2);
         bottom2 = sum((x_p-x_pm).^2);
        tbottom = sqrt(bottom1*bottom2);
         cc_1(k+1) = ttop/tbottom;
    end

    c_lag_1=(0:size(Bi_1,2)-2);

    %  stat2
    % Compute full manual autocorrelation
    x = Bi_2;
    for k=0:size(Bi_2,2)-2
         x_m = x(k+1:size(x,2));
         x_p = x(1:size(x,2)-k);
         x_m = x_m-mean(x_m);
         x_p = x_p-mean(x_p);
         ttop = sum(x_m.*x_p);
         x_mm = mean(x_m);
         x_pm = mean(x_p);
         bottom1 = sum((x_m-x_mm).^2);
         bottom2 = sum((x_p-x_pm).^2);
        tbottom = sqrt(bottom1*bottom2);
         cc_2(k+1) = ttop/tbottom;
    end

    c_lag_2=(0:size(Bi_2,2)-2);

    %  stat3
    % Compute full manual autocorrelation
    x = Bi_3;
    for k=0:size(Bi_3,2)-2
         x_m = x(k+1:size(x,2));
         x_p = x(1:size(x,2)-k);
         x_m = x_m-mean(x_m);
         x_p = x_p-mean(x_p);
         ttop = sum(x_m.*x_p);
         x_mm = mean(x_m);
         x_pm = mean(x_p);
         bottom1 = sum((x_m-x_mm).^2);
         bottom2 = sum((x_p-x_pm).^2);
        tbottom = sqrt(bottom1*bottom2);
         cc_3(k+1) = ttop/tbottom;
    end

    c_lag_3=(0:size(Bi_3,2)-2);

    %  stat4
    % Compute full manual autocorrelation
    x = Bi_4;
    for k=0:size(Bi_4,2)-2
         x_m = x(k+1:size(x,2));
         x_p = x(1:size(x,2)-k);
         x_m = x_m-mean(x_m);
         x_p = x_p-mean(x_p);
         ttop = sum(x_m.*x_p);
         x_mm = mean(x_m);
         x_pm = mean(x_p);
         bottom1 = sum((x_m-x_mm).^2);
         bottom2 = sum((x_p-x_pm).^2);
        tbottom = sqrt(bottom1*bottom2);
         cc_4(k+1) = ttop/tbottom;
    end

    c_lag_4=(0:size(Bi_4,2)-2);

    %  stat5
    % Compute full manual autocorrelation
    x = Bi_5;
    for k=0:size(Bi_5,2)-2
         x_m = x(k+1:size(x,2));
         x_p = x(1:size(x,2)-k);
         x_m = x_m-mean(x_m);
         x_p = x_p-mean(x_p);
         ttop = sum(x_m.*x_p);
         x_mm = mean(x_m);
         x_pm = mean(x_p);
         bottom1 = sum((x_m-x_mm).^2);
         bottom2 = sum((x_p-x_pm).^2);
        tbottom = sqrt(bottom1*bottom2);
         cc_5(k+1) = ttop/tbottom;
    end

    c_lag_5=(0:size(Bi_5,2)-2);

    % Create figure
    figure(3);
    subplot(5,1,1);
    plot(c_lag_1,cc_1);
    axis([0 max(c_lag_1) -1 1])
    xlabel('Lags');
    ylabel('Autocorrelation');
    title('Figure 2: Autocorrelation Function - Stationary 1');

    subplot(5,1,2);
    plot(c_lag_2,cc_2);
    axis([0 max(c_lag_2) -1 1])
    xlabel('Lags');
    ylabel('Autocorrelation');
    title('Autocorrelation Function - Stationary 2');

    subplot(5,1,3);
    plot(c_lag_3,cc_3);
    axis([0 max(c_lag_3) -1 1])
    xlabel('Lags');
    ylabel('Autocorrelation');
    title('Autocorrelation Function - Stationary 3');

    subplot(5,1,4);
    plot(c_lag_4,cc_4);
    axis([0 max(c_lag_4) -1 1])
    xlabel('Lags');
    ylabel('Autocorrelation');
    title('Autocorrelation Function - Stationary 4');

    subplot(5,1,5);
    plot(c_lag_5,cc_5);
    axis([0 max(c_lag_5) -1 1])
    xlabel('Lags');
    ylabel('Autocorrelation');
    title('Autocorrelation Function - Stationary 5');
