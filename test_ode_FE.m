function test_ode_FE()
    test_ode_FE_1(); % test a)
    test_ode_FE_2(); % test b)
end

function test_ode_FE_1()
    previous = [1; 2; 4; 8]; %previously aquired solutions
    T = 3;
    dt = 1;
    u_0 = 1.0;
    function result = f(u, t)
        result = u;
    end
    [u, t] = ode_FE(@f, u_0, dt, T); %call ode_fe for new solutions
    difference = previous-u %prints the difference between previous and new results
end
        
function test_ode_FE_2()
    T = 3;
    dt = 0.1;
    U_0 = 1.0; 
    function result = f(u, t)
        r = 1;
        result = r*u;   %multiply u with constant r
    end
    function result = u_exact(U_0, dt, n)
        r = 1;
        result = U_0*(1+r*dt)^n;
    end
    [u, t] = ode_FE(@f, U_0, dt, T);
    tol = 1E-6;
    for n = 1:length(u) % test difference for each u value
        diff = abs(u_exact(U_0, dt, n-1) - u(n));
        assert(diff < tol, 'n=%d, err=%g', n, diff); %gives error if difference is significant
    end
end