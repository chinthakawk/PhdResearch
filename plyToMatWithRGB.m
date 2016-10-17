% 20150104
% this file reads ply file and saves as a mat file

clc; clear all;

path = '/Users/mac/Documents/LabPC_D/KinectData/20150624_Joke/All/';
files = dir(strcat(path, '*.ply'));

for f = 1:numel(files)
    name = files(f).name;
    fileName = strcat(path, name);
    fprintf('\n%d\t%s',f,fileName);
    data = textread(fileName, '%s','delimiter', '\n');
    data = data(15:length(data),1);

    data = (cellfun(@(x) strread(x,'%s','delimiter',' '), data, 'UniformOutput', false));

    for i = 1:length(data)-1 % panda00
        pc(i, 1) = (str2double(cellstr(data{i,1}{1,1})));
        pc(i, 2) = (str2double(cellstr(data{i,1}{2,1})));
        pc(i, 3) = (str2double(cellstr(data{i,1}{3,1})));
        pc(i, 4) = (str2double(cellstr(data{i,1}{4,1})));
        pc(i, 5) = (str2double(cellstr(data{i,1}{5,1})));
        pc(i, 6) = (str2double(cellstr(data{i,1}{6,1})));
    end
    
    save(strcat(path,name(1:numel(name)-4),'.mat'), 'pc');
    clear pc;
    clear data;
end

fprintf('\nDone\n');