% 20151004
% test views

clear all;

file = '/Users/mac/Documents/LabPC_D/KinectData/20150629/kolis_20150627/All3Oo/Old/1526_1.mat';
load(file);
s = 1;

% az = -180;
% el = -90;
% 
% for i=0:7
% %     subplot(2,4,i);
%     for j=1:8
%         subplot(8,8,i*8+j);
%         scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),5,pc(1:s:size(pc,1),4:6)/255,'filled');
%         view(az, el);
% %       az = az + 45;
%         el = el + 45;
%         axis equal;
%     end
%     az = az+45;
% end

scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),5,pc(1:s:size(pc,1),4:6)/255,'filled');
axis equal;
view(-180,-90);
camorbit(-150,0,'camera',[0 1 0]);

file = '/Users/mac/Documents/LabPC_D/KinectData/20150629/kolis_20150627/All3Oo/Old/3748_1.mat';
load(file);

figure;
scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),5,pc(1:s:size(pc,1),4:6)/255,'filled');
axis equal;
view(-180,-90);
camorbit(30,0,'camera',[0 1 0]);
