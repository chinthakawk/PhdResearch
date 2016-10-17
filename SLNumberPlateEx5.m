% chinthakawk@gmail.com
% 20150212
% This file is to extract number of a SL number plate
% modified by nuwan on 2/14

clc;
clear all;

warning('off','all');

create_templates;

%delete all jpg file in write folder
delete('write/*.jpg')

% %Opens text.txt as file for write
fid = fopen('text.txt', 'wt');

% %Storage matrix word from image
word=[ ];

writepath='C:\Users\Acer\Desktop\Research Papers\Number Plates\SLNumberPlateExtraction_20141007\SLNumberPlateExtraction\Write';


% Load templates
load templates
global templates

% Compute the number of letters in template file
num_letras=size(templates,2);

imgDir = 'Cropped/cropped';
cd (imgDir);
r = dir;
pat='C:\Users\Acer\Desktop\Research Papers\Number Plates\SLNumberPlateExtraction_20141007\SLNumberPlateExtraction\Cropped\Cropped\';
for u=1:100
% for k = 3:21
    %fprintf('\n%d: [%s] ',k-2, r(k).name);
    
   % iOrg = imread(r(k).name);
    fprintf('[%.2f] ',u);
    iOrg = imread(strcat(pat,int2str(u),'.jpg'));
%     fprintf('[%d*%d] ', size(iOrg,1),size(iOrg,2));
    fprintf('[%.2f] ', size(iOrg,2)/size(iOrg,1));
   

    %rear plate images



% i1 = imread('Rear/SLR03.jpg');
%figure; imshow(i1),title('Original Image');


i2 = rgb2gray(iOrg);
% figure; imshow(i2),title('Gray Image');

%figure,imhist(i2),title('Before Equalize')
hei3 = histeq(i2);
%figure,imhist(hei3),title('After Equalize')
%figure,imshow(hei3),title('Histogram equalized Image')

%i3 = im2bw(i2, 0.4);
i3 = im2bw(hei3, 0.3);

%figure,imshow(i3),title('Binary Image');

i4 = imcomplement(i3);
 %figure; imshow(i4),title('complement image');

i5 = imclearborder(i4, 4);
% figure, imshow(i5), title('cleared border image');

%  originalBW = imread('circles.png');  
% se = strel('disk',1);        
% i6 = imerode(i5, se);
% % figure, imshow(i6),title('Eroded Image');
% 
% se90 = strel('line', 3, 90);
% se0 = strel('line', 3, 40);
% i7 = imdilate(i6, [se90 se0]);
% %figure, imshow(i7), title('dilated gradient mask');

%seD = strel('diamond',1);
%i8 = imerode(i7,seD);
% figure, imshow(i8), title('segmented image');

i9 = bwareaopen(i5, 200);
% figure; imshow(i9),title('i9');

clear i2;
clear i3;
clear i4;
clear i5;


 BW5 = imfill(i9,'holes');
%figure;imshow(BW5),title('BW5');

stats = regionprops(i9,'BoundingBox','Area','Centroid','Perimeter');


%show the y corrdinate profile of number plate
y=[];
x=[];
imstarty=[];
imstartx=[];

%select an image file number based on the given perimeter value
filenumber=[]; 
both=[];
for i=1:length(stats)
 center=stats(i).Centroid;
 box=stats(i).BoundingBox;
 
 imstarty=[imstarty box(2)];
 imstartx=[imstartx box(1)];
 y=[y center(2)];
 x=[x center(1)];
 
     %if((stats(i).Perimeter<175)||(stats(i).Perimeter>900))
     %else
         filenumber=[filenumber i];
        both=[both ; box(2) center(2) stats(i).Area box(1) center(1) stats(i).Perimeter  box(3) box(4)];
     %end
end
%title='     rectangle y |  centroid y    |  area   | rectangle x   |  centroid x  | Perimeter     |width   | Height' 

y;
imstarty;
%both


%stores the image of the number plate which marked the boundary rectangles
%in red color
rectMarkedImage=[];

%marks the rectangular boundary of Digits
for indexx=1:length(stats)
% r=rectangle('Position',stats(indexx).BoundingBox,'LineWidth',4);
% rr=rectangle('Position',[10 118 600 1]);
% set(rr,'edgecolor','y');

dim=size(i9);
% ml=rectangle('Position',[(dim(2)/2) 1 1 150]);
% %et(ml,'edgecolor','g');

%set(r,'edgecolor','r');
I2 = imcrop(i9,stats(indexx).BoundingBox);

% %marks the centroid coordinate
% y=rectangle('Position',[stats(indexx).Centroid 5 5]);
% 
% %set(y,'edgecolor','g');
%figure; imshow(I2);
imwrite(I2,strcat(writepath,int2str(indexx),'.jpg'),'jpg','Comment','My JPEG file');
% f = getframe(gca);
% rectMarkedImage = frame2im(f);
end

% % figure;imshow(rectMarkedImage)
% % figure;
% %This will shows the selected images in one window
% orderimages=figure;
% %movegui(orderimages,[750,250]);
% 
% set(orderimages, 'Position', [780 180 550 500])
% for ind=1:length(filenumber)
%     fn=filenumber(ind);
%     tm=imread(strcat('write/',int2str(fn),'.jpg'));
%     subplot(5,5,ind),imshow(tm);
% end
% 

%disp(length(stats));

%this will identify each subimage seperately
plateValue=Letterwise_Identify(length(stats));


%display only the selected images from the plateValue
plateReaded=plateValue(filenumber);
fprintf(plateReaded);
fprintf('--');
fprintf('\n');


    
end
    
fprintf('\n');

imgDir = 'C:\Users\Acer\Desktop\Research Papers\Number Plates\SLNumberPlateExtraction_20141007\SLNumberPlateExtraction';
cd (imgDir);
