%% Question 3.1
clc;clear;

% Set the working directory to the place where the current file is saved
tmp = matlab.desktop.editor.getActive;
cd(fileparts(tmp.Filename));

%% 3.1 Data Import, Saving rate and 
ameco = readtable('AMECOclean.xlsx', 'ReadVariableNames',true,...
    'VariableNamingRule','preserve');

saving = ameco{1:22, 3:end};
gdp = ameco{23:44, 3:end};
consumption = ameco{45:66, 3:end};
TFP = ameco{67:88, 3:end};
employment = ameco{89:110, 3:end};

% saving rate
s = saving./gdp;
m_s = mean(s, 2);
countries = ameco{1:22, 2};
saving_T = table(countries, m_s);
% 

%
AL = TFP .* employment;
dconsumption = consumption./AL;
m_dc = mean(dconsumption, 2);
final_T = table(countries, m_s, m_dc);

table2latex(final_T, 'Q131.tex');


%% 3.2 Scatter Plot
lconsumption = log(dconsumption);
sca = scatter(saving, lconsumption);
xlabel('$s$', 'Interpreter','latex');
ylabel('$\ln c_t$', 'Interpreter','latex')


%% 3.3 Pooled Regression

newdconsumption = reshape(lconsumption, [594,1]);
s2 = s.^2;
news = reshape(s, [594,1]);
news2 = reshape(s2, [594,1]);
p = polyfit(news, newdconsumption, 2);








