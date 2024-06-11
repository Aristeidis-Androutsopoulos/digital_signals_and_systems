%% Uniform Distribution
clear;clc;close all
K = 10;
n = [-200:200]';
A = rand(1,K) - 1/2;
x = A .* ((n > 0) - (n - 100 > 0));

% Arithmetic Mean Value
mean_values = mean(x, "all");


Acor = x*x'/K;
Sd = 20*log10(fftshift(abs(fft2(Acor))));

%%
plot(n,x)
figure; imagesc(n,n,Acor)
figure; imagesc(Sd)


%% Normal Distribution
clear;clc;close all
K = 10;
n = [-200:200]';
A = randn(1,K);
x = A .* ((n > 0) - (n - 100 > 0));

% Arithmetic Mean Value
mean_values = mean(x, "all");


Acor = x*x'/K;
Sd = 20*log10(fftshift(abs(fft2(Acor))));

%%
plot(n,x)
figure; imagesc(n,n,Acor)
figure; imagesc(Sd)



