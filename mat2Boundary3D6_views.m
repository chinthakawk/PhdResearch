% 20150416
% this file creates boundary, bounded surface and displays both
% surface looks good, originals colors now can be applied
% for the paper purposes

clc;
clear all;

load('/Users/mac/Documents/KinectData/Lab2/20160129/Minnie/07_ManualICP/1234t5678_Nr/12345678_nR_oP=0.01_pD=26.mat');
% pc = dataAll;
pcOrg = pc;
pc = pc(:,1:3);

maxW = max(max(pc)-min(pc));
for i = 1:3
    pc(:,i)=.15+(pc(:,i)-min(pc(:,i)))*0.7/maxW;
end

% plot3(P(:,1),P(:,2),P(:,3),'.')

tri = boundary(pc,1);

% figure; % figure 1
% 
% trisurf(tri,pc(:,1),pc(:,2),pc(:,3),'FaceAlpha',.75,'Facecolor','red','EdgeColor','c');
% axis equal;
% view([-170 -70]);
% axis off;

% hSub1 = subplot(3,2,[1 3 5]);
% hSurf1 = trisurf(tri,pc(:,1),pc(:,2),pc(:,3),'FaceAlpha',.75,'Facecolor','red','EdgeColor','c');
% axis equal; grid on;
% xlabel('x'); ylabel('y'); zlabel('z');
% title('duck from 4 point clouds');
% view([-170 -70]);
% 
% hSub2 = subplot(3,2,2);
% copyobj(hSurf1,hSub2);
% axis equal; grid on;
% xlabel('x'); ylabel('y'); zlabel('z');
% xlim([.1 .6]); ylim([.1 .9]); zlim([.1 .5]);
% set(hSub2, 'xTick',.1:.1:.6,'yTick',.1:.1:.9);
% view([0 180]);
% 
% hSub3 = subplot(3,2,4);
% copyobj(hSurf1,hSub3);
% axis equal; grid on;
% xlabel('x'); ylabel('y'); zlabel('z');
% xlim([.1 .6]); ylim([.1 .9]); zlim([.1 .5]);
% set(hSub3, 'xTick',.1:.1:.6,'yTick',.1:.1:.9);
% view([0 90]);
% 
% hSub4 = subplot(3,2,6);
% copyobj(hSurf1,hSub4);
% axis equal; grid on;
% xlabel('x'); ylabel('y'); zlabel('z');
% xlim([.1 .6]); ylim([.1 .9]); zlim([.1 .5]);
% set(hSub4, 'xTick',.1:.1:.6,'yTick',.1:.1:.9);
% view([90 0]);

triP = unique(reshape(tri,[],1));

for i=1:size(tri,1)
    color(i,:) = ((pcOrg(tri(i,1),4:6)+pcOrg(tri(i,2),4:6)+pcOrg(tri(i,3),4:6))/3)/255;
end

clear cdata;
cdata = pcOrg(:,4:6)/255;

figure;

a = [0 90 180 270];
% el = [0 90 180 270];

for i = 1:16
%     subplot(4,4,i);
    figure;
    trisurf(tri,pc(:,1),pc(:,2),pc(:,3),'FaceVertexCData',...
        cdata,'FaceColor','interp','edgeColor','none');
    % hSurf2 = trisurf(tri,pc(:,1),pc(:,2),pc(:,3),'FaceVertexCData',cdata,'edgeColor','none');
    % surf(pc(triP,:), (pcOrg(triP,4:6))/255, 'FaceColor','interp','edgeColor','none');
    axis equal; %grid on;
    xlabel('x'); ylabel('y'); zlabel('z');
    az = a(idivide((i-1),int8(4))+1);
    el = a(mod((i-1),4)+1);
    disp([az el]);
    view([az el]);
    camup([0 1 0]);
    title(strcat('[',num2str(az),',',num2str(el),']'));
%     axis off;
end

% hSub6 = subplot(3,2,2);
% copyobj(hSurf2, hSub6);
% axis equal;
% % xlabel('x'); ylabel('y'); zlabel('z');
% xlim([.1 .6]); ylim([.1 .9]); zlim([.1 .5]);
% set(hSub6, 'xTick',.1:.1:.6,'yTick',.1:.1:.9);
% view([0 180]);
% axis off;
% 
% hSub7 = subplot(3,2,4);
% copyobj(hSurf2, hSub7);
% axis equal
% % xlabel('x'); ylabel('y'); zlabel('z');
% xlim([.1 .6]); ylim([.1 .9]); zlim([.1 .5]);
% set(hSub7, 'xTick',.1:.1:.6,'yTick',.1:.1:.9);
% view([0 90]);
% axis off;
% 
% hSub8 = subplot(3,2,6);
% copyobj(hSurf2, hSub8);
% axis equal; 
% % xlabel('x'); ylabel('y'); zlabel('z');
% xlim([.1 .6]); ylim([.1 .9]); zlim([.1 .5]);
% set(hSub8, 'xTick',.1:.1:.6,'yTick',.1:.1:.9);
% % view([90 0]);
% view([90 0]);
% axis off;

clear i maxW
