
clear;
close all;
%%
t=csvread("SinWaveVarFreq4.csv");   % sin4 is giving best results
time=t(:,1);
y=t(:,2);

%plot(x(:,1),x(:,2))
SNR=5;   % signal-to-noise ratio
fs=2000;

figure(1)
subplot(5,1,1) % 5 rows , 1 column , first position
plot(y); box on; grid on;
title("pure signal")
xlabel 'time';
ylabel 'amplitude';

%%
Y1 = awgn(y,SNR,'measured','linear');    % adding white gaussian noise
%plot(time, Y1)

subplot(5,1,2) % 5 rows , 1 column , 2nd position
plot(Y1); grid on; box on;
title("signal added with gaussian noise")
xlabel 'time';
ylabel 'amplitude';
title("signal added with noise")
%%
signal    = Y1;
fcutlow=2;   %low cut frequency in Hz
fcuthigh=20;   %high cut frequency in Hz
order=3;
[b,a]=butter(order,[fcutlow,fcuthigh]/(fs/2),'bandpass');
% [b,a] = butter(n,Wn); wn:cut-off frequency
% [b,a]    = butter(3, 0.5);

% To get the phase response
%[phi,w] = phasez(b,a,n);
[phi,w]=phasez(b,a,order);
z         = zeros(1, 6);
filtered1 = filter(b, a, signal, z);  % Same as: filter(b, a, signal) if z is 0
filtered2 = NaN(size(signal));
steps     = 0:1:numel(signal);
for iStep = 1:numel(steps) - 1
  i1 = steps(iStep) + 1;
  i2 = steps(iStep + 1);
  % z is updated in each block:
  [filtered2(i1:i2), z] = filter(b, a, signal(i1:i2), z);
end
subplot(5,1,3)
plot(filtered2,'g'); grid on; box on;
title("Real time band pass filtered signal")
%%
signal = filtered2;
filtered3 = NaN(size(signal));
steps     = 1:1:numel(signal);
for i = 1000:numel(steps)
    ww=NaN(1000,1);
    i1 = steps(i-999);
    i2 = steps(i);
    [ww(1:1000)] = hilbert(signal(i1:i2));
    filtered3(i)=ww(1000);
end
sigphase = atan2(imag(filtered3),real(filtered3));
%sigphase = (unwrap(angle(filtered3)))';
sigphase(1:1000)=zeros(1000,1);
subplot(5,1,4); grid on; box on;
plot(sigphase)
title("Real Time Phase")
%%
squareWave=zeros(length(sigphase),1);
for j=1:length(sigphase)
    if (1<= sigphase(j)) && (sigphase(j)<=1.5)
        squareWave(j,1)=1;
    end
end
subplot(5,1,5)
plot(squareWave); grid on; box on;
title("square wave for triggering")
%%
disp('running completed')