% 20150104
% this file reads ply file and saves as a mat file
% 20151101
% updated for performance improvement

clc; clear all;

path = '/Users/mac/Documents/MATLAB/Research/NoiseRemoval/';
name = '1_2226301.ply';
filename = strcat(path, name);

disp(filename);

fid = fopen(filename);
data = textscan(fid, '%s', 'delimiter', '\n');
idx = find(cellfun(@isempty, strfind(data{1}, 'end_header')) == 0);
fclose(fid);

if isempty(data{length(data)})
    data(length(data))=[];
%     idx2 = length(data);
%     pc = dlmread(filename, ' ', [idx 0 idx2 6]);
    disp('empty')
% else
%     pc = dlmread(filename, ' ', idx, 0);
end

pc = str2double([data{:}].');

% pc = dlmread(filename, ' ', idx:idx2, 0);
% pc = pc(:,1:6);

% save(strcat(path,name(1:numel(name)-4),'.mat'), 'pc');

% clear pc;
% clear data;
