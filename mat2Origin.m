% 20150625
% this file finds the mean of a cloud and moves the cloud to the origin

clear all;

fol = 'D:\KinectData\20150606\All3\Aligned\RotatedAroundXBy45\AlignedToZ\';
fol2 = 'D:\KinectData\20150606\All3\Aligned\RotatedAroundXBy45\AlignedToZ\MovedToOrigin\';

for i = 1:23
    load(strcat(fol, num2str(i), '.mat'));
    M = pc(:,1:3);
    mm = mean(M,2);
    MShifted = [M(1,:)-mm(1); M(2,:)-mm(2); M(3,:)-mm(3)];
    pc = [M, pc(:,4:6)];
    save(strcat(fol2,num2str(i),'.mat'),'pc');
end

disp('Done');
    