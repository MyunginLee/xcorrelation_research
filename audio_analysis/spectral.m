clear, close all, clc

%x5 = audioread('01_thresh.wav');
%x5info = audioinfo('01_thresh.wav');
x5 = audioread('02_flux.wav');
x5info = audioinfo('02_flux.wav');

[sn5,fn5,tn5] = ...
   spectrogram(x5,1024,512,1024,x5info.SampleRate);

figure('Position',[50 200 800 300],...
   'Color',[1 1 1])
pcolor(tn5,fn5,log(abs(sn5))), shading flat
set(gca,'YLim',[0 16000])
title('Evolutionary Power Spectrum')
ylabel('Frequency (Hz)')
xlabel('Time (s)')
caxis([-5 2])
c = colorbar;
c.Label.String = 'Power (dB)';
subplot(411);

M = 2048;
g = hann(M,"periodic");
L = floor(0.281*M); %% golden number!!!!!!!!
Ndft = 2048;
[st,ft,tt] = stft(x5,Window=g,OverlapLength=L,FFTLength=Ndft,FrequencyRange="onesided");
ssq = abs(st); % or st^2
mesh(tt,ft, log(ssq));
view(2), axis tight
ylim([0 0.5])
subplot(412);

%% derive sparseness/variance of each frequency bins
i = 1;
vara = var(ssq);
%vara = zeros(M/2+1);
%while(i< M/2+1 +1)
%   vara(i) = var(i,:);
%end
stem(vara);
subplot(413);


summ = sum(sn5);
stem(summ);
subplot(414);

%mkdir('00_features')
%save('00_features/01_spectrum.mat', 'ssq')
%save('00_features/02_spectral_variance.mat', 'vara')

save('../cross_coeff/feat/a2_spectrum.mat', 'ssq')
save('../cross_coeff/feat/a2_spectral_variance.mat', 'vara')


