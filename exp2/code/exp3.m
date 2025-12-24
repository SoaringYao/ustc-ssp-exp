voiced_filename = 'ah.wav'; 
unvoiced_filename = 'test_16k.wav';
start_sample = 3000; 
lpc_order = 12;  
frame_length_voiced = 300; 
frame_length_unvoiced = 480; 

window_type = 'hamming';

[speech_voiced, fs_voiced] = audioread(voiced_filename);
[speech_unvoiced, fs_unvoiced] = audioread(unvoiced_filename);

frame_voiced = speech_voiced(start_sample:start_sample+frame_length_voiced-1);
frame_unvoiced = speech_unvoiced(start_sample:start_sample+frame_length_unvoiced-1);

w_voiced = hamming(frame_length_voiced);
w_unvoiced = hamming(frame_length_unvoiced);
windowed_voiced = frame_voiced .* w_voiced;
windowed_unvoiced = frame_unvoiced .* w_unvoiced;

[a_voiced, g_voiced] = lpc(windowed_voiced, lpc_order); 
[a_unvoiced, g_unvoiced] = lpc(windowed_unvoiced, lpc_order); 

f_voiced = linspace(0, fs_voiced/2, 512);  
f_unvoiced = linspace(0, fs_unvoiced/2, 512);  
H_voiced = freqz(1, a_voiced, 512, fs_voiced);  
H_unvoiced = freqz(1, a_unvoiced, 512, fs_unvoiced);  % 无声帧的LPC频谱

nfft = 1024;
[~, F_voiced, T_voiced, Sxx_voiced] = spectrogram(windowed_voiced, hamming(frame_length_voiced), 0, nfft, fs_voiced);
log_mag_voiced = 20*log10(abs(Sxx_voiced));  % 对数幅度谱
[~, F_unvoiced, T_unvoiced, Sxx_unvoiced] = spectrogram(windowed_unvoiced, hamming(frame_length_unvoiced), 0, nfft, fs_unvoiced);
log_mag_unvoiced = 20*log10(abs(Sxx_unvoiced));  % 对数幅度谱

% 绘图
figure;
subplot(2, 1, 1);
plot(F_voiced, log_mag_voiced(:,1)); 
hold on;
plot(f_voiced, 20*log10(abs(H_voiced)), 'r', 'LineWidth', 2); 
title('有声语音：STFT和LPC对数幅度谱');
xlabel('频率 (Hz)');
ylabel('幅度 (dB)');
legend('STFT (log)', 'LPC (log)');
grid on;

subplot(2, 1, 2);
plot(F_unvoiced, log_mag_unvoiced(:,1)); 
hold on;
plot(f_unvoiced, 20*log10(abs(H_unvoiced)), 'r', 'LineWidth', 2); 
title('无声语音：STFT和LPC对数幅度谱');
xlabel('频率 (Hz)');
ylabel('幅度 (dB)');
legend('STFT (log)', 'LPC (log)');
grid on;
