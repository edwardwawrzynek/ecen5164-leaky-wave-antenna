clear; close all;

filename = 'C:\Users\sockg\OneDrive\Documents\Documents\CU Boulder 2024-2025\Spring\Metamaterials\ecen5164-leaky-wave-antenna\testing\leaky_wave_antenna.s2p'; %input s2p file name
S = sparameters(filename);

s11 = rfparam(S, 1, 1);
s12 = rfparam(S, 1, 2);
s21 = rfparam(S, 2, 1);
s22 = rfparam(S, 2, 2);

freq = S.Frequencies;

f0 = figure;
hold on
grid on
plot(freq/1e9,mag2db(abs(s11)),'linewidth',1)
plot(freq/1e9,mag2db(abs(s22)),'linewidth',1)

xlabel('Frequency [GHz]','Interpreter','latex')
ylabel('Magnitude [dB]','Interpreter','latex')
legend('$|S_{11}|_{dB}$','$|S_{22}|_{dB}$','interpreter','latex','location','southeast')
fontsize(16,'points')
f0.Position = [100 100 700 500];

f1 = figure;
hold on
grid on
plot(freq/1e9,mag2db(abs(s12)),'linewidth',1)
plot(freq/1e9,mag2db(abs(s21)),'linewidth',1)

xlabel('Frequency [GHz]','Interpreter','latex')
ylabel('Magnitude [dB]','Interpreter','latex')
legend('$|S_{12}|_{dB}$','$|S_{21}|_{dB}$','interpreter','latex','location','southeast')
fontsize(16,'points')
f1.Position = [100 100 700 500];

f2 = figure;
hold on
grid on
plot(freq/1e9,mag2db(abs(s11)),'linewidth',1)
plot(freq/1e9,mag2db(abs(s21)),'linewidth',1)

xlabel('Frequency [GHz]','Interpreter','latex')
ylabel('Magnitude [dB]','Interpreter','latex')
legend('$|S_{11}|_{dB}$','$|S_{21}|_{dB}$','interpreter','latex','location','southeast')
fontsize(16,'points')
f2.Position = [100 100 700 500];