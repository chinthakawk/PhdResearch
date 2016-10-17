% 20150606
% find matching frames

clear all;

cam = [1,2,3,4,5,7,8];

% for i = 1:numel(cam)
path = 'E:\Shared\519\20161003\nick\01_all\';
files = dir(strcat(path, '*.jpg'));

filename = strcat(path, 'names.xlsx');

n1 = [];
n2 = [];
n3 = [];
n4 = [];
n5 = [];
n6 = [];
n7 = [];
n8 = [];

for f = 1:numel(files)
    name = files(f).name;
    if str2double(name(1))==1
        n1 = [n1; str2double(name(3:9))];
    elseif str2double(name(1))==2
        n2 = [n2; str2double(name(3:9))];
    elseif str2double(name(1))==3
        n3 = [n3; str2double(name(3:9))];
    elseif str2double(name(1))==4
        n4 = [n4; str2double(name(3:9))];
    elseif str2double(name(1))==5
        n5 = [n5; str2double(name(3:9))];
    elseif str2double(name(1))==6
        n6 = [n6; str2double(name(3:9))];
    elseif str2double(name(1))==7
        n7 = [n7; str2double(name(3:9))];
    elseif str2double(name(1))==8
        n8 = [n8; str2double(name(3:9))];
    end
end
% end

n = [n1 n2 n3 n4 n5 n6 n7 n8];

xlswrite(filename,n);
save(strcat(filename(1:numel(filename)-4),'mat'),'n');

% names = sort(names,'ascend');
% 
% minT = min(names(1,:));

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

