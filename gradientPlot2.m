% 20150406
% gradient plot
% 20160407: corrected for negative octants

clc; clear all;

fol = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/11_3dGradinet_3dCubeCorrected_20160411/';
pcName = '1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors.mat';
magName = '1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors_3dGradient_mag_3x3.mat';
dirName = '1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors_3dGradient_dir_3x3.mat';

load(strcat(fol,pcName));
load(strcat(fol,magName));
load(strcat(fol,dirName));

ss = 1;     % scatter3 point size
sf = .001;  % quiver scale factor

mag = (mag-min(mag(:)))./(max(mag(:))-min(mag(:))); % normalize mag

colormap(gray);

% figure;
hax1 = axes;
scatter3(hax1,pc(:,1),pc(:,2),pc(:,3),ss,[mag mag mag]);
xlabel('x');
ylabel('y');
zlabel('z');
view(2);
title('3D Gradient - Magnitude');
colorbar;
axis equal;

figure;
hax4 = axes;
hold on;
color = colormap(jet(8));
%1
r = (dir(:,1)>=pc(:,1)) & (dir(:,2)>=pc(:,2)) & (dir(:,3)>=pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    dir(r,1)*sf,dir(r,2)*sf,dir(r,3)*sf,...
    'color',color(1,:),'MaxHeadSize',.002,'AutoScale','off');
%2
r = (dir(:,1)>=pc(:,1)) & (dir(:,2)>=pc(:,2)) & (dir(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    dir(r,1)*sf,dir(r,2)*sf,dir(r,3)*sf,...
    'color',color(2,:),'MaxHeadSize',.002,'AutoScale','off');
%3
r = (dir(:,1)>=pc(:,1)) & (dir(:,2)<pc(:,2)) & (dir(:,3)>=pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    dir(r,1)*sf,dir(r,2)*sf,dir(r,3)*sf,...
    'color',color(3,:),'MaxHeadSize',.002,'AutoScale','off');
%4
r = (dir(:,1)>=pc(:,1)) & (dir(:,2)<pc(:,2)) & (dir(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    dir(r,1)*sf,dir(r,2)*sf,dir(r,3)*sf,...
    'color',color(4,:),'MaxHeadSize',.002,'AutoScale','off');
%5
r = (dir(:,1)<pc(:,1)) & (dir(:,2)>=pc(:,2)) & (dir(:,3)>=pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    dir(r,1)*sf,dir(r,2)*sf,dir(r,3)*sf,...
    'color',color(5,:),'MaxHeadSize',.002,'AutoScale','off');
%6
r = (dir(:,1)<pc(:,1)) & (dir(:,2)>=pc(:,2)) & (dir(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    dir(r,1)*sf,dir(r,2)*sf,dir(r,3)*sf,...
    'color',color(6,:),'MaxHeadSize',.002,'AutoScale','off');
%7
r = (dir(:,1)<pc(:,1)) & (dir(:,2)<pc(:,2)) & (dir(:,3)>=pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    dir(r,1)*sf,dir(r,2)*sf,dir(r,3)*sf,...
    'color',color(7,:),'MaxHeadSize',.002,'AutoScale','off');
%8
r = (dir(:,1)<pc(:,1)) & (dir(:,2)<pc(:,2)) & (dir(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    dir(r,1)*sf,dir(r,2)*sf,dir(r,3)*sf,...
    'color',color(8,:),'MaxHeadSize',.002,'AutoScale','off');

xlabel('x');
ylabel('y');
zlabel('z');
view(2);
title('3D Gradient - Direction (Colored based on the octant (x,y,z))');
legend('+++','++-','+-+','+--','-++','-+-','--+','---');
colorbar;
axis equal;

fprintf('\n');