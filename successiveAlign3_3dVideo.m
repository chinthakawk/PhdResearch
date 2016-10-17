% 20160618
% successive icp

clear all; clc;

fol = 'C:\Users\Chinthaka\Desktop\03_calRtMats\alignFull\';
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

%%%%%%
cam = [1,2,3,4,5,7,8];
 
files = dir(strcat(fol, '*.ply'));
 
n1 = [];
n2 = [];
n3 = [];
n4 = [];
n5 = [];
n6 = [];
n7 = [];
n8 = [];
 
for f = 1:numel(files)
    name = files(f).name;
    if str2double(name(1))==1
        n1 = [n1; name];
    elseif str2double(name(1))==2
        n2 = [n2; name];
    elseif str2double(name(1))==3
        n3 = [n3; name];
    elseif str2double(name(1))==4
        n4 = [n4; name];
    elseif str2double(name(1))==5
        n5 = [n5; name];
    elseif str2double(name(1))==6
        n6 = [n6; name];
    elseif str2double(name(1))==7
        n7 = [n7; name];
    elseif str2double(name(1))==8
        n8 = [n8; name];
    end
end
% end
 
%n = [n1 n2 n3 n4 n5 n6 n7 n8];

%%%%%%
for f = 1:numel(files)

    % 4t3
    load(strcat(fol,n4(f,1)));
    pcs = pc;
    clear pc;

    load(strcat(fol,n3(f,1)));
    pcr = pc;
    clear pc;

    n = size(pcs,1);
    pcst = (r4t3*pcs(:,1:3)') + repmat(t4t3,1,n);
    pcs = [pcst' pcs(:,4:6)];

    pcs = [pcs; pcr];
    clear pcst pcr;

    pc = pcs;
    save(strcat(fol,num2str(f),'4t3.mat'), 'pc');
    fMatToPlyWithRgbOneFile(fol,'4t3.mat');
    clear pc;

    % 43t2
    load(strcat(fol,n2(f,1)));
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
    load(strcat(fol,n1(f,1)));
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
    load(strcat(fol,n5(f,1)));
    pcs = pc;
    clear pc;

    load(strcat(fol,n6(f,1)));
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
    load(strcat(fol,n7(f,1)));
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
    load(strcat(fol,n8(f,1)));
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
end

fclose(fid);

fprintf('\ndone\n');