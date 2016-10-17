% 20160322
% read rgb-d text file and save as a mat for analysis

clc, clear all;

fid = fopen('/Users/mac/Documents/NCU/Research/Progress Presentations/20160321/02_RgbF1/K1/1_1545057_rgbd.txt');
% C = textscan(fid, '%s%s%f32%d8%u%f%f%s%f');
C = textscan(fid,['%f: (rd,cd)=(%f, %f) d=%f (x,y,z)=(%f, %f, %f) ',...
    '(rc,cc)=(%f, %f) (r,g,b)=(%f, %f, %f)'],'TreatAsEmpty',{'-Infinity'});
fclose(fid);

c = cell2mat(C);