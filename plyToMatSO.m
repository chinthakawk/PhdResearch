% 2015/11/18
% this file converts a given PLY file to a Mat file
% inputs: folder_name and file_name.ply
% outputs: x,y,z coordinates and r,g,b channels

clc; clear all;

path = 'folder_name';
name = 'file_namename.ply';
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

