% 20160618
% successive icp

clear all; clc;

fol = '/Volumes/Chin_HD2/Shared/102/20160218/Ankha2/01/14_mf_successiveAlign/';
folmat = 'C:\Users\Chinthaka\Desktop\03_calRtMats\findMats\mats2\';

fid = fopen(strcat(fol,'log_',datestr(now,'yyyymmddHHMM'),'.txt'),'w');
fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol = %s',fol);
fprintf(fid,'\nfolmat = %s',folmat);

fprintf(fid,'\n\ntransformation matrices');

files = dir(strcat(folmat, '*.mat'));
for f = 1:numel(files)
    name = files(f).name;
    load(strcat(folmat, name));
end

% 4t3
load(strcat(fol,'4.mat'));
pcs = pc;
clear pc;

load(strcat(fol,'3.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r4t3*pcs(:,1:3)') + repmat(t4t3,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

pc = pcs;
save(strcat(fol,'4t3.mat'), 'pc');
fMatToPlyWithRgbOneFile(fol,'4t3.mat');
clear pc;

% 43t2
load(strcat(fol,'2.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r3t2*pcs(:,1:3)') + repmat(t3t2,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

pc = pcs;
save(strcat(fol,'43t2.mat'), 'pc');
fMatToPlyWithRgbOneFile(fol,'43t2.mat');
clear pc;

% 432t1
load(strcat(fol,'1.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r2t1*pcs(:,1:3)') + repmat(t2t1,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

pc = pcs;
save(strcat(fol,'432t1.mat'), 'pc');
fMatToPlyWithRgbOneFile(fol,'432t1.mat');
clear pc;

pcrs = pcs;

% other side
% 5t6
load(strcat(fol,'5.mat'));
pcs = pc;
clear pc;

load(strcat(fol,'6.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r5t6*pcs(:,1:3)') + repmat(t5t6,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

pc = pcs;
save(strcat(fol,'5t6.mat'), 'pc');
fMatToPlyWithRgbOneFile(fol,'5t6.mat');
clear pc;

% 56t7
load(strcat(fol,'7.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r6t7*pcs(:,1:3)') + repmat(t6t7,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

pc = pcs;
save(strcat(fol,'56t7.mat'), 'pc');
fMatToPlyWithRgbOneFile(fol,'56t7.mat');
clear pc;

% 567t8
load(strcat(fol,'8.mat'));
pcr = pc;
clear pc;

n = size(pcs,1);
pcst = (r7t8*pcs(:,1:3)') + repmat(t7t8,1,n);
pcs = [pcst' pcs(:,4:6)];

pcs = [pcs; pcr];
clear pcst pcr;

pc = pcs;
save(strcat(fol,'567t8.mat'), 'pc');
fMatToPlyWithRgbOneFile(fol,'567t8.mat');
clear pc;

% 5678t1
% load(strcat(fol,'1.mat'));
% pcr = pc;
% clear pc;

n = size(pcs,1);
pcst = (r8t1*pcs(:,1:3)') + repmat(t8t1,1,n);
pcls = [pcst' pcs(:,4:6)];

pc = [pcls; pcrs];
save(strcat(fol,'4321n56781.mat'), 'pc');
fMatToPlyWithRgbOneFile(fol,'4321n56781.mat');
clear pc;


fclose(fid);

fprintf('\ndone\n');