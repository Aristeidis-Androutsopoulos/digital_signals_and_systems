%% Original Image
clear; clc; close all
v = VideoReader('500fps.avi');
i=0;
while hasFrame(v)
    i=i+1;
    I = rgb2gray(im2double(readFrame(v)));
    x(i)=I(293,323);
end
figure;
imshow(I)
y = x - mean(x);
Y = abs(fftshift(fft(y,512)));
F = linspace(-250,250,512);
figure;
plot(F,Y);

% sound(y, 2*500)

%% Image with Salt and Pepper Noise
N = 5;
v = VideoReader('500fps_noisy.avi');
i=0;
while hasFrame(v)
    i=i+1;
    I = rgb2gray(im2double(readFrame(v)));
    I2 = medfilt2(I, [2*N+1, 2*N+1]);
    x(i)=I2(293,323);
end
figure;
imshow(I)
N = 1;
%% Easy way to check filter effectiveness
% figure;
% N = 3;
% I2 = medfilt2(I, [2*N+1, 2*N+1]);
% imshow(I2)
y = x - mean(x);
Y = abs(fftshift(fft(y,512)));
F = linspace(-250,250,512);
figure;
plot(F,Y);



