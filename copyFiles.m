% 20151029
% copy files

clear all;
clc;

fol1 = '/Users/mac/Documents/LabPC_D/KinectData/20150624_Joke/';
fol3 = '/Users/mac/Documents/LabPC_D/KinectData/20150624_Joke_All/';

d = dir(fol1);
isub = [d(:).isdir]; %# returns logical vector
fol1Fol = {d(isub).name}';

fol1Fol(ismember(fol1Fol,{'.','..'})) = [];

for i = 1:numel(fol1Fol)
    disp(fol1Fol{i});
    fol2Files = dir(strcat(fol1, fol1Fol{i},'/*.ply'));
    for j = 1:numel(fol2Files)
%         disp(strcat(fol1, fol1Fol{i},'/',fol2Files(j).name));
        movefile(strcat(fol1, fol1Fol{i},'/',fol2Files(j).name),...
        strcat(fol3, fol2Files(j).name));
    end
end