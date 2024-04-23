load chirp
y0=y;
Fs = 8192;

% Κανονικός θόρυβος, όχι ομοιόμορφος
noise =0.5*randn(size(y));

% Ομοιόμορφος Θόρυβος
noise_uniform = 0.5*rand(size(y));


yw = y0 + noise_uniform;

% figure
% subplot(131);plot(y0)
% subplot(132);plot(yw)

NumFFT = 4096;
F = linspace(-Fs/2,Fs/2,NumFFT);

%% Δημιουργία Φίλτρων
cw = chebwin(35,30);

b = fir1(35-1,0.48,'high',cw);

c = firls(35-1,[0, 0.48, 0.5, 1], [0 0 1 1]);

d = firpm(35-1,[0, 0.48, 0.5, 1], [0 0 1 1]);

fvtool(b)
fvtool(c)
fvtool(d)

yb = filtfilt(b,1,yw);
yc = filtfilt(c,1,yw);
yd = filtfilt(d,1,yw);


% subplot(133);plot(yf)

% freqz(b,1,512);

%% Γραφικές Παραστάσεις από όλα
figure
subplot(131);plot(F, abs(fftshift(fft(y0,NumFFT))))
subplot(132);plot(F, abs(fftshift(fft(yw,NumFFT))))
subplot(133);plot(F, abs(fftshift(fft(yf,NumFFT))))


figure;
plot(y0(1:100), 'b');title('Original Sound')
figure;
plot(y0(end-100:end), 'b');title('Original Sound')
 

figure;
plot(yb(1:100), 'b');title('Filtered Sound, Fourier')
figure;
plot(yb(end-100:end), 'b');title('Filtered Sound, Fourier')

figure;
plot(yc(1:100), 'b');title('Filtered Sound, Dont Care')
figure; 
plot(yc(end-100:end), 'b');title('Filtered Sound, Dont Care')

figure;
plot(yd(1:100), 'b');title('Filtered Sound, Min-Max')
figure; 
plot(yd(end-100:end), 'b');title('Filtered Sound, Min-Max')


%% Τετραγωνικό Σφάλμα για συγκριση αποθορυβοποίησης
MSE(1) = mean((y0 - yb).^2);
MSE(2) = mean((y0 - yc).^2);
MSE(3) = mean((y0 - yd).^2);


% sound(y0, Fs)
% sound(yb, Fs)
% sound(yc, Fs)
% sound(yd, Fs)
