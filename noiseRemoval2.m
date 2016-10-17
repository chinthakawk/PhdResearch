% 20150611
% how to remove the noises in the clouds, can we try with eucledian
% distance method

clear all;

fol = 'D:\KinectData\20150606\All3\';
file = '6_9181_objectOnly2.mat';
load(strcat(fol, file));

for i = 1:size(pc,1)
%     disp(i);sie
    dMin = Inf;
    for j = 1:size(pc,1)
        if i ~= j
%             d = pdist([pc(i,1:3); pc(j,1:3)],'euclidean');
            d = pdist2(pc(i,1:3); pc(j,1:3)],'euclidean');
%             d = nthroot((pc(i,1)-pc(j,1))^2 + (pc(i,2)-pc(j,2))^2 + (pc(i,3)-pc(j,3))^2, 3);
            if d<dMin
                dMin = d;
                jMin = j;
            end
        end
    end
    pc(i,7) = dMin;
    pc(i,8) = jMin;
    fprintf('\n%d: dMin = %f\tjMin = %d', i, dMin, jMin);
end

save(strcat(fol,file(1:numel(file)-3),'_dis.mat'),'pc');
