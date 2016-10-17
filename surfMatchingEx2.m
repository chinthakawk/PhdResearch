% function match_test()
% 20160225: try to align clouds based on surf features

close all;
clear;
 
% surfnum = 1:30;
img0 = '/Volumes/Chin_HD2/Shared/102/20160218/Ankha2/01/08_RGB/1_1655347.jpg';
img1 = '/Volumes/Chin_HD2/Shared/102/20160218/Ankha2/01/08_RGB/2_1653370.jpg';

I1 = rgb2gray(imread(img0));
I2 = rgb2gray(imread(img1));

points1 = detectSURFFeatures(I1);
points2 = detectSURFFeatures(I2);

[f1, vpts1] = extractFeatures(I1, points1);
[f2, vpts2] = extractFeatures(I2, points2);

indexPairs = matchFeatures(f1, f2) ;
matchedPoints1 = vpts1(indexPairs(:, 1));
matchedPoints2 = vpts2(indexPairs(:, 2));

figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2,'montage');
legend('matched points 1','matched points 2');
   