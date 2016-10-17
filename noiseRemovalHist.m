% 20150611
% how to remove the noises in the clouds, can we try with eucledian
% distance method

clear all;

fol = 'D:\KinectData\20150606\All3\Aligned\RotatedAroundXBy45\AlignedToZ\MovedToOrigin\';
fol2 = 'D:\KinectData\20150606\All3\Aligned\RotatedAroundXBy45\AlignedToZ\MovedToOrigin\NoiseRemovedHistBased\';

files = dir(strcat(fol, '*.mat'));

for f = 1:numel(files)
    name = files(f).name;
    fileName = strcat(fol, name);
    disp(fileName);

    load(fileName);
    
%     2>=color>=253. 
    [r, c] = find(pc(:,4:6)>=253 | pc(:,4:6)<=2);
    pc(r,:) = [];
    
    save(strcat(fol2,name(1:numel(name)-3),'_histNoiseRemvoed.mat'),'pc');
    clear pc noise;
    
end

% save(strcat(fol,file(1:numel(file)-3),'_dis.mat'),'pc');
