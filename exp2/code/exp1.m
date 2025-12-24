[y, fs] = audioread('test_16k.wav');
window_length = 512;
hop_size = 256;
nfft = 512;
[S, f, t] = stft(y, fs, 'Window', rectwin(window_length), 'OverlapLength', hop_size, 'FFTLength', nfft);
S_accelerated = S(:, 1:2:end);
t_accelerated = t(1:2:end); 

y_accelerated = istft(S_accelerated, fs, 'Window', rectwin(window_length), 'OverlapLength', hop_size, 'FFTLength', nfft);

figure;
subplot(2, 1, 1);
plot((1:length(y))/fs, y);
title('Original Speech');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot((1:length(y_accelerated))/fs, y_accelerated);
title('Accelerated Speech');
xlabel('Time (s)');
ylabel('Amplitude');

figure;
subplot(2, 1, 1);
spectrogram(y, rectwin(window_length), hop_size, nfft, fs, 'yaxis');
title('Spectrogram of Original Speech');

subplot(2, 1, 2);
spectrogram(y_accelerated, rectwin(window_length), hop_size, nfft, fs, 'yaxis');
title('Spectrogram of Accelerated Speech');
