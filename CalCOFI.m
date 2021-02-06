data = dlmread("bottle.csv");

x=data(:,1);
y=data(:,2);
%feature scaling for y
y1 = (y .- mean(y))/(max(y)-min(y));

figure(1);
plot(x,y1,'rx');
xlabel("temperature");ylabel("salinity (mean-normalized)");
title("Effect of temperature on salinity");

fprintf('Plotting data \n');
pause;

m = length(y1);
X = [ones(m,1),x];

%initializing values for gradient descent
alpha = 0.01;
num_iter = 10000;
theta = zeros(2,1);

%Performing gradient Descent
[theta,J_history] = gradDesc(X,y1,alpha,num_iter,theta);
theta %returning optimal theta value

%returning J at optimal theta found through gradient descent
J = computeCost(X,y1,theta)

fprintf('\nOptimized theta & J value based on gradient descent for %i iterations \n',num_iter);
pause;

%Error check to ensure J is decreasing with no. iterations
figure(2);
plot(1:num_iter,J_history);
xlabel("number of iterations");ylabel("Cost");
title("Cost function error check");

fprintf('\nCheck for J convergence\n',num_iter);
pause;


%Plot linear regression line
figure(1);
hold on;
plot(x, X * theta, 'b-');

fprintf('\nPlot linear regression line (gradient descent) \n');
pause;

%Predicting values based on input temperature
temperature = 10;

disp(sprintf("\nPredicted salinity based on %0.2f degrees Celsius\n",temperature));
predict = predictTemp (temperature,theta)

plot(temperature,predict,'gx','MarkerSize',20);
legend('Training Data')
pause;

%Preparing theta1 and theta2 values for array for contour and surface plots
theta1_vals = linspace(-5,5,100);
theta2_vals = linspace(-2,2,100);

J_vals = zeros(length(theta1_vals),length(theta2_vals));

%Filling up the array based on dummy theta1 and theta2 vals
for i = 1:length(theta1_vals)
  for j = 1:length(theta2_vals)
    t = [theta1_vals(i);theta2_vals(j)];
    J_vals(i,j) = computeCost(X,y1,t);
  end;
 end;

%Remember to transpose J_vals due to how meshgrids work in Octave
J_vals = J_vals';

%Plot contour plot
figure(3);
contour(theta1_vals,theta2_vals,J_vals,logspace(-4,2,10));
xlabel('theta1');ylabel('theta2')
hold on
plot(theta(1),theta(2),'rx','MarkerSize',10);

%Plot surface plot 
figure(4);
surf(theta1_vals,theta2_vals,J_vals);
xlabel('theta1');ylabel('theta2');
hold on
plot(theta(1),theta(2),'rx','MarkerSize',10);

rotate3d on
pause;

fprintf('\nfminunc to find optTheta\n');
 
%fminunc
%Initialize options
options = optimset('GradObj','on','MaxIter',1500,'Tolfun',-2);
%Set new initial theta
fmintheta = zeros(2,1);
 
%Run fminunc, find t (i.e optTheta) that minimizes given function (i.e costFunc)
[optTheta,functionVal,exitFlag] = fminunc(@(t)costFunc(X,y1,t),fmintheta,options)

pause;

fprintf('\nPlotting linear regression based on fminunc\n');

figure(1);
hold on;
plot(x, X * optTheta, 'g-');

pause;

fprintf('\nNormal equation to calculate theta\n');

%Normal Eqn
NormTheta = computeNorm(X,y1);

pause;
fprintf('\nPlotting linear regression based on normal equation\n');

figure (1);
hold on;
plot(x,X * NormTheta, 'y-');
%Your normal, fminunc and gradient descent algorithm all gives the same line! Yay!


 
 
