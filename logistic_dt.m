f = @(u,t) 0.1*(1-u/500)*u;
U_0 = 100;
dt = 20;
T = 100;
k = 1;
[u_old, t_old] = ode_FE(f, U_0, dt, T);

answer = 'y';
while answer == 'y'
    dt_k = 2^(-k)*dt;
    [u_new, t_new] = ode_FE(f, U_0, dt_k, T);
    plot(t_old, u_old, t_new, u_new)
    xlabel('t'); 
    ylabel('N(t)'); 
    fprintf('Timestep dt was: %g\n', dt_k);
    answer = input('Halve timestep (y/n)? \n', 's');
    if answer == 'y'
        u_old = u_new;
        t_old = t_new;
    else
        fprintf('Testing stopped \n', dt_k);
        break
    end
    k = k + 1;
end

function [u, t] = ode_FE(f, U_0, dt, T)
    N_t = floor(T/dt);
    u = zeros(N_t+1, length(U_0));
    t = linspace(0, N_t*dt, length(u));
    u(1,:) = U_0;      % Initial values
    t(1) = 0;
    for n = 1:N_t
        u(n+1,:)  = u(n,:) + dt*f(u(n,:), t(n));
    end
end
