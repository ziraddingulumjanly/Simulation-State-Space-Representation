%% Simulating original State-Space System 
%% Ziraddin Gulumjanli 2025
clear; clc; close all;

% Obtain script directory for saving files
full_fun_path = which(mfilename('fullpath'));
path_name = fullfile(fileparts(full_fun_path), filesep);

% System Matrices
A = [0 1 0 0; 
     0 0 1 0; 
     0 0 0 1; 
    -2 -5 -7 -2];

B = [0; 0; 0; 1];

C = [1 3 0 0];

D = 0; 

% Input function u(t)
u = @(t) exp(-0.3*t) .* sin(t);

% State Derivative Function
dxdt = @(t, x) A*x + B*u(t);

% Initial Condition
x0 = [1; 1; 1; 1];

% Time Span
TSPAN = [0 10];

% Solve using ODE45
options = odeset('RelTol',1e-8, 'AbsTol',1e-8);
[T, X] = ode45(dxdt, TSPAN, x0, options);

% Compute Output y(t)
Y = C * X';

% Set Fontsize & Linewidth
fontsize = 18;
linewidth = 1.5;

% Create Figure
hf = figure;
hf.Color = 'w';

% Plot State Evolution
subplot(2,1,1);
plot(T, X, 'LineWidth', linewidth);
xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('$x(t)$ (States)', 'Interpreter', 'latex', 'FontSize', fontsize);
legend('$x_1$', '$x_2$', '$x_3$', '$x_4$', 'Interpreter', 'latex', 'FontSize', fontsize-8);
title('State Evolution Over Time','Interpreter', 'latex',  'FontSize', fontsize);
grid off;

% Plot Output Response
subplot(2,1,2);
plot(T, Y, 'r', 'LineWidth', linewidth);
xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('$y(t)$ (Output)', 'Interpreter', 'latex', 'FontSize', fontsize);
legend('$y(t)$', 'Interpreter', 'latex', 'FontSize', fontsize-8);
title('Output $y(t)$ Over Time', 'Interpreter', 'latex', 'FontSize', fontsize);
grid off;

% Adjust Figure Appearance
ha1 = subplot(2,1,1);
ha1.FontSize = fontsize - 2;
ha1.LineWidth = 1;

ha2 = subplot(2,1,2);
ha2.FontSize = fontsize - 2;
ha2.LineWidth = 1;

% Define Save Paths
savename_pdf = strcat(path_name, 'h2_p2b_gulumjanli.pdf');
savename_png = strcat(path_name, 'h2_p2b_gulumjanli.png');

% Export Graphics
exportgraphics(hf, savename_pdf);
exportgraphics(hf, savename_png);
