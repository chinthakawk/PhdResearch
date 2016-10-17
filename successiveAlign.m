% 20160618
% successive icp

clear all; clc;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Ankha/set01/01/06_f1_successiveIcp/align/';
folmat = '/Volumes/Chin_HD2/Shared/102/20160218/Hannibal/01/09_surf/01_try2/rtmats/';

files = dir(strcat(folmat, '*.mat'));
for f = 1:numel(files)
    name = files(f).name;
    load(strcat(folmat, name));
end

% 8t7
load(strcat(fol,'8.mat'));
pcs = pc;
clear pc;

load(strcat(fol,'7.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r8t7*pcs(:,1:3)') + repmat(t8t7,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

% 87t6
load(strcat(fol,'6.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r7t6*pcs(:,1:3)') + repmat(t7t6,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

% 876t5
load(strcat(fol,'5.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r6t5*pcs(:,1:3)') + repmat(t6t5,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

% 8765t4
load(strcat(fol,'4.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r5t4*pcs(:,1:3)') + repmat(t5t4,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

% 87654t3
load(strcat(fol,'3.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r4t3*pcs(:,1:3)') + repmat(t4t3,1,n);
pcs = [pcst' pcs(:,4:6)];

pc = [pcs; pcr];
clear pcs pcst pcr;

save(strcat(fol,'876543.mat'), 'pc');

fprintf('\n');