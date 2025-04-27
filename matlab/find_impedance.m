clear; close all;

f0 = 10e9;
gamma = 0.8613+1j*0.4836;

gamma = 0.8393 - 0.5207j;

e0 = 8.854*10^-12;
u0 = 4*pi*10^-7;

er1 = 6.15;
c0 = 1/sqrt(e0*u0);
lambda0 = c0/f0;

eta0 = sqrt(u0/e0);
k0 = 2*pi/lambda0;
k1 = k0*sqrt(er1);
space = 0.0174425;
%gammaD = gamma*exp(2j*k0*space);
gammaD = gamma;

etaIn = eta0*(1+gammaD)/(1-gammaD);

eta1 = eta0/sqrt(er1);
d = 2.54e-3; %mm


eta_sheet = ((1/etaIn)-(1/(1j*eta1*tan(k1*d))))^-1;

%% Numerical Solution
syms f(etaSurf)

kx1(etaSurf) = sqrt(k0^2*(er1-1)+(etaSurf*k0/eta0)^2);
f(etaSurf) = -(1/etaSurf)+(1/eta_sheet)+(1/(1j*tan(kx1*d)*eta0*kx1/(k0*er1)));
vpasolve(f)