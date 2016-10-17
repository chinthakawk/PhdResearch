
fol = 'E:\Matlab\Numbers\org\';

files = dir(strcat(fol, '*.png'));

for f = 1:numel(files)
% for f = 1:2
    name = files(f).name;
    img = imread(strcat(fol,name));
    imshow(img);
    
    img = im2bw(img);
    imshow(img);
    
    s = regionprops(imcomplement(img));

    s([s.Area] < 1000) = [];
    for k = 1 : length(s)
      bb = s(k).BoundingBox;
      img = img(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3));
%       rectangle('Position', [bb(1),bb(2),bb(3),bb(4)],...
%       'EdgeColor','r','LineWidth',2 )
    end
    imshow(img);
    img = imresize(img, [100 100]);
    imwrite(img,strcat(fol,name(1:numel(name)-4),'.bmp'));
end