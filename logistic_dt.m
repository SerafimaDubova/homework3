%4.4
%set paramentrs 
dt = 10; 
T = 100;
f = @(u,t) 0.1*(1-u/500)*u;
U_0 = 100;
%ODE solution for the initial time step
[u_old, t_old] = ode_FE(f, U_0, dt, T);

k = 1;
one_more = true;
while one_more == true
    %calculate numerical solutions
    dt_k = 2^(-k)*dt;
    [u_new, t_new] = ode_FE(f, U_0, dt_k, T);
    %show results to user
    plot(t_old, u_old, 'b-', t_new, u_new, 'r--')
    xlabel('t'); ylabel('N(t)'); 
    legend('dt_k-1', 'dt_k'); 
    fprintf('Timestep №1 was: %g\n Timestep №2 was: %g\n ', dt_k-1, dt_k);
    %asking user for continue 
    answer = input('Do you want to continue? press y-yes/n-no. ', 's')
    if strcmp(answer,'y')
        u_old = u_new;
        t_old = t_new;
    else
        one_more = false;
    end
    k = k + 1;
end
%ode function 
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
