c=35000; 
l1 = input('l1: ');
A1 = input('A1: ');
l2 = input('l2: ');
A2 = input('A2: ');
rG=1.0;
rL=1.0;
l=l1+l2;
r1=(A2-A1)/(A2+A1);
tau1=l1/c;
tau2=l2/c;
tau=l/c;

numc=0.5*(1+rG)*(1+rL)*(1+r1);
denc1=r1*rG;
denc2=r1*rL;
denc3=rL*rG;

freq=0:1:5000;
num=complex(numc*cos(2*pi*freq*tau),...
    -numc*sin(2*pi*freq*tau));
den=complex(1+denc1*cos(2*pi*freq*2*tau1)+denc2*cos(2*pi*freq*2*tau2)...
    +denc3*cos(2*pi*freq*2*tau),...
    -denc1*sin(2*pi*freq*2*tau1)-denc2*sin(2*pi*freq*2*tau2)...
    -denc3*sin(2*pi*freq*2*tau));
v=num./den;
vm=20*log10(abs(v));
subplot(2, 1, 1);
plot(freq,vm);
xlabel('Frequency (Hz)');
ylabel('Log Magnitude (dB)');
title('Vocal Tract Log Magnitude Spectrum');

[~, locs] = findpeaks(vm, 'MinPeakHeight', -20);
hold on;
plot(freq(locs), vm(locs), 'r*');
legend('Magnitude Spectrum', 'Formants');

rG=1;
rL=1;
numc=0.5*(1+rG)*(1+rL)*(1+r1);
denc1=r1*rG;
denc2=r1*rL;
denc3=rL*rG;

freq=0:1:5000;
num=complex(numc*cos(2*pi*freq*tau),...
    -numc*sin(2*pi*freq*tau));
den=complex(1+denc1*cos(2*pi*freq*2*tau1)+denc2*cos(2*pi*freq*2*tau2)...
    +denc3*cos(2*pi*freq*2*tau),...
    -denc1*sin(2*pi*freq*2*tau1)-denc2*sin(2*pi*freq*2*tau2)...
    -denc3*sin(2*pi*freq*2*tau));
v=num./den;
vm=20*log10(abs(v));
subplot(2, 1, 2);
plot(freq,vm);
xlabel('Frequency (Hz)');
ylabel('Log Magnitude (dB)');
title('Vocal Tract Log Magnitude Spectrum');

[~, locs] = findpeaks(vm, 'MinPeakHeight', -20);
hold on;
plot(freq(locs), vm(locs), 'r*');
legend('Magnitude Spectrum', 'Formants');
