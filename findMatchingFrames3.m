% 20150606
% find matching frames

clear all;

cam = [1,2,3,4,5,7,8];

% for i = 1:numel(cam)
path = 'D:\KinectData\20150620_Kolis\Kolis_SlowMoving\All\';
files = dir(strcat(path, '*.ply'));

for f = 1:numel(files)
    name = files(f).name;
    names(mod(f,50)+1,str2num(name(1))) = str2num(name(3:9));
    fileName = strcat(path, name);
%         disp(fileName);
end
% end

names = sort(names,'ascend');

minT = min(names(1,:));

% names2(:,3) = names(:,3);
% 
% for i = 1:size(names,1)
%     for j = [1,2,4]
%         [r, c, v] = find(names(:,j)==names(i,3));
%         if v==1
% %             disp([r c v]);
%             names2(i,j) = names(r,j);
%         else
%             [r, c, v] = find(names(:,j)==names(i,3)-1);
%             if v==1
% %                 disp([r c v]);
%                 names2(i,j) = names(r,j);
%             else
%                 [r, c, v] = find(names(:,j)==names(i,3)+1);
%                 if v==1
%     %                 disp([r c v]);
%                     names2(i,j) = names(r,j);
% %                 else
% %                     [r, c, v] = find(names(:,j)==names(i,3)-2);
% %                     if v==1
% %         %                 disp([r c v]);
% %                         names2(i,j) = names(r,j);
% %                     else
% %                         [r, c, v] = find(names(:,j)==names(i,3)+2);
% %                         if v==1
% %             %                 disp([r c v]);
% %                             names2(i,j) = names(r,j);
% %                         end
% %                     end
%                 end
%             end
%         end
%     end
% end
% 
% [r,c] = find(not(names2));
% 
% names3 = names2;
% names3(r,:) = [];

