function SIRV_p_adapt()    
    % As SIRV1.m, but including time-dependent vaccination.
    % Time unit: 1 h
    close all, clear all, clc
    
    beta = 10/(40*8*24);
    beta = beta/4;                % Reduce beta compared to SIR1.py
    fprintf('beta: %g\n', beta);
    gamma = 3/(15*24);
    dt = 0.1;                      % 6 min
    D = 200;                       % Simulate for D days
    N_t = floor(D*24/dt);          % Corresponding no of hours
    nu = 1/(24*50);                % Average loss of immunity: 50 days
    delta = 10*24;                 % Starting day 
    p0 = 0.001;

    t = linspace(0, N_t*dt, N_t+1);
    S = zeros(N_t+1, 1);
    I = zeros(N_t+1, 1);
    R = zeros(N_t+1, 1);
    V = zeros(N_t+1, 1);
    
    function result = p(t, n) %function to implement specific vaccination policy
        if (V(n) < 0.5*(S(1)+I(1)) && t > delta)
            result = p0;
        else
            result = 0;
        end
    end

    % Initial condition
    S(1) = 50;
    I(1) = 1;
    R(1) = 0;
    V(1) = 0;

    % Step equations forward in time
    for n = 1:N_t
        S(n+1) = S(n) - dt*beta*S(n)*I(n) + dt*nu*R(n) - dt*p(t(n),n)*S(n);
        V(n+1) = V(n) + dt*p(t(n),n)*S(n);
        I(n+1) = I(n) + dt*beta*S(n)*I(n) - dt*gamma*I(n);
        R(n+1) = R(n) + dt*gamma*I(n) - dt*nu*R(n);
        loss = floor(V(n+1) + S(n+1) + R(n+1) + I(n+1)) -...
                             (V(1) + S(1) + R(1) + I(1));
        if loss > 0
            fprintf('loss: %d\n', loss);
        end
    end

    plot(t, S, t, I, t, R, t, V);
    legend('S', 'I', 'R', 'V', 'Location', 'northwest');
    xlabel('hours');
end