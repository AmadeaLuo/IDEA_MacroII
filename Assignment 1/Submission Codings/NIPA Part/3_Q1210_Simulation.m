%% Question 1.2.10
clc;clear;

% Set the working directory to the place where the current file is saved
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));

% Before anything, set the graph aesthetics
PS = PLOT_STANDARDS();
%% Simulation for T = 10, 30, 50 and 100

% Parameters
alpha = 0.3;
s = 1-0.6523;
n = 0.0133;
delta = 0.0495;
g = 0.1961;

% Define time periods
T = [10 30 50 100];

% Initialize variables
k = zeros(length(T), max(T));
y = zeros(length(T), max(T));
c = zeros(length(T), max(T));

% Loop through time periods
for i = 1:length(T)
    % Initialize starting point
    k(i,1) = 1;
    for t = 2:T(i)
        k(i,t) = s*k(i,t-1)^alpha + (1-delta)*k(i,t-1) - (n+g)*k(i,t-1);
        y(i,t) = k(i,t)^alpha;
        c(i,t) = (1-s)*y(i,t);
    end
end

% Plot results in four subplots
figure(8);
hold on;
subplot(2,2,1);
k1 = plot(1:T(1), k(1,1:T(1)));
set(k1, 'Color', PS.Blue1, 'LineWidth', 2, 'Marker','o')
title('$T=10$', 'Interpreter','latex');
xlabel('Time', 'FontName','Palatino');
ylabel('Capital','FontName','Palatino');

subplot(2,2,2);
k2 = plot(1:T(2), k(2,1:T(2)));
set(k2, 'Color', PS.Blue2, 'LineWidth', 2, 'Marker','o')
title('$T=30$', 'Interpreter','latex');
xlabel('Time', 'FontName','Palatino');
ylabel('Capital','FontName','Palatino');

subplot(2,2,3);
k3 = plot(1:T(3), k(3,1:T(3)));
set(k3, 'Color', PS.Blue3, 'LineWidth', 2, 'Marker','o')
title('$T=50$', 'Interpreter','latex');
xlabel('Time', 'FontName','Palatino');
ylabel('Capital','FontName','Palatino');

subplot(2,2,4);
k4 = plot(1:T(4), k(4,1:T(4)));
set(k4, 'Color', PS.Blue4, 'LineWidth', 2, 'Marker','o')
title('$T=100$', 'Interpreter','latex');
xlabel('Time', 'FontName','Palatino');
ylabel('Capital','FontName','Palatino');

hold off;





