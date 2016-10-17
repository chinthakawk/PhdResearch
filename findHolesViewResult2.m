% 20160422
% plotting result of findHoles2

clc; clear all;

pcname = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/14_findHolesWithAllCriteria_20160425/1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_np=8.mat';

fol = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/15_findNFillSmallHoles_20160429/neid=0.002_20160429/1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_np=8.mat_';

load(pcname);

neirad = 0.002; % radius of neighbors sphere
n = 11; % no of nearest neighbors
neico = zeros(size(pc,1),1); % to save the neighbors

% figure;
% scatter3(pc(:,1),pc(:,2),pc(:,3),1,pc(:,4:6)/255);
% axis equal;
% view(2);
% hold on;

load(strcat(fol,'angle.mat'));
load(strcat(fol,'halfdisk.mat'));
load(strcat(fol,'boundary.mat'));

prob = zeros(size(pc,1),1);
wangle = 1/3;
whalfdisk = 1/3;
wboundary = 1/3;

for i = 1:size(pc,1)
    prob(i) = angle(i)*wangle + halfdisk(i)*whalfdisk +...
        boundary(i)*wboundary;
end

res = zeros(size(pc,1),1);
res(prob>.6)=1;

figure;
scatter3(pc(:,1),pc(:,2),pc(:,3),1,~[res res res]); 
view(2);
axis equal;

fprintf('\nno. of boundary points: %d\n', sum(res));

[j,d] = knnsearch(pc(:,1:3),pc(:,1:3),'K',n); % neighbors and distances
j = j(:,2:end);
d = d(:,2:end);

res2 = res;

for i = 1:size(pc,1)
    jj = j(i,:);
    dd = d(i,:);
    
    di = find(dd>neirad); % neighbors outside the sphere
    
    jj(di) = [];
    dd(di) = [];
    neico(i,1) = numel(dd);
    if neico(i,1)<8
        res2(i,1) = 0;
    end
end

fprintf('\nno. of boundary points: %d\n', sum(res2));

figure;
scatter3(pc(:,1),pc(:,2),pc(:,3),1,~[res2 res2 res2]); 
view(2);
axis equal;

res3 = ~xor(res,res2);
fprintf('\nno. of boundary points: %d\n', sum(~res3));

figure;
scatter3(pc(:,1),pc(:,2),pc(:,3),1,[res3 res3 res3]); 
view(2);
axis equal;

% figure;
% hs(1) = subplot(1,3,1);
% hs(2) = subplot(1,3,2);
% hs(3) = subplot(1,3,3);
% % hs(4) = subplot(1,4,4);
% 
% res1 = ones(size(pc,1),1);
% res1(prob>.6)=0;
% fprintf('\nno. of boundary points: %d\n', sum(~res1));
% 
% scatter3(hs(1),pc(:,1),pc(:,2),pc(:,3),1,[res1 res1 res1]); 
% view(hs(1),2);
% % axis equal;
% axis(hs(1),'equal');
% 
% res2 = ones(size(pc,1),1);
% res2(prob>.6667)=0;
% fprintf('\nno. of boundary points: %d\n', sum(~res2));
% 
% scatter3(hs(2),pc(:,1),pc(:,2),pc(:,3),1,[res2 res2 res2]); 
% view(hs(2),2);
% % axis equal;
% axis(hs(2),'equal');

% res3 = ~xor(res1,res2);
% % res3 = ones(size(pc,1),1);
% % res3(prob>.65)=0;
% fprintf('\nno. of boundary points: %d\n', sum(~res3));
% 
% scatter3(hs(3),pc(:,1),pc(:,2),pc(:,3),1,[res3 res3 res3]); 
% view(hs(3),2);
% % axis equal;
% axis(hs(3),'equal');

% res4 = res1 - res2;
% 
% scatter3(hs(4),pc(:,1),pc(:,2),pc(:,3),1,[res4 res4 res4]); 
% view(hs(4),2);
% axis equal;

