j=1:n;

%-----Plot states and state estimates-----%
c=linspace(0,n);
subplot(221);
%h1=plot(j+0.25,X_apriori,'b.','Marker','square');
h1=plot(j,X_apriori,'b');
hold on
%h2=plot(j+0.5,X_aposteriori,'g.','Marker','square');
h2=plot(j,X_aposteriori,'g');
h3=plot(c,x1,'k');
h4=plot(j,x,'r.','Marker','*');
hold off
%Formatting of the plot
legend([h1(1) h2(1) h3(1) h4(1)],'a priori','a posteriori','truth value','noisy measurements');
title('State with a priori and a posteriori elements');
ylabel('State, x');
xlim=[0 length(j)+1];
set(gca,'XLim',xlim);

%-----Plot covariance-----%
subplot(222);
h1=stem(j,P_apriori,'b');
hold on;
h2=stem(j,P_aposteriori,'g');
hold off
legend([h1(1) h2(1)],'a priori','a posteriori');
title('Calculated a priori and a posteriori covariance');
ylabel('Covariance');
set(gca,'XLim',xlim); %Set limits the same as first graph

%-----Plot errors-----%
subplot(223);
plot(c,0,'k');
hold on
h1=plot(j,x1-X_apriori,'b.');
h2=plot(j,x1-X_aposteriori,'g.');
hold off
legend([h1(1) h2(1)],'a priori','a posteriori');
title('Actual a priori and a posteriori error');
ylabel('Errors');
set(gca,'XLim',xlim); %Set limits the same as first graph

%-----Plot kalman gain,k-----%
%With a high gain, the filter places more weight on the measurements,
%and thus follows them more closely. With a low gain, the filter
%follows the model predictions more closely, smoothing out noise
%but decreasing the responsiveness. (Wikipedia)
subplot(224);
h1=stem(j,K,'b');
legend([h1(1)],'kalman gain');
title('Kalman gain');
ylabel('Kalman gain, k');
set(gca,'XLim',xlim); %Set limits the same as first graph


figure(2);
c=linspace(0,n);
%h1=plot(j+0.25,X_apriori,'b.','Marker','square');
h1=plot(j,X_apriori,'b');
hold on
%h2=plot(j+0.5,X_aposteriori,'g.','Marker','square');
h2=plot(j,X_aposteriori,'g');
h3=plot(c,x1,'k');
h4=plot(j,x,'r.','Marker','*');
hold off
%Formatting of the plot
legend([h1(1) h2(1) h3(1) h4(1)],'a priori','a posteriori','truth value','noisy measurements');
title('State with a priori and a posteriori elements');
ylabel('State, x');
xlim=[0 length(j)+1];
set(gca,'XLim',xlim);
