close all
num=4.2
den=[2.7 3.36 0.53]
G=tf(num,den)
step(G)
figure
grid on

pzmap(G) %Malha aberta
figure
p=roots(den)

%Resposta frequência
bode(G)%Malha aberta

%% Controlador PID - tentativa e erro
Kp(1)=10;
Ki(1)=1;
Kd(1)=5;


numC=[Kd(1) Kp(1) Ki(1)];
denC=[1 0];
C=tf(numC,denC);
T=feedback(C*G,1);
step(T);
legend('Sistema com PID - TE')
grid on
stepinfo(T)

%% Controlador PID - ZN
Kp(2)=2.245;
Ki(2)=2.134;
Kd(2)=0.590;


C=pid(Kp,Ki,Kd,1e6);
numC=[Kd(2) Kp(2) Ki(2)];
denC=[1 0];
C=tf(numC,denC);
T=feedback(C*G,1);
step(T);
legend('Sistema com PID - ZN')
grid on
stepinfo(T)

%% Controlador PID - CC
Kp(3)=2.557;
Ki(3)=2.000;
Kd(3)=0.491;


numC=[Kd(3) Kp(3) Ki(3)];
denC=[1 0];
C=tf(numC,denC);
T=feedback(C*G,1);
step(T);
legend('Sistema com PID - CC')
grid on
stepinfo(T)

%% Controlador PID - GA
Kp(4)=15;
Ki(4)=1.561;
Kd(4)=7.5;


numC=[Kd(4) Kp(4) Ki(4)];
denC=[1 0];
C=tf(numC,denC);
T=feedback(C*G,1);
step(T);
legend('Sistema com PID - GA')
grid on
stepinfo(T)

%% Controlador PID - ACO
Kp(5)=14.8591;
Ki(5)=2.2215;
Kd(5)=7.4709;


numC=[Kd(5) Kp(5) Ki(5)];
denC=[1 0];
C=tf(numC,denC);
T=feedback(C*G,1);
step(T);
legend('Sistema com PID - ACO')
grid on
stepinfo(T)


%%
for i=1:5
numC=[Kd(i) Kp(i) Ki(i)];
denC=[1 0];
C=tf(numC,denC);
T=feedback(C*G,1);
step(T);
hold on
grid on
disp(strcat('Controlador PID - ', num2str(i)))
stepinfo(T)
end
legend('Try and Error (TR)', 'Ziegler-Nichols (ZN)', 'Cohen-Coon (CC)', 'Genetic algorithm (GA)', 'Ant colony algorithm (ACO)')

%bode(C*G) %Malha fechada
%rlocus(C*G) %Malha fechada - Sistema realimentado com PID
%T=feedback(C*G);
%figure
%[y,t]=step(T)
%plot(t,y)
%grid on
%legend('Resposta de malha fechada')