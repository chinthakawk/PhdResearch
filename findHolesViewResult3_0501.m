% 20160422
% plotting result of findHoles2
% 20160501: compare holes and after filling small holes

clc; clear all;

pcname = '/Users/mac/Documents/KinectData/102/Den/K1f301/28_viewh_differentpara_20160521/1_1437348_rgbd_oo_refined-nR_oP=0.05_pDs=4_pD=3.8519-sr_dis=0.001_np=8-findHoles_neig#=21-fsh_newd=0.001-fshi_acc=3_cube=3.mat';

fol = '/Users/mac/Documents/KinectData/102/Den/K1f301/28_viewh_differentpara_20160521/1_1437348_rgbd_oo_refined-nR_oP=0.05_pDs=4_pD=3.8519-sr_dis=0.001_np=8-findHoles_neig#=21-fsh_newd=0.001-fshi_acc=3_cube=3-findsh_neig#=10_neirad=0.01_';
% fol2 = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321_RGBDvsPC/02_RgbF1/K1/15_findNFillSmallHoles_20160429/neid=0.002_fillSmallHoles_newd=0.001_20160501/';

load(pcname);

% neirad = 0.002; % radius of neighbors sphere
% n = 11; % no of nearest neighbors
% neico = zeros(size(pc,1),1); % to save the neighbors

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

pTh = .6;

res(prob>pTh)=1;

pc(prob>pTh,4) = 255;
pc(prob>pTh,5) = 0;
pc(prob>pTh,6) = 0;

save(strcat(fol,'-viewh_wangle=',num2str(wangle),',whalfdisk=',...
    num2str(whalfdisk),',wboundary=',num2str(wboundary),...
    ',pTh=',num2str(pTh),',boundarypoints#=',num2str(sum(res)),...
    '.mat'),'pc');

figure;
scatter3(pc(:,1),pc(:,2),pc(:,3),1,~[res res res]); 
view(2);
axis equal;

fprintf('\nno. of boundary points: %d\n', sum(res));


% % ==========
% % after filling small holes
% 
% pcname = '/Users/mac/Documents/KinectData/102/Sica/K1f500/04_HoleFinding_neid=0.005/1_1841001_rgbd_Oo_refined_nR_oP=0.1_pDs=5_pD=4.6084_sr_dis=0.001_np=8_newd=0.001.mat';
% 
% fol = '/Users/mac/Documents/KinectData/102/Sica/K1f500/04_HoleFinding_neid=0.005/1_1841001_rgbd_Oo_refined_nR_oP=0.1_pDs=5_pD=4.6084_sr_dis=0.001_np=8_newd=0.001_';
% 
% load(pcname);
% 
% load(strcat(fol,'angle.mat'));
% load(strcat(fol,'halfdisk.mat'));
% load(strcat(fol,'boundary.mat'));
% 
% prob = zeros(size(pc,1),1);
% wangle = 1/3;
% whalfdisk = 1/3;
% wboundary = 1/3;
% 
% for i = 1:size(pc,1)
%     prob(i) = angle(i)*wangle + halfdisk(i)*whalfdisk +...
%         boundary(i)*wboundary;
% end
% 
% res = zeros(size(pc,1),1);
% res(prob>.6)=1;
% 
% pc(prob>.6,4) = 255;
% pc(prob>.6,5) = 0;
% pc(prob>.6,6) = 0;
% save(strcat(fol,'afterFillSmallHoles.mat'),'pc');
% 
% figure;
% scatter3(pc(:,1),pc(:,2),pc(:,3),1,~[res res res]); 
% view(2);
% axis equal;
% 
% fprintf('\nno. of boundary points: %d\n', sum(res));