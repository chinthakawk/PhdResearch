% 20150728
% unzip all the PCs to one folder

fol = '/Users/mac/Documents/LabPC_D/KinectData/20150629/kolis_20150627/';
fol2 = strcat(fol, 'All/');

files1 = dir(fol);

for f1 = 4:numel(files1)
% % for f = 1:1
    name1 = files(f1).name;
    name2 = strcat(fol, name1,'/');
    fprintf('\n%d\t%s',f1-3,name2);
    
    files2 = dir(name2);
    for f2 = 3:numel(files2)
    	name3 = files2(f2).name;
    	name4 = strcat(name2, name3);
        fprintf('\n%d\t%s',f2-2,name4);
        unzip(name4,fol2);
    end
end