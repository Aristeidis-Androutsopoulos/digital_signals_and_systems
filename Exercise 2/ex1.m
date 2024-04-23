close all;clear;clc;
% N - 1 είναι η τάξη του φίλτρου
N = 29;


fc = 0.4;

% Filter based on Fourier
hc = fir1(N-1,fc,'high');

% Filter Visualizer
fvtool(hc)

stem(hc);

% freqz(hc,1,512);

% Graphing on hand
NumFFT = 4096;
Freqs = linspace(-pi,pi,NumFFT);

figure
plot(Freqs, abs(fftshift(fft(hc,NumFFT))));
title('Filter frequency response')
grid on

figure
plot(Freqs, 20*log10(abs(fftshift(fft(hc,NumFFT)))));
title('Filter frequency response (dB)')
grid on

figure
plot(Freqs, angle(fft(hc,NumFFT)));
title('Filter frequency response (dB)')
grid on

%% Filter "Don't Care"
h_low = firls(N-1,[0,0.1, 0.35, 1] , [1 1 0 0]);
h_high = firls(N-1,[0,0.1, 0.35, 1] , [0 0 1 1]);

fvtool(h_low)
fvtool(h_high)


%% Filter "Min-Max"
h_pm_low = firpm(N-1,[0,0.1, 0.35, 1] , [1 1 0 0]);
h_pm_high = firpm(N-1,[0,0.1, 0.35, 1] , [0 0 1 1]);

fvtool(h_pm_low)
fvtool(h_pm_high)


% Graphing on hand
figure
plot(Freqs, 20*log(abs(fftshift(fft(h_low,NumFFT)))));
title('Filter frequency response (dB)')
grid on

hold on
plot(Freqs, 20*log10(abs(fftshift(fft(h_high,NumFFT)))));
title('Filter frequency response (dB)')
grid on
