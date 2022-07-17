clear;
clc;
close all;
fs = 2000; %sampling frequency
dt = 1/fs; %seconds per sample
StopTime = 2; %seconds
t = (0:dt:StopTime);
F = 1.1.*t; %Sinewave frequency {Hertz)
amp = 100; 
data = NaN(size(t));
for i= 1:length(t) 
    data(i) = amp*sin(2*pi*F(i)*t(i));
end
plot(t, data)
title('Sine Wave');
writematrix([t;data]','SinWaveVarFreq4.csv')

%sin1: 2000 sampling rate,3 sec
%sin2: 2000 , 4
%sin3: 2000,4 secs (F = 1.01.*t;)
%sin4: 2000,2, (F = 1.1.*t;)



%%

% t = 0:1/1000:10;
%  f = 2+sin(t);
%  y_wrong  = sin(2*pi*f.*t);
%  y_approx = sin(2*pi*cumsum(f)/1000);
%  y_exact  = sin(2*pi*(2*t-cos(t)));
%  subplot(311); plot(t,y_wrong,'.-')
%  subplot(312); plot(t,y_approx,'.-');
%  subplot(313); plot(t,y_exact,'.-');