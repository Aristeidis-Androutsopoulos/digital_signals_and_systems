clear
close all
clc

n=0:1000;
phi = rand(1)*2*pi;
s = sin(0.25*n+phi);

w = randn(1,length(n));
v = filter(1,[1,-0.6],w); 
x = s + w;

%% PSD of the colored noise
[psd, f] = periodogram(v, [], [], 1);

% Theoretical PSD calculation
f_theo = linspace(0, 0.5, length(f));
psd_theo = 1 ./ (1.36 - 1.2 * cos(2 * pi * f_theo));

% Plot the PSD
figure;
plot(f, 10*log10(psd), 'g'); hold on;
plot(f_theo, 10*log10(psd_theo), 'r');
xlabel('Normalized Frequency (f)')
ylabel('Power/Frequency (dB/Hz)')

%% Optimal Wiener of length 2
%find the autocorrelation
v1 = v(1:end-1);
v2 = v(2:end);

V = [v2;v1];
Rvv = V*V'/length(v1);

%find the crosscorrelation
rwv = zeros(2,1);
rwv(1) = sum(v(2:end) .* w(2:end));
rwv(2) = sum(v(1:end-1) .* w(2:end));

% Normalize crosscorrelation
rwv = rwv / (length(v) - 1);

% Wiener filter coefficients
hW = Rvv\rwv;

% Apply to colored noise to make it white again 
w_hat = filter(hW,1,v);

% Calculate the Norm of the difference. This is what we want to minimize
norm(w-w_hat);

% Now we estimate the original signal
x_hat = x-w_hat;

mse = immse(x, x_hat);

subplot(131);plot(s);title('original');
subplot(132);plot(x);title('Noisy');
subplot(133);plot(x_hat);title('Filtered');


% %% Define the desired filter length
% filter_length = 4;  % Change this value to set the desired filter length
% 
% % Autocorrelation Calculation (Rvv)
% V = zeros(filter_length, length(v) - filter_length + 1);
% for i = 1:filter_length
%     V(i, :) = v(i:end - filter_length + i);
% end
% Rvv = V * V' / size(V, 2);
% 
% V = zeros(filter_length, length(v) - filter_length + 1);
% for i = 1:filter_length
%     V(i, :) = v(i:end - filter_length + i);
% end
% Rvv = V * V.' / size(V, 2);
% 
% % Cross-correlation Calculation (rwv)
% rwv = zeros(filter_length, 1);
% for i = 1:filter_length
%     % Define the sliding window for w
%     w_window = w(i:end - filter_length + i);
%     % Calculate the cross-correlation at position i
%     rwv(i) = sum(v(i:end - filter_length + i) .* w_window);
% end
% 
% % Normalize cross-correlation
% rwv = rwv / (length(v) - filter_length + 1);
% 
% % Wiener filter coefficients
% hW = Rvv \ rwv;
% 
% % Apply to colored noise to make it white again 
% w_hat = filter(hW, 1, v);
% 
% % Calculate the Norm of the difference. This is what we want to minimize
% norm(w - w_hat);
% 
% % Now we estimate the original signal
% x_hat = x - w_hat;
% 
% mse = immse(x, x_hat);
% 
% subplot(131); plot(s); title('original');
% subplot(132); plot(x); title('Noisy');
% subplot(133); plot(x_hat); title('Filtered');

optimal_wiener(s, v, x, w, 2);
optimal_wiener(s, v, x, w, 3);
optimal_wiener(s, v, x, w, 4);
optimal_wiener(s, v, x, w, 5);
optimal_wiener(s, v, x, w, 6);
optimal_wiener(s, v, x, w, 7);
