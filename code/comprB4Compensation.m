clear all;
close all;
%%
t=csvread("VaryingFreqSinWave10_8_12.csv");   % sin4 is giving best results
% time=t(:,1);
% y=t(:,2);
y=t;
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
signal = y;
filtered7 = NaN(size(signal));
steps     = 1:1:numel(signal);
for i = 1000:numel(steps)
    ww=NaN(1000,1);
    i1 = steps(i-999);
    i2 = steps(i);
    [ww(1:1000)] = hilbert(signal(i1:i2));
    filtered7(i)=ww(1000);
end
sigphase2 = atan2(imag(filtered7),real(filtered7));
%sigphase = (unwrap(angle(filtered3)))';
sigphase2(1:1000)=zeros(1000,1);
subplot(5,1,2); grid on; box on;
plot(sigphase2)
title("Real Time Phase")
%%
squareWave1=zeros(length(sigphase2),1);
for j=1:length(sigphase2)
    if (1<= sigphase2(j)) && (sigphase2(j)<=1.5)
        squareWave1(j,1)=1;
    end
end
subplot(5,1,3)
plot(squareWave1); grid on; box on;
title("square wave for triggering")
%%
Y1 = awgn(y,SNR,'measured','linear');    % adding white gaussian noise
%plot(time, Y1)

% subplot(5,1,2) % 5 rows , 1 column , 2nd position
% plot(Y1); grid on; box on;
% title("signal added with gaussian noise")
% xlabel 'time';
% ylabel 'amplitude';
% title("signal added with noise")
%%
signal    = Y1;
fcutlow=8;   %low cut frequency in Hz
fcuthigh=13;   %high cut frequency in Hz
order=3;
[b,a]=butter(order,[fcutlow,fcuthigh]/(fs/2),'bandpass');
%[b, a]    = butter(3, 0.5);
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
% subplot(5,1,3)
% plot(filtered2,'g'); grid on; box on;
% title("Real time band pass filtered signal")
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
% plot(squareWave)
% hold on
% plot(squareWave1)
% hold off
%%


%writematrix([time squareWave squareWave1],'squareWaves_B4_phaseCompensation.csv')
%%
%%
disp('running completed')