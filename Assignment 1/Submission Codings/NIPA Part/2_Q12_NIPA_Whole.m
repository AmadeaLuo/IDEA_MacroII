%% Question 1.2.3
clc;clear;

% Set the working directory to the place where the current file is saved
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));

%% 

% Read and extract Gross Domestic Product Data from Table 1.1.5

T115 = readtable('Table 1.1.5.xlsx', 'VariableNamingRule','preserve');
gdp = T115{1,3:end};

% Read and extract Compensation of Employees from Table 1.12

T112 = readtable('Table 1.12.xlsx', 'VariableNamingRule','preserve');
coe = T112{2,3:end};

% Extract and munipulate for ... from Table 1.12

% Proprietors' income with IVA and CCAdj
% Taxes on production and imports
% Business current transfer payments (net)
% Current Surplus of government enterprises

adj1 = T112{32, 3:end};
adj2 = T112{19, 3:end};
adj3 = T112{21, 3:end};
adj4 = T112{25, 3:end};

adjgdp = adj1+adj2+adj3+adj4;

%% A quick descriptive stats for variables in 1.2.3

variables = {'gdp', 'coe', 'adjgdp'};
mean_values = zeros(1,3);
median_values = zeros(1,3);
std_values = zeros(1,3);
min_values = zeros(1,3);
max_values = zeros(1,3);

for i = 1:length(variables)
    mean_values(i) = mean(variables{i});
    median_values(i) = median(variables{i});
    std_values(i) = std(variables{i});
    min_values(i) = min(variables{i});
    max_values(i) = max(variables{i});
end
stats = {'mean', 'median', 'std', 'min', 'max'};

summary_table = array2table(cell(length(variables),length(stats)),...
    'VariableNames',stats);
for i = 1:length(variables)
    for j = 1:length(stats)
        summary_table{i,j} = arrayfun(@(x) sprintf('%.2f',x),...
            eval([stats{j} '(' variables{i} ')']),'UniformOutput',false);
    end
end
summary_table.Properties.RowNames = variables;

%% (Please use the add-on 'MATLAB Table to LaTeX converter')

% Exporting Summary Stats as solution
table2latex(summary_table, 'Q123summary_stats.tex')

%% Question 1.2.4 Compute Net GDP

%Before anything, set the graph aesthetics
PS = PLOT_STANDARDS();

netgdp = gdp - adjgdp;
labshare = coe ./ netgdp;
m_labshare = mean(labshare);

%% An Area Plot for Labshare

T = 1960:2021;
figure(2);
fig1_comps.fig = gca;
grid on;
hold on;

fig2_comps.p0 = area(T, netgdp);
fig2_comps.p1 = area(T, coe);

set(fig2_comps.p0, 'FaceColor', PS.Blue3);
set(fig2_comps.p1, 'FaceColor', PS.Blue5);

xlabel('$T$','FontSize',18,'Interpreter','latex');
ylabel('Values of GDP(billions)', 'FontSize',22, 'FontName','Palatino');
legend('Net GDP','Compensation of Employees',...
    'FontSize',18, 'FontName','Palatino', 'Location', 'Best');

hold off;

%% A Line Plot for Labshare (requested by the Q)

T = 1960:2021;
figure(3);
fig3_comps.fig = gcf;
grid on;
hold on;

fig3_comps.p0 = plot(T, labshare);
fig3_comps.p1 = yline(m_labshare, 'Color','black',...
    'LineStyle','--');

set(fig3_comps.p0, 'Color', PS.Red5, 'LineWidth', 3, 'Marker','diamond');
text(2020, 0.6, '$\mu_{LS}=0.6523$', ...
    'Interpreter','latex', 'FontSize', 18);

xlabel('$T$','FontSize',22,'Interpreter','latex');
ylabel('Labour Share Over Time', 'FontSize',20, 'FontName','Palatino');
legend('$\frac{coe}{gdp}$', '$\mu_{LS}$', ...
    'Interpreter', 'latex',...
    'location', 'best','Fontsize', 24);

hold off;

%% Question 1.2.5 Plot for kyratio

T1 = readtable('Table 1.1.xlsx', 'VariableNamingRule','preserve');
kstock = T1{2, 3:end};

%capital-output ratio:
kyratio = kstock ./gdp;
m_kyratio = mean(kyratio);
kyratio2 = kstock ./netgdp;
m_kyratio2 = mean(kyratio2);
%figure
T = 1960:2021;

figure(4);
fig4_comps.fig = gcf;
grid on;
hold on;

fig4_comps.p0 = plot(T, kyratio);
fig4_comps.p1 = yline(m_kyratio, 'Color','black',...
    'LineStyle','--');

set(fig4_comps.p0, 'Color', PS.Blue5, 'LineWidth', 3, 'Marker','+');
text(2020, 0.6, '$\mu_{LS}=0.6523$', 'Interpreter','latex', ...
    'FontSize', 18);

xlabel('$T$','FontSize',22,'Interpreter','latex');
ylabel('Capital-Output Ratio Over Time', ...
    'FontSize',20, 'FontName','Palatino');
legend('$\frac{kstock}{gdp}$', '$\mu_{KS}$', ...
    'Interpreter', 'latex',...
    'location', 'best','Fontsize', 24);

hold off;

%% Question 1.2.6 Compute depreciation rate

T13 = readtable('Table 1.3.xlsx', 'VariableNamingRule','preserve');
depreciation = T13{2, 3:end};

delta = depreciation ./ kstock;
m_delta = mean(delta);

T = 1960:2021;

figure(5);
fig5_comps.fig = gcf;
grid on;
hold on;

fig5_comps.p0 = plot(T, delta);
fig5_comps.p1 = yline(m_delta, 'Color','black',...
    'LineStyle','--');

set(fig5_comps.p0, 'Color', PS.Grey5, 'LineWidth', 3, 'Marker','+');
text(2000, 0.05, '$\mu_{\delta}=0.0495$', ...
    'Interpreter','latex', 'FontSize', 18);

xlabel('$T$','FontSize',22,'Interpreter','latex');
ylabel('Depreciation Rate over time', ...
    'FontSize',20, 'FontName','Palatino');
legend('$\delta = \frac{Depreciation}{kstock}$', '$\mu_{\delta}$', ...
    'Interpreter', 'latex',...
    'location', 'best','Fontsize', 22);

hold off;

%% Question 1.2.7

% Fetch price indexes for gdp and capital stock
T114 = readtable('Table 1.1.4.xlsx', 'VariableNamingRule','preserve');
gdpd = T114{1, 3:end};
capp = T114{7, 3:end};

% Deflate gdp and capital stock
realgdp = gdp ./ gdpd;
realk = kstock ./capp;

% Fetch Total hours worked in domestic industries
% and glue them together from three Tables
T69B = readtable('Table 6.9B.xlsx', 'VariableNamingRule','preserve');
h6087 = T69B{1, 3:end};
T69C = readtable('Table 6.9C.xlsx', 'VariableNamingRule','preserve');
h8800 = T69C{1, 4:end};
T69D = readtable('Table 6.9D.xlsx', 'VariableNamingRule','preserve');
h0121 = T69D{1, 4:end};
hw = horzcat(h6087, h8800, h0121);
%
% Compute A_t
capcomponent = realk.^(1-labshare);
hwcomponent = hw.^labshare;
power = 1./(1-labshare);
A = (realgdp ./ (capcomponent .* hwcomponent)).^power;

% Compute A_t growth rate
gA = diff(A) ./ A(1:end-1);
m_gA = mean(gA);

% Graph~
figure(6);
fig5_comps.fig = gcf;
grid on;
hold on;

T = 1960:2020;
fig6_comps.p0 = plot(T, gA);
fig6_comps.p1 = yline(m_gA, 'Color','black',...
    'LineStyle','--');
set(fig6_comps.p0, 'Color', PS.Red3, 'LineWidth', 3, 'Marker','+');

xlabel('$T$','FontSize',22,'Interpreter','latex');
ylabel('Growth Rate of $A_t$', ...
    'FontSize',20, 'FontName','Palatino','Interpreter','latex');
legend('$g_{A_t}$', '$\mu_{g_{A_t}}$', ...
    'Interpreter', 'latex',...
    'location', 'best','Fontsize', 22);

hold off;

%% Question 1.2.8 Growth rate of L_t

n = diff(hw) ./ hw(1:end-1);
m_n = mean(n);

% Graph~
figure(7);
fig7_comps.fig = gcf;
grid on;
hold on;

T = 1960:2020;
fig7_comps.p0 = plot(T, n);
fig7_comps.p1 = yline(m_n, 'Color','black',...
    'LineStyle','--');
set(fig7_comps.p0, 'Color', PS.Green5, 'LineWidth', 3, 'Marker','o');

xlabel('$T$','FontSize',22,'Interpreter','latex');
ylabel('Growth Rate of $L_t$', ...
    'FontSize',20, 'FontName','Palatino','Interpreter','latex');
legend('$g_{L_t}$', '$\mu_{g_{L_t}}$', ...
    'Interpreter', 'latex',...
    'location', 'best','Fontsize', 22);

hold off;

%%



 








