
clc 
clear
close all
 
[x, fs] = audioread('test_16k.wav');
t = (0:length(x)-1)/fs; 
Wp = 5000 / (fs/2);
 
N = 7; 

[b,a] = ellip(6,0.1,40,Wp);

 

y = filter(b, a, x);

audiowrite('test_5k.wav',y,fs);

figure;
subplot(2,1,1);
plot(t, x);
title('原始信号');
xlabel('t/s');
ylabel('幅值');
 
subplot(2,1,2);
plot(t, y);
title('滤波信号');
xlabel('t/s');
ylabel('幅值');


n=length(x);
x_fft=fft(x);
P2 = abs(x_fft/n); 
P1 = P2(1:n/2+1); 
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(n/2))/n;
figure(2)
subplot(2,1,1)
plot(f,P1);
title('原信号频谱')
xlabel('f/Hz')
ylabel('幅值')

y_fft=fft(y);
P2 = abs(y_fft/n); 
P1 = P2(1:n/2+1); 
P1(2:end-1) = 2*P1(2:end-1); 
f = fs*(0:(n/2))/n; 
subplot(2,1,2)
plot(f,P1);
title('滤波信号频谱')
xlabel('f/Hz')
