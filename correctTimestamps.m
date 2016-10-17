% 20161012
% correct timestamps

img = imread('E:\Shared\519\20161003\nick\01_all\1_1439488.jpg');
img = flipdim(img,2);
imshow(img);

% cc = round(ginput(2));

img = img(cc(1,2):cc(2,2),cc(1,1):cc(2,1));

imshow(img);

img = im2bw(img);

imshow(img);

s = regionprops(imcomplement(img));

for k = 1 : length(s)
    bb = s(k).BoundingBox;
    bba = s(k).Area;
%   rectangle('Position', [bb(1),bb(2),bb(3),bb(4)],...
%   'EdgeColor','r','LineWidth',2 )
    if bba<1000
        img(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3))=1;
    end
%     img(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3),2)=255;
%     img(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3),3)=255;
    
%     img1 = imresize(img1, [100 100]);
%     imshow(img1);
end
% s([s.Area] < 1000) = [];
imshow(img);
s = regionprops(imcomplement(img));

% Now we draw each bounding box on the image.
imshow(img);
name2 = '';
for k = 1 : length(s)
    bb = s(k).BoundingBox;
%   rectangle('Position', [bb(1),bb(2),bb(3),bb(4)],...
%   'EdgeColor','r','LineWidth',2 )
    img1 = img(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3));
    img1 = imresize(img1, [100 100]);
%     figure;imshow(img1);
%     fprintf('\n%d:',k);
    
    minv = 0;
    minn = 11;
    for i=1:10
        num = imread(strcat('E:\Matlab\Numbers\',num2str(i-1),'.bmp'));
%         dif = sum(sum(img1-num));
        dif = sum(sum(img1 & num));
        if dif>minv
            minv = dif;
            minn = i-1;
        end
%         fprintf('\t%d',dif);
    end
    fprintf('\t%d',minn);
    name2 = strcat(name2,num2str(i-1)); 
end