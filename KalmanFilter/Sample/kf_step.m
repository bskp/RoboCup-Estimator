%-----Calculate the rest of the values-----%
for j=2:n
    %Calculate the state and the output
    x(j)=A*x1+w(j);
    z(j)=H*x1+v(j);
    %Predictor equations
    X_apriori(j)=A*X_aposteriori(j-1);
    residual(j)=z(j)-H*X_apriori(j);
    P_apriori(j)=A*P_aposteriori(j-1)*A'+Q;
    %Corrector equations
    K(j)=P_apriori(j)*H'/(H*P_apriori(j)*H'+R);
    P_aposteriori(j)=(1-K(j)*H')*P_apriori(j);
    X_aposteriori(j)=X_apriori(j)+K(j)*residual(j);
end