function varargout = compareRGB(varargin)
% COMPARERGB MATLAB code for compareRGB.fig
%      COMPARERGB, by itself, creates a new COMPARERGB or raises the existing
%      singleton*.
%
%      H = COMPARERGB returns the handle to a new COMPARERGB or the handle to
%      the existing singleton*.
%
%      COMPARERGB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPARERGB.M with the given input arguments.
%
%      COMPARERGB('Property','Value',...) creates a new COMPARERGB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before compareRGB_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to compareRGB_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help compareRGB

% Last Modified by GUIDE v2.5 26-Jun-2016 17:42:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @compareRGB_OpeningFcn, ...
                   'gui_OutputFcn',  @compareRGB_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before compareRGB is made visible.
function compareRGB_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to compareRGB (see VARARGIN)

% Choose default command line output for compareRGB
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes compareRGB wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = compareRGB_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbFolder.
function pbFolder_Callback(hObject, eventdata, handles)
% hObject    handle to pbFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% fol = strcat(uigetdir, '\');
fol = strcat(uigetdir, '/');
handles.fol = fol;
guidata(hObject,handles);

set(handles.eFolder, 'String', fol);

% files = dir(strcat(fol, '*.mat'));
files = dir(strcat(fol, '*.jpg'));
numFiles = numel(files);
handles.numFiles = numFiles;
guidata(hObject,handles);

set(handles.eNumFiles, 'String', numFiles);

ik = 1;
set(handles.eK, 'String', num2str(ik));
handles.ik = ik;
guidata(hObject,handles);

% k1
files1 = dir(strcat(fol, '1_*.jpg'));
filesNames = {files1.name};
[~,idx] = sort(filesNames);

files1 = files1(idx);
clear filesNames idx;
handles.files1 = files1;
guidata(hObject,handles);

numFiles1 = numel(files1);
handles.numFiles1 = numFiles1;
guidata(hObject,handles);
set(handles.ek1files, 'String', numFiles1);

ik1 = 1;
set(handles.eK1, 'String', num2str(ik1));
handles.ik1 = ik1;
guidata(hObject,handles);

imgk1 = imread([fol files1(ik1).name]);
axes(handles.aK1);
imshow(fliplr(imgk1));

set(handles.ek1name, 'String', files1(ik1).name);

% k2
files2 = dir(strcat(fol, '2_*.jpg'));
filesNames = {files2.name};
[~,idx] = sort(filesNames);

files2 = files2(idx);
clear filesNames idx;
handles.files2 = files2;
guidata(hObject,handles);

numFiles2 = numel(files2);
handles.numFiles2 = numFiles2;
guidata(hObject,handles);
set(handles.ek2files, 'String', numFiles2);

ik2 = 1;
set(handles.eK2, 'String', num2str(ik2));
handles.ik2 = ik2;
guidata(hObject,handles);
imgk2 = imread([fol files2(ik2).name]);
axes(handles.aK2);
imshow(fliplr(imgk2));

set(handles.ek2name, 'String', files2(ik2).name);

% k3
files3 = dir(strcat(fol, '3_*.jpg'));
filesNames = {files3.name};
[~,idx] = sort(filesNames);

files3 = files3(idx);
clear filesNames idx;
handles.files3 = files3;
guidata(hObject,handles);

numFiles3 = numel(files3);
handles.numFiles3 = numFiles3;
guidata(hObject,handles);
set(handles.ek3files, 'String', numFiles3);

ik3 = 1;
set(handles.eK3, 'String', num2str(ik3));
handles.ik3 = ik3;
guidata(hObject,handles);
imgk3 = imread([fol files3(ik3).name]);
axes(handles.aK3);
imshow(fliplr(imgk3));

set(handles.ek3name, 'String', files3(ik3).name);

% k4
files4 = dir(strcat(fol, '4_*.jpg'));
filesNames = {files4.name};
[~,idx] = sort(filesNames);

files4 = files4(idx);
clear filesNames idx;
handles.files4 = files4;
guidata(hObject,handles);

numFiles4 = numel(files4);
handles.numFiles4 = numFiles4;
guidata(hObject,handles);
set(handles.ek4files, 'String', numFiles4);

ik4 = 1;
set(handles.eK4, 'String', num2str(ik4));
handles.ik4 = ik4;
guidata(hObject,handles);
imgk4 = imread([fol files4(ik4).name]);
axes(handles.aK4);
imshow(fliplr(imgk4));

set(handles.ek4name, 'String', files4(ik4).name);

% k5
files5 = dir(strcat(fol, '5_*.jpg'));
filesNames = {files5.name};
[~,idx] = sort(filesNames);

files5 = files5(idx);
clear filesNames idx;
handles.files5 = files5;
guidata(hObject,handles);

numFiles5 = numel(files5);
handles.numFiles5 = numFiles5;
guidata(hObject,handles);
set(handles.ek5files, 'String', numFiles5);

ik5 = 1;
set(handles.eK5, 'String', num2str(ik5));
handles.ik5 = ik5;
guidata(hObject,handles);
imgk5 = imread([fol files5(ik5).name]);
axes(handles.aK5);
imshow(fliplr(imgk5));

set(handles.ek5name, 'String', files5(ik5).name);

% k6
files6 = dir(strcat(fol, '6_*.jpg'));
filesNames = {files6.name};
[~,idx] = sort(filesNames);

files6 = files6(idx);
clear filesNames idx;
handles.files6 = files6;
guidata(hObject,handles);

numFiles6 = numel(files6);
handles.numFiles6 = numFiles6;
guidata(hObject,handles);
set(handles.ek6files, 'String', numFiles6);

ik6 = 1;
set(handles.eK6, 'String', num2str(ik6));
handles.ik6 = ik6;
guidata(hObject,handles);
imgk6 = imread([fol files6(ik6).name]);
axes(handles.aK6);
imshow(fliplr(imgk6));

set(handles.ek6name, 'String', files6(ik6).name);

% k7
files7 = dir(strcat(fol, '7_*.jpg'));
filesNames = {files7.name};
[~,idx] = sort(filesNames);

files7 = files7(idx);
clear filesNames idx;
handles.files7 = files7;
guidata(hObject,handles);

numFiles7 = numel(files7);
handles.numFiles7 = numFiles7;
guidata(hObject,handles);
set(handles.ek7files, 'String', numFiles7);

ik7 = 1;
set(handles.eK7, 'String', num2str(ik7));
handles.ik7 = ik7;
guidata(hObject,handles);
imgk7 = imread([fol files7(ik7).name]);
axes(handles.aK7);
imshow(fliplr(imgk7));

set(handles.ek7name, 'String', files7(ik7).name);

% k8
files8 = dir(strcat(fol, '8_*.jpg'));
filesNames = {files8.name};
[~,idx] = sort(filesNames);

files8 = files8(idx);
clear filesNames idx;
handles.files8 = files8;
guidata(hObject,handles);

numFiles8 = numel(files8);
handles.numFiles8 = numFiles8;
guidata(hObject,handles);
set(handles.ek8files, 'String', numFiles8);

ik8 = 1;
set(handles.eK8, 'String', num2str(ik8));
handles.ik8 = ik8;
guidata(hObject,handles);
imgk8 = imread([fol files8(ik8).name]);
axes(handles.aK8);
imshow(fliplr(imgk8));

set(handles.ek8name, 'String', files8(ik8).name);


function eFolder_Callback(hObject, eventdata, handles)
% hObject    handle to eFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eFolder as text
%        str2double(get(hObject,'String')) returns contents of eFolder as a double


% --- Executes during object creation, after setting all properties.
function eFolder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbK1Inc.
function pbK1Inc_Callback(hObject, eventdata, handles)
% hObject    handle to pbK1Inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k1
ik1 = handles.ik1;
ik1 = ik1 + 1;
handles.ik1 = ik1;
guidata(hObject,handles);
set(handles.eK1, 'String', num2str(ik1));

files1 = handles.files1;
imgk1 = imread([fol files1(ik1).name]);
axes(handles.aK1);
imshow(fliplr(imgk1));

set(handles.ek1name, 'String', files1(ik1).name);


% --- Executes on button press in pbK1Dec.
function pbK1Dec_Callback(hObject, eventdata, handles)
% hObject    handle to pbK1Dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k1
ik1 = handles.ik1;
ik1 = ik1 - 1;
handles.ik1 = ik1;
guidata(hObject,handles);
set(handles.eK1, 'String', num2str(ik1));

files1 = handles.files1;
imgk1 = imread([fol files1(ik1).name]);
axes(handles.aK1);
imshow(fliplr(imgk1));

set(handles.ek1name, 'String', files1(ik1).name);

function eK1_Callback(hObject, eventdata, handles)
% hObject    handle to eK1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK1 as text
%        str2double(get(hObject,'String')) returns contents of eK1 as a double


% --- Executes during object creation, after setting all properties.
function eK1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbK2Inc.
function pbK2Inc_Callback(hObject, eventdata, handles)
% hObject    handle to pbK2Inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k2
ik2 = handles.ik2;
ik2 = ik2 + 1;
handles.ik2 = ik2;
guidata(hObject,handles);
set(handles.eK2, 'String', num2str(ik2));

files2 = handles.files2;
imgk2 = imread([fol files2(ik2).name]);
axes(handles.aK2);
imshow(fliplr(imgk2));

set(handles.ek2name, 'String', files2(ik2).name);

% --- Executes on button press in pbK2Dec.
function pbK2Dec_Callback(hObject, eventdata, handles)
% hObject    handle to pbK2Dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k2
ik2 = handles.ik2;
ik2 = ik2 - 1;
handles.ik2 = ik2;
guidata(hObject,handles);
set(handles.eK2, 'String', num2str(ik2));

files2 = handles.files2;
imgk2 = imread([fol files2(ik2).name]);
axes(handles.aK2);
imshow(fliplr(imgk2));

set(handles.ek2name, 'String', files2(ik2).name);

function eK2_Callback(hObject, eventdata, handles)
% hObject    handle to eK2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK2 as text
%        str2double(get(hObject,'String')) returns contents of eK2 as a double


% --- Executes during object creation, after setting all properties.
function eK2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbK3Inc.
function pbK3Inc_Callback(hObject, eventdata, handles)
% hObject    handle to pbK3Inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k3
ik3 = handles.ik3;
ik3 = ik3 + 1;
handles.ik3 = ik3;
guidata(hObject,handles);
set(handles.eK3, 'String', num2str(ik3));

files3 = handles.files3;
imgk3 = imread([fol files3(ik3).name]);
axes(handles.aK3);
imshow(fliplr(imgk3));

set(handles.ek3name, 'String', files3(ik3).name);

% --- Executes on button press in pbK3Dec.
function pbK3Dec_Callback(hObject, eventdata, handles)
% hObject    handle to pbK3Dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k3
ik3 = handles.ik3;
ik3 = ik3 - 1;
handles.ik3 = ik3;
guidata(hObject,handles);
set(handles.eK3, 'String', num2str(ik3));

files3 = handles.files3;
imgk3 = imread([fol files3(ik3).name]);
axes(handles.aK3);
imshow(fliplr(imgk3));

set(handles.ek3name, 'String', files3(ik3).name);

function eK3_Callback(hObject, eventdata, handles)
% hObject    handle to eK3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK3 as text
%        str2double(get(hObject,'String')) returns contents of eK3 as a double


% --- Executes during object creation, after setting all properties.
function eK3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbK4Inc.
function pbK4Inc_Callback(hObject, eventdata, handles)
% hObject    handle to pbK4Inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');


% k4
ik4 = handles.ik4;
ik4 = ik4 + 1;
handles.ik4 = ik4;
guidata(hObject,handles);
set(handles.eK4, 'String', num2str(ik4));

files4 = handles.files4;
imgk4 = imread([fol files4(ik4).name]);
axes(handles.aK4);
imshow(fliplr(imgk4));

set(handles.ek4name, 'String', files4(ik4).name);

% --- Executes on button press in pbK4Dec.
function pbK4Dec_Callback(hObject, eventdata, handles)
% hObject    handle to pbK4Dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k4
ik4 = handles.ik4;
ik4 = ik4 - 1;
handles.ik4 = ik4;
guidata(hObject,handles);
set(handles.eK4, 'String', num2str(ik4));

files4 = handles.files4;
imgk4 = imread([fol files4(ik4).name]);
axes(handles.aK4);
imshow(fliplr(imgk4));

set(handles.ek4name, 'String', files4(ik4).name);

function eK4_Callback(hObject, eventdata, handles)
% hObject    handle to eK4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK4 as text
%        str2double(get(hObject,'String')) returns contents of eK4 as a double


% --- Executes during object creation, after setting all properties.
function eK4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbK5Inc.
function pbK5Inc_Callback(hObject, eventdata, handles)
% hObject    handle to pbK5Inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');


% k5
ik5 = handles.ik5;
ik5 = ik5 + 1;
handles.ik5 = ik5;
guidata(hObject,handles);
set(handles.eK5, 'String', num2str(ik5));

files5 = handles.files5;
imgk5 = imread([fol files5(ik5).name]);
axes(handles.aK5);
imshow(fliplr(imgk5));

set(handles.ek5name, 'String', files5(ik5).name);

% --- Executes on button press in pbK5Dec.
function pbK5Dec_Callback(hObject, eventdata, handles)
% hObject    handle to pbK5Dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k5
ik5 = handles.ik5;
ik5 = ik5 - 1;
handles.ik5 = ik5;
guidata(hObject,handles);
set(handles.eK5, 'String', num2str(ik5));

files5 = handles.files5;
imgk5 = imread([fol files5(ik5).name]);
axes(handles.aK5);
imshow(fliplr(imgk5));

set(handles.ek5name, 'String', files5(ik5).name);

function eK5_Callback(hObject, eventdata, handles)
% hObject    handle to eK5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK5 as text
%        str2double(get(hObject,'String')) returns contents of eK5 as a double


% --- Executes during object creation, after setting all properties.
function eK5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbK6Inc.
function pbK6Inc_Callback(hObject, eventdata, handles)
% hObject    handle to pbK6Inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');


% k6
ik6 = handles.ik6;
ik6 = ik6 + 1;
handles.ik6 = ik6;
guidata(hObject,handles);
set(handles.eK6, 'String', num2str(ik6));

files6 = handles.files6;
imgk6 = imread([fol files6(ik6).name]);
axes(handles.aK6);
imshow(fliplr(imgk6));

set(handles.ek6name, 'String', files6(ik6).name);

% --- Executes on button press in pbK6Dec.
function pbK6Dec_Callback(hObject, eventdata, handles)
% hObject    handle to pbK6Dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k6
ik6 = handles.ik6;
ik6 = ik6 - 1;
handles.ik6 = ik6;
guidata(hObject,handles);
set(handles.eK6, 'String', num2str(ik6));

files6 = handles.files6;
imgk6 = imread([fol files6(ik6).name]);
axes(handles.aK6);
imshow(fliplr(imgk6));

set(handles.ek6name, 'String', files6(ik6).name);

function eK6_Callback(hObject, eventdata, handles)
% hObject    handle to eK6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK6 as text
%        str2double(get(hObject,'String')) returns contents of eK6 as a double


% --- Executes during object creation, after setting all properties.
function eK6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbK7Inc.
function pbK7Inc_Callback(hObject, eventdata, handles)
% hObject    handle to pbK7Inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');


% k7
ik7 = handles.ik7;
ik7 = ik7 + 1;
handles.ik7 = ik7;
guidata(hObject,handles);
set(handles.eK7, 'String', num2str(ik7));

files7 = handles.files7;
imgk7 = imread([fol files7(ik7).name]);
axes(handles.aK7);
imshow(fliplr(imgk7));

set(handles.ek7name, 'String', files7(ik7).name);

% --- Executes on button press in pbK7Dec.
function pbK7Dec_Callback(hObject, eventdata, handles)
% hObject    handle to pbK7Dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k7
ik7 = handles.ik7;
ik7 = ik7 - 1;
handles.ik7 = ik7;
guidata(hObject,handles);
set(handles.eK7, 'String', num2str(ik7));

files7 = handles.files7;
imgk7 = imread([fol files7(ik7).name]);
axes(handles.aK7);
imshow(fliplr(imgk7));

set(handles.ek7name, 'String', files7(ik7).name);

function eK7_Callback(hObject, eventdata, handles)
% hObject    handle to eK7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK7 as text
%        str2double(get(hObject,'String')) returns contents of eK7 as a double


% --- Executes during object creation, after setting all properties.
function eK7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbK8Inc.
function pbK8Inc_Callback(hObject, eventdata, handles)
% hObject    handle to pbK8Inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');


% k8
ik8 = handles.ik8;
ik8 = ik8 + 1;
handles.ik8 = ik8;
guidata(hObject,handles);
set(handles.eK8, 'String', num2str(ik8));

files8 = handles.files8;
imgk8 = imread([fol files8(ik8).name]);
axes(handles.aK8);
imshow(fliplr(imgk8));

set(handles.ek8name, 'String', files8(ik8).name);

% --- Executes on button press in pbK8Dec.
function pbK8Dec_Callback(hObject, eventdata, handles)
% hObject    handle to pbK8Dec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

set(handles.eK, 'String', '');

% k8
ik8 = handles.ik8;
ik8 = ik8 - 1;
handles.ik8 = ik8;
guidata(hObject,handles);
set(handles.eK8, 'String', num2str(ik8));

files8 = handles.files8;
imgk8 = imread([fol files8(ik8).name]);
axes(handles.aK8);
imshow(fliplr(imgk8));

set(handles.ek8name, 'String', files8(ik8).name);

function eK8_Callback(hObject, eventdata, handles)
% hObject    handle to eK8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK8 as text
%        str2double(get(hObject,'String')) returns contents of eK8 as a double


% --- Executes during object creation, after setting all properties.
function eK8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbKInc.
function pbKInc_Callback(hObject, eventdata, handles)
% hObject    handle to pbKInc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

ik = handles.ik;
ik = ik+1;
handles.ik = ik;
guidata(hObject,handles);
set(handles.eK, 'String', num2str(ik));

% k1
ik1 = handles.ik1;
ik1 = ik1 + 1;
handles.ik1 = ik1;
guidata(hObject,handles);
set(handles.eK1, 'String', num2str(ik1));

files1 = handles.files1;
imgk1 = imread([fol files1(ik1).name]);
axes(handles.aK1);
imshow(fliplr(imgk1));

set(handles.ek1name, 'String', files1(ik1).name);

% k2
ik2 = handles.ik2;
ik2 = ik2 + 1;
handles.ik2 = ik2;
guidata(hObject,handles);
set(handles.eK2, 'String', num2str(ik2));

files2 = handles.files2;
imgk2 = imread([fol files2(ik2).name]);
axes(handles.aK2);
imshow(fliplr(imgk2));

set(handles.ek2name, 'String', files2(ik2).name);

% k3
ik3 = handles.ik3;
ik3 = ik3 + 1;
handles.ik3 = ik3;
guidata(hObject,handles);
set(handles.eK3, 'String', num2str(ik3));

files3 = handles.files3;
imgk3 = imread([fol files3(ik3).name]);
axes(handles.aK3);
imshow(fliplr(imgk3));

set(handles.ek3name, 'String', files3(ik3).name);

% k4
ik4 = handles.ik4;
ik4 = ik4 + 1;
handles.ik4 = ik4;
guidata(hObject,handles);
set(handles.eK4, 'String', num2str(ik4));

files4 = handles.files4;
imgk4 = imread([fol files4(ik4).name]);
axes(handles.aK4);
imshow(fliplr(imgk4));

set(handles.ek4name, 'String', files4(ik4).name);

% k5
ik5 = handles.ik5;
ik5 = ik5 + 1;
handles.ik5 = ik5;
guidata(hObject,handles);
set(handles.eK5, 'String', num2str(ik5));

files5 = handles.files5;
imgk5 = imread([fol files5(ik5).name]);
axes(handles.aK5);
imshow(fliplr(imgk5));

set(handles.ek5name, 'String', files5(ik5).name);

% k6
ik6 = handles.ik6;
ik6 = ik6 + 1;
handles.ik6 = ik6;
guidata(hObject,handles);
set(handles.eK6, 'String', num2str(ik6));

files6 = handles.files6;
imgk6 = imread([fol files6(ik6).name]);
axes(handles.aK6);
imshow(fliplr(imgk6));

set(handles.ek6name, 'String', files6(ik6).name);

% k7
ik7 = handles.ik7;
ik7 = ik7 + 1;
handles.ik7 = ik7;
guidata(hObject,handles);
set(handles.eK7, 'String', num2str(ik7));

files7 = handles.files7;
imgk7 = imread([fol files7(ik7).name]);
axes(handles.aK7);
imshow(fliplr(imgk7));

set(handles.ek7name, 'String', files7(ik7).name);

% k8
ik8 = handles.ik8;
ik8 = ik8 + 1;
handles.ik8 = ik8;
guidata(hObject,handles);
set(handles.eK8, 'String', num2str(ik8));

files8 = handles.files8;
imgk8 = imread([fol files8(ik8).name]);
axes(handles.aK8);
imshow(fliplr(imgk8));

set(handles.ek8name, 'String', files8(ik8).name);


% --- Executes on button press in pbKDec.
function pbKDec_Callback(hObject, eventdata, handles)
% hObject    handle to pbKDec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

ik = handles.ik;
ik = ik - 1;
handles.ik = ik;
guidata(hObject,handles);
set(handles.eK, 'String', num2str(ik));

% k1
ik1 = handles.ik1;
ik1 = ik1 - 1;
handles.ik1 = ik1;
guidata(hObject,handles);
set(handles.eK1, 'String', num2str(ik1));

files1 = handles.files1;
imgk1 = imread([fol files1(ik1).name]);
axes(handles.aK1);
imshow(fliplr(imgk1));

set(handles.ek1name, 'String', files1(ik1).name);

% k2
ik2 = handles.ik2;
ik2 = ik2 - 1;
handles.ik2 = ik2;
guidata(hObject,handles);
set(handles.eK2, 'String', num2str(ik2));

files2 = handles.files2;
imgk2 = imread([fol files2(ik2).name]);
axes(handles.aK2);
imshow(fliplr(imgk2));

set(handles.ek2name, 'String', files2(ik2).name);

% k3
ik3 = handles.ik3;
ik3 = ik3 - 1;
handles.ik3 = ik3;
guidata(hObject,handles);
set(handles.eK3, 'String', num2str(ik3));

files3 = handles.files3;
imgk3 = imread([fol files3(ik3).name]);
axes(handles.aK3);
imshow(fliplr(imgk3));

set(handles.ek3name, 'String', files3(ik3).name);

% k4
ik4 = handles.ik4;
ik4 = ik4 - 1;
handles.ik4 = ik4;
guidata(hObject,handles);
set(handles.eK4, 'String', num2str(ik4));

files4 = handles.files4;
imgk4 = imread([fol files4(ik4).name]);
axes(handles.aK4);
imshow(fliplr(imgk4));

set(handles.ek4name, 'String', files4(ik4).name);

% k5
ik5 = handles.ik5;
ik5 = ik5 - 1;
handles.ik5 = ik5;
guidata(hObject,handles);
set(handles.eK5, 'String', num2str(ik5));

files5 = handles.files5;
imgk5 = imread([fol files5(ik5).name]);
axes(handles.aK5);
imshow(fliplr(imgk5));

set(handles.ek5name, 'String', files5(ik5).name);

% k6
ik6 = handles.ik6;
ik6 = ik6 - 1;
handles.ik6 = ik6;
guidata(hObject,handles);
set(handles.eK6, 'String', num2str(ik6));

files6 = handles.files6;
imgk6 = imread([fol files6(ik6).name]);
axes(handles.aK6);
imshow(fliplr(imgk6));

set(handles.ek6name, 'String', files6(ik6).name);

% k7
ik7 = handles.ik7;
ik7 = ik7 - 1;
handles.ik7 = ik7;
guidata(hObject,handles);
set(handles.eK7, 'String', num2str(ik7));

files7 = handles.files7;
imgk7 = imread([fol files7(ik7).name]);
axes(handles.aK7);
imshow(fliplr(imgk7));

set(handles.ek7name, 'String', files7(ik7).name);

% k8
ik8 = handles.ik8;
ik8 = ik8 - 1;
handles.ik8 = ik8;
guidata(hObject,handles);
set(handles.eK8, 'String', num2str(ik8));

files8 = handles.files8;
imgk8 = imread([fol files8(ik8).name]);
axes(handles.aK8);
imshow(fliplr(imgk8));

set(handles.ek8name, 'String', files8(ik8).name);


function eK_Callback(hObject, eventdata, handles)
% hObject    handle to eK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eK as text
%        str2double(get(hObject,'String')) returns contents of eK as a double


% --- Executes during object creation, after setting all properties.
function eK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eNumFiles_Callback(hObject, eventdata, handles)
% hObject    handle to eNumFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eNumFiles as text
%        str2double(get(hObject,'String')) returns contents of eNumFiles as a double


% --- Executes during object creation, after setting all properties.
function eNumFiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eNumFiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek1files_Callback(hObject, eventdata, handles)
% hObject    handle to ek1files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek1files as text
%        str2double(get(hObject,'String')) returns contents of ek1files as a double


% --- Executes during object creation, after setting all properties.
function ek1files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek1files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek2files_Callback(hObject, eventdata, handles)
% hObject    handle to ek2files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek2files as text
%        str2double(get(hObject,'String')) returns contents of ek2files as a double


% --- Executes during object creation, after setting all properties.
function ek2files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek2files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek3files_Callback(hObject, eventdata, handles)
% hObject    handle to ek3files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek3files as text
%        str2double(get(hObject,'String')) returns contents of ek3files as a double


% --- Executes during object creation, after setting all properties.
function ek3files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek3files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek4files_Callback(hObject, eventdata, handles)
% hObject    handle to ek4files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek4files as text
%        str2double(get(hObject,'String')) returns contents of ek4files as a double


% --- Executes during object creation, after setting all properties.
function ek4files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek4files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek5files_Callback(hObject, eventdata, handles)
% hObject    handle to ek5files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek5files as text
%        str2double(get(hObject,'String')) returns contents of ek5files as a double


% --- Executes during object creation, after setting all properties.
function ek5files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek5files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek6files_Callback(hObject, eventdata, handles)
% hObject    handle to ek6files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek6files as text
%        str2double(get(hObject,'String')) returns contents of ek6files as a double


% --- Executes during object creation, after setting all properties.
function ek6files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek6files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek7files_Callback(hObject, eventdata, handles)
% hObject    handle to ek7files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek7files as text
%        str2double(get(hObject,'String')) returns contents of ek7files as a double


% --- Executes during object creation, after setting all properties.
function ek7files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek7files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek8files_Callback(hObject, eventdata, handles)
% hObject    handle to ek8files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek8files as text
%        str2double(get(hObject,'String')) returns contents of ek8files as a double


% --- Executes during object creation, after setting all properties.
function ek8files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek8files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek1name_Callback(hObject, eventdata, handles)
% hObject    handle to ek1name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek1name as text
%        str2double(get(hObject,'String')) returns contents of ek1name as a double


% --- Executes during object creation, after setting all properties.
function ek1name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek1name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek2name_Callback(hObject, eventdata, handles)
% hObject    handle to ek2name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek2name as text
%        str2double(get(hObject,'String')) returns contents of ek2name as a double


% --- Executes during object creation, after setting all properties.
function ek2name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek2name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek3name_Callback(hObject, eventdata, handles)
% hObject    handle to ek3name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek3name as text
%        str2double(get(hObject,'String')) returns contents of ek3name as a double


% --- Executes during object creation, after setting all properties.
function ek3name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek3name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek4name_Callback(hObject, eventdata, handles)
% hObject    handle to ek4name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek4name as text
%        str2double(get(hObject,'String')) returns contents of ek4name as a double


% --- Executes during object creation, after setting all properties.
function ek4name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek4name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek5name_Callback(hObject, eventdata, handles)
% hObject    handle to ek5name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek5name as text
%        str2double(get(hObject,'String')) returns contents of ek5name as a double


% --- Executes during object creation, after setting all properties.
function ek5name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek5name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek6name_Callback(hObject, eventdata, handles)
% hObject    handle to ek6name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek6name as text
%        str2double(get(hObject,'String')) returns contents of ek6name as a double


% --- Executes during object creation, after setting all properties.
function ek6name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek6name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek7name_Callback(hObject, eventdata, handles)
% hObject    handle to ek7name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek7name as text
%        str2double(get(hObject,'String')) returns contents of ek7name as a double


% --- Executes during object creation, after setting all properties.
function ek7name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek7name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ek8name_Callback(hObject, eventdata, handles)
% hObject    handle to ek8name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ek8name as text
%        str2double(get(hObject,'String')) returns contents of ek8name as a double


% --- Executes during object creation, after setting all properties.
function ek8name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ek8name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pbSaveMatches.
function pbSaveMatches_Callback(hObject, eventdata, handles)
% hObject    handle to pbSaveMatches (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

files1 = handles.files1;
files2 = handles.files2;
files3 = handles.files3;
files4 = handles.files4;
files5 = handles.files5;
files6 = handles.files6;
files7 = handles.files7;
files8 = handles.files8;

ik1 = handles.ik1;
ik2 = handles.ik2;
ik3 = handles.ik3;
ik4 = handles.ik4;
ik5 = handles.ik5;
ik6 = handles.ik6;
ik7 = handles.ik7;
ik8 = handles.ik8;

mfd = datestr(now,'yyyymmddHHMM');
mfname = [num2str(ik1),'_',num2str(ik2),'_',num2str(ik3),'_',...
    num2str(ik4),'_',num2str(ik5),'_',num2str(ik6),'_',...
    num2str(ik7),'_',num2str(ik8)];

fid = fopen(strcat(fol,'mf-',mfname,'-',mfd,'.txt'),'w');
fprintf(fid,datestr(now,'mm/dd/yyyy HH:MM:SS AM'));
fprintf(fid,'\n\nfol = %s\n',fol);

fprintf(fid,'\n%d\t%s',ik1,files1(ik1).name);
fprintf(fid,'\n%d\t%s',ik2,files2(ik2).name);
fprintf(fid,'\n%d\t%s',ik3,files3(ik3).name);
fprintf(fid,'\n%d\t%s',ik4,files4(ik4).name);
fprintf(fid,'\n%d\t%s',ik5,files5(ik5).name);
fprintf(fid,'\n%d\t%s',ik6,files6(ik6).name);
fprintf(fid,'\n%d\t%s',ik7,files7(ik7).name);
fprintf(fid,'\n%d\t%s',ik8,files8(ik8).name);

mf = [ik1 ik2 ik3 ik4 ik5 ik6 ik7 ik8];
save(strcat(fol,'mf-',mfname,'-',mfd,'.mat'), 'mf');

fclose(fid);


% --- Executes on button press in pbSaveScreen.
function pbSaveScreen_Callback(hObject, eventdata, handles)
% hObject    handle to pbSaveScreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fol = handles.fol;

% files1 = handles.files1;
% ik1 = handles.ik1;
% name = files1(ik1).name;

fr = getframe(gcf);
fi = frame2im(fr);
imwrite(fi,strcat(fol,'mf_screenCapture_',...
    datestr(now,'yyyymmddHHMM'),'.png'));
