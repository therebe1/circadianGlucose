% Program to simulate the Sturis et al. 1991 model
function [t, y] = sturisSolver(state, const, time)

%% Solve ODE using stiff solver
opts = odeset('RelTol',1e-10);
[t, y] = ode15s(@(t,y) models.sturis(t, y, const), time, state, opts);

end