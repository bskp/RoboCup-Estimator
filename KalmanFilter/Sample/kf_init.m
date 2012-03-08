%-----Kalman initialization-----%
x_0=1.0;   %Initial condition on the state x

%Initial guesses for state and a posteriori covariance
X_aposteriori_0=1.5;
P_aposteriori_0=1;

%Calculate the first estimates for all values based upon the initial guess
%of the state and the a posteriori covariance.

%Calculate the state and the output
x(1)=A*x1+w(1);
z(1)=H*x1+v(1);
%Predictor equations
X_apriori(1)=A*X_aposteriori_0;
residual(1)=z(1)-H*X_apriori(1);
P_apriori(1)=A*P_aposteriori_0*A'+Q;
%Corrector equations
K(1)=P_apriori(1)*H'/(H*P_apriori(1)*H'+R);
P_aposteriori(1)=(1-K(1)*H)*P_apriori(1);
X_aposteriori(1)=X_apriori(1)+K(1)*residual(1);