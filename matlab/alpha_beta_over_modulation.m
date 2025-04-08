clear; close all; clc;
X = 1.2;
k0_a = 5.917;
M = 0:0.01:1;

kappa_over_k0 = sqrt(1+X^2) - ((M.^2)/4)*((X^2)/sqrt(1+X^2))*(1/(1-(1i/X)*sqrt(1+2*pi/k0_a-sqrt(1+X^2)))+1/(1-(1i/X)*sqrt(1-2*pi/k0_a-sqrt(1+X^2))))

beta_over_k0 = real(kappa_over_k0);
alpha_over_k0 = -imag(kappa_over_k0);

figure(1)
plot(M, beta_over_k0)
figure(2)
plot(M, alpha_over_k0)
