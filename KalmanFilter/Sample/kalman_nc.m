clear;

%-----Values for simulation-----%
n=30;               %length of the simulation
x1=1;               %Constant measure value

%-----System values-----%
A=1;                %System matrix
H=1;                %Measuring matrix

%Define of noise variances
Q=0.1;             %process error variance
R=0.1;             %Measuring error variance

%Calculate normally distributed pseudorandom numbers for noise
%with expected value 0 and variance R/Q
w1=randn(1,n);   %Process noise
v1=randn(1,n);   %Measurement 

w=w1*Q;
v=v1*R;

%-----Kalman filtering-----%
kf_init;           %Initializaition for Kalman filtering
kf_step;           %Step for Kalman filtering
kf_plot;           %Plot the results


