clc;clear;
%%
%Before anything, set the graph aesthetics
PS = PLOT_STANDARDS();

%Define parameter values
s = 0.2;
alpha = 0.3;
n = 0.01;
delta = 0.05; 
g = 0.05;

%Create a number of 1000 k values from 1 to 3
k = linspace(0, 3, 1000);

%Compute sk^alpha and (n+g+delta)k
k_alpha = k .^ alpha;
sk_alpha = s .* k .^ alpha;
ngd_k = (n + g + delta + n*g) .* k;
line = s .* k .^ alpha - (n + g + delta + n*g) .* k;

%Find the intersection point of the two functions except for k=0
intersection_point = fzero(@(k) s*k^alpha-(n+g+delta+n*g)*k, [1,3]);

%Create a figure 
figure(1);
fig1_comps.fig = gcf;
grid on;
hold on;

%Plot the requested functions
fig1_comps.p0 = plot(k, k_alpha);
fig1_comps.p1 = plot(k, sk_alpha);
fig1_comps.p2 = plot(k, ngd_k);
fig1_comps.p3 = scatter(intersection_point,...
    s*intersection_point^alpha);
fig1_comps.p5 = plot(k, line);

%Graph aesthetics
set(fig1_comps.p0, 'Color', PS.Blue4, 'LineWidth', 6);
set(fig1_comps.p1, 'Color', PS.Blue5, 'LineWidth', 6);
set(fig1_comps.p2, 'Color', PS.Red5, 'LineWidth', 5.5);
set(fig1_comps.p3, 'Marker','diamond', ...
    'MarkerFaceColor', PS.Orange5)
set(fig1_comps.p5, 'Color', PS.Grey2, 'LineWidth', 6);

xline(intersection_point, 'Color','black','LineStyle','--');
yline(0, 'Color', 'black', 'LineWidth',5);

%Label the axis and the title
xlabel('$k_t$','FontSize',28,'Interpreter','latex');
ylabel('Function Values', 'FontSize',28, 'FontName','Palatino');
legend('$f(k)$',...
    '$sk^\alpha$',...
    '$(n+g+\delta+ng)k$', ...
    'Equilibrium Capital Stock $k^*$',...
    '$sk^\alpha-(n+g+\delta+ng)k$',...
    'Location','best',...
    'Interpreter','latex',...
    'FontSize', 28)
text(2.3, -0.01, '$k^* \approx 2.33$', 'Interpreter','latex', 'FontSize', 28);
hold off;
