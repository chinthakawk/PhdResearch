% 20150406
% gradient plot

clc; clear all;

load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/08_3dGradinet/1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors.mat');
load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/08_3dGradinet/1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors_mag.mat');
load('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/08_3dGradinet/1_1545057_rgbd_oo_refined_nR_oP=0.15_pDs=7_pD=6.6753_sr_dis=0.001_4neighbors_angle.mat');
s = 1;
sf = .001; % quiver scale factor

figure;
colormap gray
hax1 = axes;
scatter3(hax1,pc(:,1),pc(:,2),pc(:,3),s,mag);
xlabel('x');
ylabel('y');
zlabel('z');
view(2);
colorbar;
axis equal;


figure;
hax4 = axes;
hold on;
color = colormap(jet(8));
%1
r = (angle(:,1)>pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)>pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(1,:),'MaxHeadSize',.002,'AutoScale','off');
%2
r = (angle(:,1)>pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(2,:),'MaxHeadSize',.002,'AutoScale','off');
%3
r = (angle(:,1)>pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)>pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(3,:),'MaxHeadSize',.002,'AutoScale','off');
%4
r = (angle(:,1)>pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(4,:),'MaxHeadSize',.002,'AutoScale','off');
%5
r = (angle(:,1)<pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)>pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(5,:),'MaxHeadSize',.002,'AutoScale','off');
%6
r = (angle(:,1)<pc(:,1)) & (angle(:,2)>pc(:,2)) & (angle(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(6,:),'MaxHeadSize',.002,'AutoScale','off');
%7
r = (angle(:,1)<pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)>pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(7,:),'MaxHeadSize',.002,'AutoScale','off');
%8
r = (angle(:,1)<pc(:,1)) & (angle(:,2)<pc(:,2)) & (angle(:,3)<pc(:,3));
quiver3(hax4,pc(r,1),pc(r,2),pc(r,3),...
    angle(r,1)*sf,angle(r,2)*sf,angle(r,3)*sf,...
    'color',color(8,:),'MaxHeadSize',.002,'AutoScale','off');

xlabel('x');
ylabel('y');
zlabel('z');
view(2);
colorbar;
axis equal;

