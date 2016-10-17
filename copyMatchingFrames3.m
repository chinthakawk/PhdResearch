% 2016/06/25
% copy files

fol = 'E:\Shared\519\20160727\Chinthaka\01_Extracted\';
fol2 = 'E:\Shared\519\20160727\Chinthaka\03_MatchingFrames\';

% % matching frames input (Den set1)
% mf = [56 51 5 65 27 34 65 57];

% % matching frames input (Den set2)
% mf = [160 152 115 170 133 150 171 162];
% mf = mf-100;

% % matching frames input (Ankhaa2)
% mf = [7	5 3	3 1 5 5 4];

% matching frames input (nick)
mf = [7	5 3	3 1 5 5 4];

fid = fopen(strcat(fol,'log_',datestr(now,'yyyymmddHHMM'),'.txt'),'w');
fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol = %s',fol);
fprintf(fid,'\nfol2 = %s',fol2);

fprintf(fid,'\n\nmatching frame IDs input (K1 to K8)');
fprintf(fid,'\n\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d',mf);

while min(mf)>1
    mf = mf-1;
    fprintf('\n\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d',mf);
end

fprintf(fid,'\n\nstarting matching frames (K1 to K8)');
fprintf(fid,'\n\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d',mf);

% get files names

filest = dir(strcat(fol, '1_*.jpg'));
filesNames = {filest.name};
[~,idx] = sort(filesNames);
filest = filest(idx);
files = {filest.name}';
clear filesNames idx;

filest = dir(strcat(fol, '2_*.jpg'));
filesNames = {filest.name};
[~,idx] = sort(filesNames);
filest = filest(idx);
files = [files {filest.name}'];
clear filesNames idx;

filest = dir(strcat(fol, '3_*.jpg'));
filesNames = {filest.name};
[~,idx] = sort(filesNames);
filest = filest(idx);
files = [files {filest.name}'];
clear filesNames idx;

filest = dir(strcat(fol, '4_*.jpg'));
filesNames = {filest.name};
[~,idx] = sort(filesNames);
filest = filest(idx);
files = [files {filest.name}'];
clear filesNames idx;

filest = dir(strcat(fol, '5_*.jpg'));
filesNames = {filest.name};
[~,idx] = sort(filesNames);
filest = filest(idx);
files = [files {filest.name}'];
clear filesNames idx;

filest = dir(strcat(fol, '6_*.jpg'));
filesNames = {filest.name};
[~,idx] = sort(filesNames);
filest = filest(idx);
files = [files {filest.name}'];
clear filesNames idx;

filest = dir(strcat(fol, '7_*.jpg'));
filesNames = {filest.name};
[~,idx] = sort(filesNames);
filest = filest(idx);
files = [files {filest.name}'];
clear filesNames idx;

filest = dir(strcat(fol, '8_*.jpg'));
filesNames = {filest.name};
[~,idx] = sort(filesNames);
filest = filest(idx);
files = [files {filest.name}'];
clear filesNames idx filest name;

% copying matching files

fprintf(fid,'\n\nmatching frames (K1 to K8)');

i = 0;
% while max(mf)<=size(files,1)
while i<30
    i = i+1;
    fprintf('\n%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d',i,mf);

    fprintf(fid,'\n%d',i);
    for j = 1:8
        fprintf(fid,'\t%d',mf(j));
        name = files{mf(j),j};
        fprintf(fid,'\t%s',name(1:9));
        
        % copy jpg
        file = strcat(fol, name);
        file2 = strcat(fol2, name);
        copyfile(file,file2);
        
        % copy txt
        file = strcat(fol, name(1:numel(name)-3), 'txt');
        file2 = strcat(fol2, name(1:numel(name)-3), 'txt');
        copyfile(file,file2);
        
        % copy ply
        file = strcat(fol, name(1:numel(name)-4), '_rgbd.ply');
        file2 = strcat(fol2, name(1:numel(name)-4), '_rgbd.ply');
        copyfile(file,file2);
        
        % copy relations
        file = strcat(fol, name(1:numel(name)-4), '_rgbd.txt');
        file2 = strcat(fol2, name(1:numel(name)-4), '_rgbd.txt');
        copyfile(file,file2);
    end
    mf = mf+1;
end

fclose(fid);

fprintf('\ndone\n');