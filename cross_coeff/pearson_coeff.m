warning off; clear all; close all; clc;
%% Import video feature
load('feat/v2_histogram_diff.mat');
fv = X;
clear X;
%load('video/a1_keyframes.mat');

%% import Audio feature
load('feat/a2_spectrum.mat');
fa = ssq;
fa_s = sum(ssq);
clear ssq;

%% import Interface feature
% fi


%% Compute correlations

subplot(211);
stem(fv);
subplot(212);
stem(fa_s);
%subplot(312);
%stem(fa);

rnd = rand(1,1200);

A = [fv(1:1200)' fa_s(1:1200)' rnd'];
R = corrcoef(A)