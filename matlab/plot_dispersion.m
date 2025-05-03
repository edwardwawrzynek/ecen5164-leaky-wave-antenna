% This file uses local minima to approximately solve dispersion
clear; clc, close all
function result = f(x, y, m, k, r)
    w = x - i*y

    term1 = sqrt(1 - (k ./ w).^2)
    term2 = sqrt(1 - (k ./ w - 2 * pi ./ w).^2)
    term3 = sqrt(1 - (k ./ w - 4 * pi ./ w).^2)
    term4 = sqrt(1 - (k ./ w + 2 * pi ./ w).^2)
    term5 = sqrt(1 - (k ./ w + 4 * pi ./ w).^2)

    denom1 = 1 - (i / r) .* term3
    denom2 = 1 - (i / r) .* term2 - m^2 ./ (4 * denom1)
    denom3 = 1 - (i / r) .* term5
    denom4 = 1 - (i / r) .* term4 - m^2 ./ (4 * denom3)

    result = abs(-1 + (i / r) * term1 + m^2 ./ (4 * denom2) + m^2 ./ (4 * denom4))
end

m = 0.2
r = 1.2

x = linspace(0.01,2,1000)
y = linspace(0.001, .2, 100)

[X,Y] = meshgrid(x,y)

kappa_array = 0.1:0.1:6
k0_array = zeros(size(kappa_array))
for i = 1:length(kappa_array)
    k = kappa_array(i)
    Z = f(X,Y,m,k,r)
    Z_padded = padarray(Z, [1 1], Inf);  % or use NaN if that suits your data
    TF = islocalmin2(Z_padded);
    TF = TF(2:end-1, 2:end-1);  % crop to original size
    % Do not use corner values
    TF(1,end) = 0
    TF(1,1) = 0
    TF(end,end) = 0
    TF(end,1) = 0
    answer = X(TF)
    if isempty(answer)
        k0_array(i) = NaN
    else
        k0_array(i) = answer(1)
    end
end

figure()
plot(kappa_array, k0_array)
