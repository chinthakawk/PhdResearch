% 20150104
% this file reads ply file and saves as a mat file
% 20151101
% updated for performance improvement

clc; clear all;

path = 'E:\Shared\519\20161003\nick\02_f1\';
files = dir(strcat(path, '*.ply'));

for f = 1:numel(files)
    name = files(f).name;
    fileName = strcat(path, name);
    fprintf('\n%d\t%s',f,fileName);

    if exist(strcat(fileName(1:numel(fileName)-3),'mat'), 'file')
        fprintf('\t exist');
        continue;
    end
    
    idx = 1;
    fid = fopen(fileName, 'r');
    while isempty(strfind(fgets(fid), 'end_header'))
        idx = idx + 1;
    end
    fclose(fid);
    
    data = textread(fileName, '%s','delimiter', '\n');
    data = data(idx+1:length(data),1);
    data = (cellfun(@(x) strread(x,'%s','delimiter',' '), data,...
        'UniformOutput', false));

    if isempty(data{length(data)})
        data(length(data))=[];
    end

    pc = str2double([data{:}].');
    pc = pc(:,1:6);

    save(strcat(path,name(1:numel(name)-4),'.mat'), 'pc');
    
    clear pc;
    clear data;
end

fprintf('\n');