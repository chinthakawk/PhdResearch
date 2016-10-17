% 20160416
% finding holes in point clouds

tic;

clc, clear all;

fol = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/13_findHoles/';
name = '1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors.mat';

n = 6; % no of neighbors selected for normal calculation

load(strcat(fol,name));

holes = pc;
holes(:,4) = 0;
holes(:,5) = 0;
holes(:,6) = 0;

for i = 1:size(pc,1)
% for i = 1:1
    fprintf('\n%d',i);
    p1 = pc(i,1:3);
    [r,d] = knnsearch(pc(:,1:3),p1,'K',n);
%     fprintf('\n--');
%     for j=1:numel(r)
%         fprintf('\n%d\t%f',r(j),d(j));
%     end
    if min(d)>0.001
        holes(i,4:6) = [255 0 0];
    end
end

scatter3(pc(:,1),pc(:,2),pc(:,3),1,pc(:,4:6)/255);