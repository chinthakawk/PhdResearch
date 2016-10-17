%CREATE TEMPLATES

%Number
one=imread('Numbers\1.png');  
one=imread('Numbers\2.png');
one=imread('Numbers\3.png');
one=imread('Numbers\4.png');
one=imread('Numbers\5.png');
one=imread('Numbers\6.png');
one=imread('Numbers\7.png');
one=imread('Numbers\8.png');
one=imread('Numbers\9.png');
one=imread('Numbers\0.png');


zero=imread('letters_numbers\0.bmp');
%*-*-*-*-*-*-*-*-*-*-*-
letter=[A B C D E F G H I J K L M...
    N O P Q R S T U V W X Y Z];
number=[one two three four five...
    six seven eight nine zero];
character=[letter number];
templates=mat2cell(character,42,[24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 ...
    24 24 24 24 24 24 24 24]);
% templates=mat2cell(character,42,[24 24 24 24 24 24 24 ...
%     24 24 24 27 27 27 27 ...
%     27 27 26 27 20 27 27 ...
%     27 27 27 27 27 27 27 ...
%     27 27 27 27 27 27 27 27]);
save ('templates','templates')
clear all
