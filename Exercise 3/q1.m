close all
clear
freqz([1 -1],1);
n = 0:1000;
x = cos(pi/32*n);

y = filter([1 -1],1,x);
figure;
plot(n(1:100), x(1:100), '-x')
figure;
plot(n(1:100), y(1:100), '-x')

img = im2double(imread('photo.jpg'));
figure
imagesc(img);colormap gray

h = [1,-1];

dy = filter(h, 1, img);
dy_dx = filter(h, 1, dy')';

%% paragogos 1
img_filter_dy = filter(h, 1, img, [], 1);

img_filter_dx = filter(h, 1, img, [], 2);

figure
imagesc(abs(img_filter_dy));colormap gray


%% paragogos 2
img_filter_dy_2 = filter(h, 1, img_filter_dy, [], 1);

img_filter_dx_2 = filter(h, 1, img_filter_dx, [], 2);

figure
imagesc(abs(img_filter_dx_2));colormap gray

%% paragogos 3
%dxdy
img_filter_dy_dx = filter(h, 1, img_filter_dy, [], 2);

img_filter_dx_dy = filter(h, 1, img_filter_dx, [], 1);

figure
imagesc(abs(img_filter_dx_dy));colormap gray


%% Degraded Photo
img2 = imread('photo-deg.jpg');

N = 20;
h = ones(2*N+1,2*N+1) / (2*N+1)^2;
plot(h);
y = filter2(h,img2);
figure;
imshow(y/max(y(:)));

%% MedFilt
N = 3;
I = medfilt2(img2, [2*N+1, 2*N+1]);

figure;
imagesc(abs(I)), colormap gray;



