clear; clc;
%addpath('../m');

% The following script must be in your path:
% http://bobweigel.net/svn/csi763/weigel/m/plotcmds.m

T     = 16;
theta = pi/3;

t  = [0:1:3*T-1]';

% ZERO-MEAN GAUSSIAN

for z = 1:1000
% Run 0
    N1 = 0.0;
    N2 = 0.0;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*randn(length(t),1);
  x2 = y1*sin(theta) + N2*randn(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
end

ang_a(1) = mean(ang);

figure(1);clf;hold on;grid on;
  plot(t,y1,'b-');
  plot(t,x1,'r-','LineWidth',2);
  plot(t,x2,'g-','LineWidth',2);
  plot(t(S),X(1,:),'r.','MarkerSize',27);
  plot(t(S),X(2,:),'g.','MarkerSize',27);
  legend('y_1','x_1','x_2','Samples of x_1','Samples of x_2')
  xlabel('time step');
  axis([0 t(end) -3 6]);
  plot([0 t(end)],[0 0],'k');
  title('Run 0');

  
  figure(2);clf;hold on;grid on;
  plot(4*[-1*cos(theta) cos(theta)],4*[-1*sin(theta) sin(theta)],'b');
  text(4.5*cos(theta),4.5*sin(theta),'y_1');
  plot([0 3*P(1,1)],[0 3*P(1,2)],'k','LineWidth',2);
  text(3.5*P(1,1),3.5*P(1,2),'p_1');
  plot([0 3*P(2,1)],[0 3*P(2,2)],'k','LineWidth',2);
  text(3.5*P(2,1),3.5*P(2,2),'p_2');
  plot([-4 4],[0 0],'k');

  plot([0 0],[-4 4],'k');
  plot(X(1,:),X(2,:),'k.','MarkerSize',27);
  xlabel('x_1');
  ylabel('x_2');
  axis square
  title('Run 0');
  

for z = 1:1000
% Run 1
    N1 = 0.1;
    N2 = 0.1;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*randn(length(t),1);
  x2 = y1*sin(theta) + N2*randn(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
end

ang_a(2) = mean(ang);

figure(3);clf;hold on;grid on;
  plot(t,y1,'b-');
  plot(t,x1,'r-','LineWidth',2);
  plot(t,x2,'g-','LineWidth',2);
  plot(t(S),X(1,:),'r.','MarkerSize',27);
  plot(t(S),X(2,:),'g.','MarkerSize',27);
  legend('y_1','x_1','x_2','Samples of x_1','Samples of x_2')
  xlabel('time step');
  axis([0 t(end) -3 6]);
  plot([0 t(end)],[0 0],'k');
  title('Run 1');

  
  figure(4);clf;hold on;grid on;
  plot(4*[-1*cos(theta) cos(theta)],4*[-1*sin(theta) sin(theta)],'b');
  text(4.5*cos(theta),4.5*sin(theta),'y_1');
  plot([0 3*P(1,1)],[0 3*P(1,2)],'k','LineWidth',2);
  text(3.5*P(1,1),3.5*P(1,2),'p_1');
  plot([0 3*P(2,1)],[0 3*P(2,2)],'k','LineWidth',2);
  text(3.5*P(2,1),3.5*P(2,2),'p_2');
  plot([-4 4],[0 0],'k');

  plot([0 0],[-4 4],'k');
  plot(X(1,:),X(2,:),'k.','MarkerSize',27);
  xlabel('x_1');
  ylabel('x_2');
  axis square
  title('Run 1');
  
  for z = 1:1000
% Run 2
    N1 = 0.5;
    N2 = 0.5;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*randn(length(t),1);
  x2 = y1*sin(theta) + N2*randn(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
  end

ang_a(3) = mean(ang);

figure(5);clf;hold on;grid on;
  plot(t,y1,'b-');
  plot(t,x1,'r-','LineWidth',2);
  plot(t,x2,'g-','LineWidth',2);
  plot(t(S),X(1,:),'r.','MarkerSize',27);
  plot(t(S),X(2,:),'g.','MarkerSize',27);
  legend('y_1','x_1','x_2','Samples of x_1','Samples of x_2')
  xlabel('time step');
  axis([0 t(end) -3 6]);
  plot([0 t(end)],[0 0],'k');
  title('Run 2');

  
  figure(6);clf;hold on;grid on;
  plot(4*[-1*cos(theta) cos(theta)],4*[-1*sin(theta) sin(theta)],'b');
  text(4.5*cos(theta),4.5*sin(theta),'y_1');
  plot([0 3*P(1,1)],[0 3*P(1,2)],'k','LineWidth',2);
  text(3.5*P(1,1),3.5*P(1,2),'p_1');
  plot([0 3*P(2,1)],[0 3*P(2,2)],'k','LineWidth',2);
  text(3.5*P(2,1),3.5*P(2,2),'p_2');
  plot([-4 4],[0 0],'k');

  plot([0 0],[-4 4],'k');
  plot(X(1,:),X(2,:),'k.','MarkerSize',27);
  xlabel('x_1');
  ylabel('x_2');
  axis square
  title('Run 2');
  
  
  for z = 1:1000
% Run 3
    N1 = 1.0;
    N2 = 1.0;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*randn(length(t),1);
  x2 = y1*sin(theta) + N2*randn(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
  end

ang_a(4) = mean(ang);

figure(7);clf;hold on;grid on;
  plot(t,y1,'b-');
  plot(t,x1,'r-','LineWidth',2);
  plot(t,x2,'g-','LineWidth',2);
  plot(t(S),X(1,:),'r.','MarkerSize',27);
  plot(t(S),X(2,:),'g.','MarkerSize',27);
  legend('y_1','x_1','x_2','Samples of x_1','Samples of x_2')
  xlabel('time step');
  axis([0 t(end) -3 6]);
  plot([0 t(end)],[0 0],'k');
  title('Run 3');

  
  figure(8);clf;hold on;grid on;
  plot(4*[-1*cos(theta) cos(theta)],4*[-1*sin(theta) sin(theta)],'b');
  text(4.5*cos(theta),4.5*sin(theta),'y_1');
  plot([0 3*P(1,1)],[0 3*P(1,2)],'k','LineWidth',2);
  text(3.5*P(1,1),3.5*P(1,2),'p_1');
  plot([0 3*P(2,1)],[0 3*P(2,2)],'k','LineWidth',2);
  text(3.5*P(2,1),3.5*P(2,2),'p_2');
  plot([-4 4],[0 0],'k');

  plot([0 0],[-4 4],'k');
  plot(X(1,:),X(2,:),'k.','MarkerSize',27);
  xlabel('x_1');
  ylabel('x_2');
  axis square
  title('Run 3');

  for z = 1:1000
% Run 4
    N1 = 2.0;
    N2 = 2.0;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*randn(length(t),1);
  x2 = y1*sin(theta) + N2*randn(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
  end

ang_a(5) = mean(ang);

figure(9);clf;hold on;grid on;
  plot(t,y1,'b-');
  plot(t,x1,'r-','LineWidth',2);
  plot(t,x2,'g-','LineWidth',2);
  plot(t(S),X(1,:),'r.','MarkerSize',27);
  plot(t(S),X(2,:),'g.','MarkerSize',27);
  legend('y_1','x_1','x_2','Samples of x_1','Samples of x_2')
  xlabel('time step');
  axis([0 t(end) -3 6]);
  plot([0 t(end)],[0 0],'k');
  title('Run 4');

  
  figure(10);clf;hold on;grid on;
  plot(4*[-1*cos(theta) cos(theta)],4*[-1*sin(theta) sin(theta)],'b');
  text(4.5*cos(theta),4.5*sin(theta),'y_1');
  plot([0 3*P(1,1)],[0 3*P(1,2)],'k','LineWidth',2);
  text(3.5*P(1,1),3.5*P(1,2),'p_1');
  plot([0 3*P(2,1)],[0 3*P(2,2)],'k','LineWidth',2);
  text(3.5*P(2,1),3.5*P(2,2),'p_2');
  plot([-4 4],[0 0],'k');

  plot([0 0],[-4 4],'k');
  plot(X(1,:),X(2,:),'k.','MarkerSize',27);
  xlabel('x_1');
  ylabel('x_2');
  axis square
  title('Run 4');
  
  zz=[0,0.1,0.5,1,2];
  figure(11);clf;hold off;
  plot(zz,ang_a,'-o');
  xlabel('Noise Level');
  ylabel('Angle Error (degrees)');
  title('Average Error Angle');
  
  
  
  % ZERO-MEAN Uniform

for z = 1:1000
% Run 0
    N1 = 0.0;
    N2 = 0.0;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*rand(length(t),1);
  x2 = y1*sin(theta) + N2*rand(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
end

ang_a2(1) = mean(ang);
  

for z = 1:1000
% Run 1
    N1 = 0.1;
    N2 = 0.1;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*rand(length(t),1);
  x2 = y1*sin(theta) + N2*rand(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
end

ang_a2(2) = mean(ang);

  
  for z = 1:1000
% Run 2
    N1 = 0.5;
    N2 = 0.5;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*rand(length(t),1);
  x2 = y1*sin(theta) + N2*rand(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
  end

ang_a2(3) = mean(ang);

  
  for z = 1:1000
% Run 3
    N1 = 1.0;
    N2 = 1.0;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*rand(length(t),1);
  x2 = y1*sin(theta) + N2*rand(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
  end

ang_a2(4) = mean(ang);


  for z = 1:1000
% Run 4
    N1 = 2.0;
    N2 = 2.0;
    Ns = length(t);
  
  y1 = sin(2*pi*t/T);
  x1 = y1*cos(theta) + N1*rand(length(t),1);
  x2 = y1*sin(theta) + N2*rand(length(t),1);
  x1 = x1-mean(x1);
  x2 = x2-mean(x2);
  S  = sort(randsample(length(t),Ns));
  X = [x1' ; x2'];
  X = X(:,S);
  A = X*X';
  [E,D,P] = svd(A);
  v1 = [P(1,1),P(1,2)];
  v2 = [cos(theta),sin(theta)];
  ang(z) = acosd(dot(v1,v2)/(norm(v1)*norm(v2)));
  if abs(ang(z))>90
      ang(z) = 180-abs(ang(z));
  end
  end

ang_a2(5) = mean(ang);

  zz=[0,0.1,0.5,1,2];
  figure(12);clf;hold on;
  plot(zz,ang_a,'-bo');
  plot(zz,ang_a2,'-ro');
  xlabel('Noise Level');
  ylabel('Angle Error (degrees)');
  title('Average Error Angle');
  legend('Zero-Mean Gaussian','Zero-Mean Uniform');
