% 20150104
% this file reads ply file and saves as a mat file

clc; clear;

% % bunny
% fileName = 'E:\NCU\Research\bunny\data\bun000.ply';
% data = textread(fileName, '%s','delimiter', '\n');
% data = data(25:length(data),1);

% panda00
path = '/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/';
name = '1_1545057_rgbd_Oo.ply';

fileName = strcat(path, name);
disp(fileName);
data = textread(fileName, '%s','delimiter', '\n');
data = data(15:length(data),1);

data = (cellfun(@(x) strread(x,'%s','delimiter',' '), data, 'UniformOutput', false));

j = 1;
for i = 1:length(data)-1 % panda00
% for i = 1:40256 % bunny
%         disp(i);
    pc(i, 1) = (str2double(cellstr(data{i,1}{1,1})));
    pc(i, 2) = (str2double(cellstr(data{i,1}{2,1})));
    pc(i, 3) = (str2double(cellstr(data{i,1}{3,1})));
%     pc(i, 4) = (str2double(cellstr(data{i,1}{4,1})));
%     pc(i, 5) = (str2double(cellstr(data{i,1}{5,1})));
%     pc(i, 6) = (str2double(cellstr(data{i,1}{6,1})));
%         j = j+1;
end

save(strcat(path,name(1:numel(name)-4),'.mat'), 'pc');
