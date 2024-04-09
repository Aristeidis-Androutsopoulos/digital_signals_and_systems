% Frequency Response Vector
h = [1/2, 1, -1/2];

% Magnitude and Phase
[H,W] = freqz(h,1);
% freqz(h,1);
figure;
plot((W), abs(H))
% figure;
% plot(W, angle(H))

n=1:16000;

% Set up the Signal
x=cos(pi*n/4)- sin(pi*n/2)+(-1/2).^n;

% Filter Function
yf=filter(h,1,x);

% Conv Function
yc=conv(h,x);

% Plot the first 100 for Filter
figure;
plot (x(1:100))
hold on 
plot (yf(1:100))

% Plot the first 100 for Conv
figure;
plot (x(1:100))
hold on 
plot (yc(1:100))


% Compute the FT of the Signal
x1 = abs(fftshift(fft(x)));
y1f = abs(fftshift(fft(yf)));
y1c = abs(fftshift(fft(yc)));

% Plot abs(fftshift(fft(x)))
figure(1)
plot(x1)
figure(2)
plot(y1f, 'r')
figure(3)
plot(y1c, 'g')



%% Time Test for DFT and FFT
% a = 9;
% n=(1:2^a);
% n1=(1:2^a)-1;
% 
% x=cos(pi/4*n)- sin(pi/2*n)+(-1/2).^n;
% x1=cos(pi/4*n1)- sin(pi/2*n1)+(-1/2).^n1;

a = 15;
N = 2^a;
x=rand(N,1);
x1=rand(N-1,1);

tic
for i = 1:10000
    fft(x);
end
foo = toc;
foo / 10000
tic
for i = 1:10000
    fft(x1);
end
bar = toc;
bar / 10000



% plot(W/pi,20*log10(abs(H)))
% ax = gca;
% ax.YLim = [-100 20];
% ax.XTick = 0:.5:2;
% xlabel('Normalized Frequency (\times\pi rad/sample)')
% ylabel('Magnitude (dB)')