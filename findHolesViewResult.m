% 20160422
% plotting result of findHoles2

clc; clear all;

pcname = '/Users/mac/Documents/KinectData/102/Sica/K1f500/04_HoleFinding_neid=0.005/1_1841001_rgbd_Oo_refined_nR_oP=0.1_pDs=5_pD=4.6084_sr_dis=0.001_np=8_newd=0.001.mat';
probname = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160422_FindingHoles/neirad=0.05/prob.mat';

load(probname);
load(pcname);

res = ones(size(pc,1),1);
res(prob>.8)=0;

figure; 
scatter3(pc(:,1),pc(:,2),pc(:,3),1,pc(:,4:6)/255); 
view(2);
axis equal;

figure; 
scatter3(pc(:,1),pc(:,2),pc(:,3),1,[res res res]); 
view(2);
axis equal;

