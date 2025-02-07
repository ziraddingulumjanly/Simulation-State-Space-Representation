%% Modal Analysis of a State-Space System
%% Ziraddin Gulumjanli 2025

clear; clc; close all;

%System matrices
A = [-4 -3; 1 0];
B = [3; 0];
C = [0 1];
D = 0;

%(a) Compute the eigenvalues and eigenvectors of A
[V, Lambda] = eig(A);  
disp(['Please not that these calculations are based on normalized eigenvectors']);
disp(["while the pdf version contains results based on raw eigenvector values"])
disp('Eigenvalues of A:');
disp(diag(Lambda));
disp('Eigenvectors of A (normalized):');
disp(V);

% (b) Modal canonical form of the system.
% The transformation matrix T is taken to be the matrix of eigenvectors.
T = V;
T_inv = inv(T);
A_modal = T_inv * A * T;
B_modal = T_inv * B;
C_modal = C * T;
disp('Modal system matrices:');
disp('A_modal = ');
disp(A_modal);
disp('B_modal = ');
disp(B_modal);
disp('C_modal = ');
disp(C_modal);

% (c) State transition matrix of the modal system.
%   Phi_modal(t) = exp(A_modal*t) = diag(exp(-1*t), exp(-3*t))
syms t
lambda1 = Lambda(1,1);
lambda2 = Lambda(2,2);
Phi_modal = [exp(lambda1*t) 0; 0 exp(lambda2*t)];
disp('State transition matrix of the modal system:');
disp(Phi_modal);

% (d) State transition matrix of the original system.
%   Phi(t) = T * Phi_modal(t) * T_inv
Phi_original = simplify(T * Phi_modal * T_inv);
disp('State transition matrix of the original system:');
disp(Phi_original);

