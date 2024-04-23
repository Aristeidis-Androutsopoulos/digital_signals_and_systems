%% Προεπεξεργασία
load Noisy.mat

Fs = 44100;

F = linspace(0, Fs/2, length(yw));

figure;
plot(yw)

%% Σε περίπτωση που δεν ειναι ευκολο να οριστούν ορίσματα για F. 
periodogram(yw,[],[],Fs);


%% Ελεγχος Συχνοτικού περιεχομένου
figure;
plot(F, 20*log10(abs(fft(yw))))

%% Δημιουργία Φίλτρου
good_filter = filter_object();

yf = filtfilt(good_filter.Numerator, 1, yw);

figure;
plot(yf);

fvtool(good_filter, Fs = Fs);
