function real_cepstrum_analysis(file_path, start_sample, frame_duration_ms, fft_size, cutoff, lifter_type)
    [speech, fs] = audioread(file_path);
    
    frame_length = floor(frame_duration_ms / 1000 * fs);
    
    speech_frame = speech(start_sample:start_sample + frame_length - 1);
    windowed_speech = speech_frame .* hamming(length(speech_frame))';
    Y = fft(windowed_speech, fft_size);
    log_mag_spectrum = 20 * log10(abs(Y) + eps);
    cepstrum = real(ifft(log_mag_spectrum));
    if strcmp(lifter_type, 'low')
        liftered_cepstrum = cepstrum;
        liftered_cepstrum(cutoff:end-cutoff+1) = 0;
    elseif strcmp(lifter_type, 'high')
        liftered_cepstrum = cepstrum;
        liftered_cepstrum(1:cutoff) = 0;
        liftered_cepstrum(end-cutoff+1:end) = 0;
    else
        error('Invalid lifter type. Use "low" or "high".');
    end
    
    liftered_log_mag_spectrum = real(fft(liftered_cepstrum, fft_size));

    figure;
    
    subplot(4,1,1);
    plot(windowed_speech);
    title('Hamming windowed speech');
    xlabel('Sample');
    ylabel('Amplitude');
    
    subplot(4,1,2);
    plot(log_mag_spectrum);
    hold on;
    plot(liftered_log_mag_spectrum, 'r');
    title('Log magnitude spectrum and cepstrally smoothed log magnitude spectrum');
    xlabel('Frequency bin');
    ylabel('Magnitude (dB)');
    legend('Log magnitude spectrum', 'Cepstrally smoothed');

    subplot(4,1,3);
    plot(cepstrum);
    title('Real cepstrum');
    xlabel('Quefrency');
    ylabel('Amplitude');

    subplot(4,1,4);
    plot(liftered_log_mag_spectrum);
    title('Liftered log magnitude spectrum');
    xlabel('Frequency bin');
    ylabel('Magnitude (dB)');

    sgtitle(['Speech frame analysis: ' lifter_type ' quefrency lifter']);
end

file_path = 'test_16k.wav';
start_sample_voiced = 13000;
frame_duration_ms = 40;
fft_size = 1024;
cutoff_low = 50;
cutoff_high = 200; 

% 处理有声帧
real_cepstrum_analysis(file_path, start_sample_voiced, frame_duration_ms, fft_size, cutoff_low, 'low');
real_cepstrum_analysis(file_path, start_sample_voiced, frame_duration_ms, fft_size, cutoff_high, 'high');

% 处理无声帧
start_sample_unvoiced = 1000;
real_cepstrum_analysis(file_path, start_sample_unvoiced, frame_duration_ms, fft_size, cutoff_low, 'low');
real_cepstrum_analysis(file_path, start_sample_unvoiced, frame_duration_ms, fft_size, cutoff_high, 'high');