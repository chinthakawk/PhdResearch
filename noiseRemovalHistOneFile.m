% 20150611
% how to remove the noises in the clouds, can we try histogram

clear all;

fol = '/Users/mac/Documents/MATLAB/Research/NoiseRemoval/';

name = '1_2226301_Oo.mat';
fileName = strcat(fol, name);
disp(fileName);

load(fileName);
    
[r, c] = find(pc(:,4:6)>=253 | pc(:,4:6)<=2);
pc(r,:) = [];
    
save(strcat(fol,name(1:numel(name)-4),'_histNoiseRemvoed.mat'),'pc');
clear pc noise;
