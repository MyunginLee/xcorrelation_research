warning off; clear all; close all; clc;
%% Import video feature
observe = 35 * 30; % time * fame
num_db = 17;
for idx=1:num_db
    clear A R;
    % idx = 1;
    load(sprintf('feat/35s/v%d_histogram_diff.mat',idx));
    fv = X;
    clear X;
    %load('video/a1_keyframes.mat');
    
    %% import Audio feature: spectrum
    load(sprintf('feat/35s/a%d_spectrum.mat',idx));
    fa = ssq;
    fa_s = sum(ssq);
    clear ssq;

    %% import Audio feature: pitch
    load(sprintf('feat/35s/a%d_pitch.mat',idx));
    f0 = f0';
    %% import Interface feature
    % fi
    stack_v(idx,:) = fv(:);
    stack_a(idx,:) = fa_s(:);
    stack_f(idx,:) = f0(:);
    
    %% Compute correlations
  
    rnd = rand(1,observe);    
%     A = [fv' fa_s'];
    A = [fv' f0'];
%     A = [fv(1:observe)' fa_s(1:observe)' ];
%     R = corrcoef(A);
    [R, alp] = corr(A,'Type','Spearman');
    Rs(idx) = R(2,1);
    Alps(idx) = alp(2,1);
end
figure(1);
stem(Rs);


for i= 1:num_db
    for j= 1:num_db
%          tmp = corrcoef([stack_v(i,:)' , stack_a(j,:)']);
         [tmp, alpc] = corr([stack_v(i,:)' , stack_a(j,:)'],'Type','Spearman');
%          tmp = corrcoef([stack_v(i,:)' , stack_f(j,:)']);
%          [tmp, alpc] = corr([stack_v(i,:)' , stack_f(j,:)'],'Type','Spearman');
         xA(i,j) = tmp(2,1);       
         xAlpha(i,j) = alpc(2,1);
    end
end
% figure(2);
% heatmap(xA);
% title('Unsupervised Crosscorrelation Mapping'); 
% xlabel('Audio: Spectral Power'); % 33ms
% ylabel('Video: Interframe histogram difference');  % 30fps =  33ms
figure(2);
heatmap(xA);
title('Unsupervised Spearman Crosscorrelation Mapping'); 
xlabel('Audio: Spectral Power'); % 33ms
ylabel('Video: Interframe histogram difference');  % 30fps =  33ms

figure(3);
heatmap(xAlpha);
title('Unsupervised Spearman Crosscorrelation Alpha Mapping'); 
xlabel('Audio: Spectral Power'); % 33ms
ylabel('Video: Interframe histogram difference');  % 30fps =  33ms

% figure(4);
% [cmd, eigvals] = cmdscale(A);
% plot(Y(:,1),Y(:,2),'.');



% y - video
% x - audio

% figure(2)
% for idx=1:num_db
%     subplot(num_db,1,idx);
%     stem(stack_v(idx,:));
% end
% figure(3)
% for idx=1:num_db
%     subplot(num_db,1,idx);
%     stem(stack_a(idx,:));
% end

% figure(2)
% for idx=1:num_db
%     subplot(num_db*2,1,2*idx-1);
%     bar(stack_v(idx,:),"red");
%     subplot(num_db*2,1,2*idx);
%     bar(stack_a(idx,:),"blue");
% end
% 
