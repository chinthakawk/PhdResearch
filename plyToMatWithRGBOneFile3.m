% 20150104
% this file reads ply file and saves as a mat file
% 20151101
% updated for performance improvement

clc; clear all;
tic

path = '/Volumes/Chin_HD2/Shared/102/20160218/Hannibal/01/03_f1_oo/';
name = '8_1313411_oo.ply';
fileName = strcat(path, name);

disp(fileName);

idx = 1;
fid = fopen(fileName, 'r');
while isempty(strfind(fgets(fid), 'end_header'))
    idx = idx + 1;
end
fclose(fid);

data = textread(fileName, '%s','delimiter', '\n');
data = data(idx+1:length(data),1);
data = (cellfun(@(x) strread(x,'%s','delimiter',' '), data, 'UniformOutput', false));

if isempty(data{length(data)})
    data(length(data))=[];
end

pc = str2double([data{:}].');
pc = pc(:,1:6);

save(strcat(path,name(1:numel(name)-4),'.mat'), 'pc');

toc

% clear pc;
% clear data;
