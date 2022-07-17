%% 10 Hz sine wave with sampling frequency of 2000 Hz for 1 seconds long
%%
fs= 2000;
T=1/fs;
D= 1;
t= 0:T: D-T;
f=12;
A= 0.001;
x= A* sin(2*pi*f*t);
figure('Name',' tACS Signal')
plot(t,x)
xlabel('Time (s)');
ylabel('Amplitude of Current (A)');
writematrix([x]','PartSinwave10.csv')