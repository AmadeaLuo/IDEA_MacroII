%% Question 1.2.9
clc;clear;

% Set the working directory to the place where the current file is saved
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));

% Before anything, set the graph aesthetics
PS = PLOT_STANDARDS();

% Define the parameters
alpha = 1-0.6523;
n = 0.0133;
delta = 0.0495;
g = 0.1961;
T = 100;

% Initialize k, y, and c
k = zeros(T+1, 4);
y = zeros(T, 4);
c = zeros(T, 4);

% Define values of s
s = [0.1, 0.2, 0.4, 0.5];

for i = 1:4
    % Set initial values
    k(1, i) = 1;
    y(1, i) = 1;
    c(1, i) = 1;

    % Iterate over T time periods
    for t = 1:T
        k(t+1, i) = s(i) * (k(t, i) ^ alpha) + ...
            (1 - delta) * k(t, i) * 1/((1+g)*(1+n));
        y(t, i) = k(t, i) ^ (1 - alpha);
        c(t, i) = (1 - s(i)) * y(t, i);
    end
end

figure
subplot(2,2,1);
k1 = plot(k(:,1));
title('$k \vert s=0.1 $', 'Interpreter','latex');
set(k1, 'LineWidth', 2, 'Color', PS.Grey2);
subplot(2,2,2);
k2 = plot(k(:,2));
title('$k \vert s=0.2$', 'Interpreter','latex');
set(k2, 'LineWidth', 2, 'Color', PS.Grey3);
subplot(2,2,3);
k3 = plot(k(:,3));
title('$k \vert s=0.3 $', 'Interpreter','latex');
set(k3, 'LineWidth', 2, 'Color', PS.Grey4);
subplot(2,2,4);
k4 = plot(k(:,4));
title('$k \vert s=0.3 $', 'Interpreter','latex');
set(k4, 'LineWidth', 2, 'Color', PS.Grey5);

