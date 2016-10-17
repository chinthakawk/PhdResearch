% 20150104
% this file reads ply file and saves as a mat file
% 20151101
% updated for performance improvement

clc; clear all;
tic

path = '/Users/mac/Documents/LabPC_D/NCU/Research/Lab Presentations/36_20151113_Sem07_Mid/';
name = '1_Huy_20151017_1745441.ply';
fileName = strcat(path, name);

disp(fileName);

% tic
data = textread(fileName, '%s','delimiter', '\n');
data = data(15:length(data),1);
data = (cellfun(@(x) strread(x,'%s','delimiter',' '), data, 'UniformOutput', false));
% toc
% 
% tic
% data2 = dlmread(fileName, ' ', 14, 0);
% toc

% idx = 1;
% fid = fopen(fileName, 'r');
% while isempty(strfind(fgets(fid), 'end_header'))
%     idx = idx + 1;
% end
% fclose(fid);

if isempty(data{length(data)})
    data(length(data))=[];
    disp('empty')
end

% data = dlmread(filename, ' ', idx, 0);

% tic
for i = 1:length(data)
    pc(i, 1) = (str2double(cellstr(data{i,1}{1,1})));
    pc(i, 2) = (str2double(cellstr(data{i,1}{2,1})));
    pc(i, 3) = (str2double(cellstr(data{i,1}{3,1})));
    pc(i, 4) = (str2double(cellstr(data{i,1}{4,1})));
    pc(i, 5) = (str2double(cellstr(data{i,1}{5,1})));
    pc(i, 6) = (str2double(cellstr(data{i,1}{6,1})));
end
% toc
% tic
% pc = str2double([data{:}].');
% if size(pc,2)==7
%     pc = pc(1:end, 1:end-1);
% else
%     pc = pc(1:end, 1:end);
% end
% toc 
save(strcat(path,name(1:numel(name)-4),'.mat'), 'pc');

toc
% clear pc;
% clear data;
