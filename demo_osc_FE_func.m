function demo_osc_FE_func()
    omega = 2;
    P = 2*pi/omega;
    dt = P/20;
    T = 3*P;
    X_0 = 2;
    [u, v, t] = osc_FE_func(X_0, omega, dt, T); %calling the osc_fe function
    plot(t, u, t, X_0*cos(omega*t)) 
    legend('numerical', 'exact');
    xlabel('t');
end