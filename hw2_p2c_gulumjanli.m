%% Simulating Transformed State-Space System
%% Ziraddin Gulumjanli 2025
clear; clc; close all;

% Original System Matrices (from Part b)
A = [0 1 0 0; 
     0 0 1 0; 
     0 0 0 1; 
    -2 -5 -7 -2];

B = [0; 0; 0; 1];

C = [1 3 0 0];

D = 0;

% Transformation Matrices
Px = [5 6 6 8; 
      0 -1 -4 1; 
      0 0 2 6; 
      -1 0 0 -12];

Qx = [0; 1; -2; -1];

Pu = 2; % Scalar

% Compute Inverse of Px
Px_inv = inv(Px);

% Transformed State-Space Matrices
A_tilde = Px * A * Px_inv;
B_tilde = (Px * B) / Pu;
C_tilde = C * Px_inv;
D_tilde = D / Pu;
Q_tilde = -A_tilde * Qx;
Qy_tilde = -C_tilde * Qx;

% Input transformation: w = u / 2
w = @(t) (exp(-0.3*t) .* sin(t)) / Pu;

% State Derivative Function for Transformed System
dzdt = @(t, z) A_tilde * z + B_tilde * w(t) + Q_tilde;

% Initial Condition in z-space
x0 = [1; 1; 1; 1]; 
z0 = Px * x0 + Qx;

% Time Span
TSPAN = [0 10];

% Solve using ODE45
options = odeset('RelTol',1e-8, 'AbsTol',1e-8);
[T, Z] = ode45(dzdt, TSPAN, z0, options);

% Compute Output y(t)
Y = C_tilde * Z' + D_tilde * w(T)' + Qy_tilde;

% Set Fontsize & Linewidth
fontsize = 18;
linewidth = 1.5;

% Create Figure
hf = figure;
hf.Color = 'w';

% Plot Transformed State Evolution
subplot(2,1,1);
plot(T, Z(:,1), 'b', 'LineWidth', linewidth, 'DisplayName', '$z_1$');
hold on;
plot(T, Z(:,2), 'r', 'LineWidth', linewidth, 'DisplayName', '$z_2$');
plot(T, Z(:,3), 'g', 'LineWidth', linewidth, 'DisplayName', '$z_3$');
plot(T, Z(:,4), 'b', 'LineWidth', linewidth, 'DisplayName', '$z_4$');
hold off;
xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('$z(t)$  (States)', 'Interpreter', 'latex', 'FontSize', fontsize);
legend('Interpreter', 'latex', 'FontSize', fontsize-8);
title('Transformed State Evolution Over Time', 'Interpreter', 'latex','FontSize', fontsize);
grid off

% Plot Output Response
subplot(2,1,2);
plot(T, Y, 'r', 'LineWidth', linewidth);
xlabel('$t$ (Time) [s]', 'Interpreter', 'latex', 'FontSize', fontsize);
ylabel('$y(t)$ (Output)', 'Interpreter', 'latex', 'FontSize', fontsize);
legend('$y(t)$', 'Interpreter', 'latex', 'FontSize', fontsize-8);
title('Transformed Output $y(t)$ Over Time', 'Interpreter', 'latex', 'FontSize', fontsize);
grid off;
% Adjust Figure Appearance
ha1 = subplot(2,1,1);
ha1.FontSize = fontsize - 2;
ha1.LineWidth = 1;

ha2 = subplot(2,1,2);
ha2.FontSize = fontsize - 2;
ha2.LineWidth = 1;

% Define Save Paths
full_fun_path = which(mfilename('fullpath'));
path_name = fullfile(fileparts(full_fun_path), filesep);

savename_pdf = strcat(path_name, 'h2_p2c_gulumjanli.pdf');
savename_png = strcat(path_name, 'h2_p2c_gulumjanli.png');

% Export Graphics
exportgraphics(hf, savename_pdf);
exportgraphics(hf, savename_png);
