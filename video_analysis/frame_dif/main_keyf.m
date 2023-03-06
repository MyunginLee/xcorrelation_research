
clc;
clear all;
% V = 'clip/00_violin_40s.mp4';      %Video Name 

for idx = 1:14

V = sprintf('../../00_db/35s/%d.mp4',idx);
% V = 'clip/test_vid.mp4';      %Video Name 
%V = 'clip/02_flux.mp4';      %Video Name 
xyloObj = VideoReader(V);   %Using video reader reading video

   %Extracting frames
%    T= xyloObj.NumberOfFrames            % Calculating number of frames
%    T= 390;            %  only 13 seconds 
   T= 30*35;            %  only 13 seconds 
   iskeyframe = zeros(T,1);
   for g=1:T
           p=read( xyloObj,g);          % Retrieve data from video
           if(g~=  xyloObj.NumberOfFrames)
                 J=read( xyloObj,g+1);
                 th=difference(p,J);        %To calculate histogram difference between two frames 
                 X(g)=th;
           end
   end
   %calculating mean and standard deviation and extracting frames
   mean=mean2(X)
   std=std2(X)
   threshold=std+mean*4
   for g=1: T
       p =  read(xyloObj,g);
       if(g~=xyloObj.NumberOfFrames)
        J=   read(xyloObj,g+1);
        th=difference(p,J);
        if(th>mean)    % Greater than threshold select as a key frame
            iskeyframe(g,1) = 1;

%mkdir('Keyframes')
%filename = fullfile('Keyframes', sprintf('frame_%05d.JPG', g));   %Writing the keyframes
%imwrite(J, filename);
            
                
       end 
       end
   end
save(sprintf('../../99_cross_coeff/feat/35s/v%d_histogram_diff.mat',idx), 'X') % 1 2 ..
save(sprintf('../../99_cross_coeff/feat/35s/v%d_keyframes.mat',idx), 'iskeyframe')
%  
end