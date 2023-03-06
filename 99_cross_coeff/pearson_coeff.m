warning off; clear all; close all; clc;
%% Import video feature
observe = 35 * 30; % time * fame
num_db = 14;
for idx=1:num_db
    clear A R;
    % idx = 1;
    load(sprintf('feat/35s/v%d_histogram_diff.mat',idx));
    fv = X;
    clear X;
    %load('video/a1_keyframes.mat');
    
    %% import Audio feature
    load(sprintf('feat/35s/a%d_spectrum.mat',idx));
    fa = ssq;
    fa_s = sum(ssq);
    clear ssq;
    
    %% import Interface feature
    % fi
    stack_v(idx,:) = fv(:);
    stack_a(idx,:) = fa_s(:);
    
    %% Compute correlations
  
    rnd = rand(1,observe);    
    A = [fv' fa_s'];
%     A = [fv(1:observe)' fa_s(1:observe)' ];
    R = corrcoef(A);
    Rs(idx) = R(2,1);
end
figure(1);
stem(Rs);


for i= 1:num_db
    for j= 1:num_db
         tmp = corrcoef([stack_v(i,:)' , stack_a(j,:)']);
         xA(i,j) = tmp(2,1);       
    end
end

heatmap(xA);
% y - video
% x - audio
audio 1 video 2
audio 2 video 1

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
