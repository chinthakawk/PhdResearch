% 20150624
% 3D video creation

clear all;

% fol = 'D:\KinectData\20150606\All3\Aligned\';
fol = 'D:\KinectData\20150606\All3\Aligned\RotatedAroundXBy45\AlignedToZ\MovedToOrigin\NoiseRemovedHistBased\';

s = 1;
pS = 1;

figure;
% hold on;
writerObj = VideoWriter(strcat(fol,'KolisVideo6.avi'));
writerObj.FrameRate = 4;
open(writerObj);

% az = -180;
% el = -90;
az = 0;
el = 0;

for i = 1:23
% for i = 1:1
%     clf('reset');
%     load(strcat(fol, num2str(i), '.mat'));
    load(strcat(fol, num2str(i), '._histNoiseRemvoed.mat'));
    scatter3(pc(1:s:size(pc,1),1), pc(1:s:size(pc,1),2), pc(1:s:size(pc,1),3),pS,pc(1:s:size(pc,1),4:6)/255,'filled');
    axis equal;
%     xlabel('x'); ylabel('y'); xlabel('x');
    axis off;
%     xlim([1 -.4]);
%     ylim([-1.2 .8]);
%     view(-180, -80);
    view(az, el);
    drawnow;
    f = getframe;
    fi = frame2im(f);
    writeVideo(writerObj,fi);
    clear pc;
    az = az + 20;
%     el = el + 5;
end

close(writerObj);