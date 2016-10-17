% 20151130
% how to remove the noises in the clouds, can we try with eucledian
% change the density parameter based on the z value
% 20150117: changed to use static point density pD

clear all;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Hannibal/01/05_f1_nr/';
fol2 = fol;
name = 'Chin_21435687.mat';
oP = 0.05;

file = strcat(fol, name);
    
load(strcat(fol, name));

[b, pD] = fNoiseRemovalPointDensityCal(fol, name, oP);

fprintf('\nb=%f',b);

p = 1;

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

    [r, c] = find(pc(:,1)>xl & pc(:,1)<xh & pc(:,2)>yl & pc(:,2)<yh & pc(:,3)>zl & pc(:,3)<zh); 

%     pD = (1 - (z-zmin)/zmax)*pDs;

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
    '_pD=',num2str(pD),'_b=',num2str(b),'_static.mat'),'pc');

pc = pct;
pc(noise,:) = [];
    
save(strcat(fol2,name(1:numel(name)-4),'-nR_oP=',num2str(oP),...
    '_pD=',num2str(pD),'_b=',num2str(b),'.mat'),'pc');
clear pc noise;
fprintf('\n');
