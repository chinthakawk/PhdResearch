% 20151130
% how to remove the noises in the clouds, can we try with eucledian
% change the density parameter based on the z value
% 20150119
% adaptive b and pDs values based on the cloud statistics

clear all;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Ankha2/01/12_mf_nr/';
fol2 = fol;
name = '8_1656062_oO_refined.mat';
oP = 0.05;

s = 1;
p = 1;

file = strcat(fol, name);
load(strcat(fol, name));

[b, pDs] = fNoiseRemovalPointDensityCal(fol, name, oP);

noise = [];
zmin = min(pc(:,3));
zmax = max(pc(:,3));

i = 1;
while i <= size(pc,1)
    x = pc(i,1);
    y = pc(i,2);
    z = pc(i,3);
    xl = x-b;
    xh = x+b;
    yl = y-b;
    yh = y+b;
    zl = z-b;
    zh = z+b;

    [r, c] = find(pc(:,1)>xl & pc(:,1)<xh & pc(:,2)>yl & pc(:,2)<yh &...
        pc(:,3)>zl & pc(:,3)<zh); 

    pD = (1 - (z-zmin)/zmax)*pDs;

    if numel(r)<pD
        noise = [noise; i];
    end

    if (mod(i,10000)==0)
        fprintf('%d ',i);
    end
    i = i+1;
end

pct = pc;

pc(:,4) = 255;
pc(:,5) = 255;
pc(:,6) = 0;
pc(noise,4) = 255;
pc(noise,5) = 0;
pc(noise,6) = 0;
    
save(strcat(fol2,name(1:numel(name)-4),'-nR_oP=',num2str(oP),...
    '_pDs=',num2str(pDs),'_pD=',num2str(pD),'_static.mat'),'pc');

pc = pct;
pc(noise,:) = [];

save(strcat(fol2,name(1:numel(name)-4),'-nR_oP=',num2str(oP),...
    '_pDs=',num2str(pDs),'_pD=',num2str(pD),'.mat'),'pc');

clear pc noise;
fprintf('\n');

