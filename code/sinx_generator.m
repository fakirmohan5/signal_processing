%% 'f' Hz sine wave with sampling frequency of 'fs' Hz for 'D' seconds long
%%
fs= 2000;
T=1/fs;
D= 2;
t= 0:T: D-T;
f=8;
A= 0.001;
x= A* sin(2*pi*f*t);
figure('Name',' tACS Signal')
plot(t(1:1000),x(1:1000))   % plot first 1000 points
%plot(t,x)
xlabel('Time (s)');
ylabel('Amplitude of Current (A)');
writematrix([t;x]','sinwave20.csv')

%sin4 : 10,2000,2
%sin18 : 12,2000,2
%sin19 : 15,2000,2
%sin20 : 8,2000,2
%sin9 : 10,2000,4
%sin10 : 10,2000,10
%sin11 : 10,2500,2
%sin12 : 10,3000,2
%sin13 : 10,4000,2
%sin14 : 10,2800,2
%sin15 : 10,2600,2
%sin16 : 10,2510,2
%sin17 : 10,2400,2
%sin5 : 10,1000,5
%sin6 : 10,5000,2
%sin7 : 10,500,2
%sin8 : 10,1500,2