clear; close all; clc;
X = 1.2;
k0_a = 5.917;
M = 0:0.01:1;

kappa_over_k0 = sqrt(1+X^2) - ((M.^2)/4)*((X^2)/sqrt(1+X^ ...
    2))*(1/(1-(1i/X)*sqrt(1+2*pi/k0_a-sqrt(1+X^2)))+1/(1-(1i/ ...
    X)*sqrt(1-2*pi/k0_a-sqrt(1+X^2))));

beta_over_k0 = real(kappa_over_k0);
alpha_over_k0 = -imag(kappa_over_k0);

% figure(1)
% plot(M, beta_over_k0)
% figure(2)
% plot(M, alpha_over_k0)

u0=4*pi*10^-7;
e0=8.854e-12;
eta0=sqrt(u0/e0);

M = 0.2;
a = 28.25e-3;
Xprime = 1.2;
z = linspace(0,28.25e-3,10);

X0 = eta0.*Xprime.*(1+M.*cos(z.*2*pi./a));
figure
yyaxis left
plot(10*z/a,X0,'linewidth',1)
xlabel('Gap Number')
ylabel('Surface Reactance [$\Omega$]')
grid on
hold on
fontsize(16,'points')

gap_size_um = (-1.9667*X.^5 + 1943.9703*X.^4 + -390156.861*X.^ ...
    3 + -4674.6409*X.^2 + -26.3167*X + -0.011268) ./ (X.^4 + -466.5891*X.^ ...
    3 + 52195.9033*X.^2 + -15293.5661*X + -166.5399);

gap_size_um1 = (-1.9667*X0.^5 + 1943.9703*X0.^4 + -390156.861*X0.^ ...
    3 + -4674.6409*X0.^2 + -26.3167*X0 + -0.011268) ./ (X0.^4 + -466.5891*X0.^ ...
    3 + 52195.9033*X0.^2 + -15293.5661*X0 + -166.5399);
gap_size_um1 = gap_size_um1';
yyaxis right
plot(10*z/a,gap_size_um1,'linewidth',1)
ylabel('Gap Size [$\mu$m]')