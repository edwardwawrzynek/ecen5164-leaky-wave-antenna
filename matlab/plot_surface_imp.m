function plot_surface_imp
    set(groot,'defaultTextInterpreter','latex');
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(groot, 'defaultLegendInterpreter','latex');

    % deembed distance (m)
    deembed = 20e-3;
    % design frequency (Hz)
    f0 = 10e9;
    % dielectric relative perimitivity
    er1 = 6.15;
    % dielectric thickness
    d = 2.54e-3;

    % range of swept gap sizes
    gap_sizes = 50:50:2540;
    surf_reactance = zeros(1, numel(gap_sizes));
    % calculate the surface impedance for each gap size
    for i = 1:numel(gap_sizes)
        gap_size = gap_sizes(i);
        sp = sparameters("gap_sweep/surface_imp_gap_" + gap_size + "um.s1p");
        gamma = dembed_plane(sp.Parameters, f0, deembed);
        eta_x = eta_surf(gamma, f0, er1, d);
        surf_reactance(i) = eta_x;
    end
    % fit relationship to rational
    f = fit(surf_reactance', gap_sizes', 'rat54');
    surf_reactance_eval = min(surf_reactance):5:max(surf_reactance);
    gap_sizes_eval = feval(f, surf_reactance_eval);
    
    fc = coeffvalues(f);
    disp("gap_size_um = ("+fc(1)+"*X.^5 + "+fc(2)+"*X.^4 + "+fc(3)+"*X.^3 + "+fc(4)+"*X.^2 + "+fc(5)+"*X + "+fc(6)+") ./ (X.^4 + "+fc(7)+"*X.^3 + "+fc(8)+"*X.^2 + "+fc(9)+"*X + "+fc(10)+")");

    plot(surf_reactance, gap_sizes, 'o');
    hold on;
    plot(surf_reactance_eval, gap_sizes_eval, '-k');
    grid on;
    xlabel("Im($\eta_{surf}$) ($\Omega$)");
    ylabel("Gap Size ($\mu$m)");
end

% dembed gamma by a distance d
function gamma_d = dembed_plane(gamma, f, d)
    c = 3.00e8;
    k = 2*pi*f / c;

    gamma_d = gamma * exp(2j*k*d);
end

% convert reflection coefficient to sheet impedance
function eta_surface = eta_surf(gamma, f0, er1, d)
    e0 = 8.854*10^-12;
    u0 = 4*pi*10^-7;

    eta0 = sqrt(u0 / e0);
    eta1 = eta0 / sqrt(er1);

    k0 = 2*pi*f0*sqrt(e0*u0);
    k1 = k0*sqrt(er1);
    
    % convert gamma to input impedance
    eta_in = eta0 * (1 + gamma) / (1 - gamma);
    % convert normal incident gamma to sheet impedance
    eta_sheet = ((1/eta_in)-(1/(1j*eta1*tan(k1*d))))^-1;
    % we expect the sheet to be purely reactive (no loss)
    assert(real(eta_sheet) < 1e-12);
    % make the sheet impedance purely reactive
    eta_sheet = 1j*imag(eta_sheet);

    % extract TM surface impedance
    kx1 = @(eta_surf) sqrt(k0^2*(er1-1) - (imag(eta_surf)*k0./eta0).^2);
    eta_down_inv = @(eta_surf)  1./imag(eta_sheet) + 1./(eta0.*kx1(eta_surf)./k0./er1.*tan(kx1(eta_surf)*d));
    % equation to solve for eta_surf
    eta_surf_eq = @(eta_surf) 1./imag(eta_surf) - eta_down_inv(eta_surf);
    
    syms eta_surf_x;
    eta_surface = vpasolve(eta_surf_eq(1j*eta_surf_x) == 0, eta_surf_x, [0 5000]);
    eta_surface = double(eta_surface);
end