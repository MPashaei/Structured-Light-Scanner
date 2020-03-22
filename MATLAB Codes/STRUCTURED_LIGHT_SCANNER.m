function varargout = STRUCTURED_LIGHT_SCANNER(varargin)
% STRUCTURED_LIGHT_SCANNER M-file for STRUCTURED_LIGHT_SCANNER.fig
%      STRUCTURED_LIGHT_SCANNER, by itself, creates a new STRUCTURED_LIGHT_SCANNER or raises the existing
%      singleton*.
%
%      H = STRUCTURED_LIGHT_SCANNER returns the handle to a new STRUCTURED_LIGHT_SCANNER or the handle to
%      the existing singleton*.
%
%      STRUCTURED_LIGHT_SCANNER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURED_LIGHT_SCANNER.M with the given input arguments.
%
%      STRUCTURED_LIGHT_SCANNER('Property','Value',...) creates a new STRUCTURED_LIGHT_SCANNER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before STRUCTURED_LIGHT_SCANNER_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to STRUCTURED_LIGHT_SCANNER_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help STRUCTURED_LIGHT_SCANNER

% Last Modified by GUIDE v2.5 29-Dec-2009 22:34:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @STRUCTURED_LIGHT_SCANNER_OpeningFcn, ...
                   'gui_OutputFcn',  @STRUCTURED_LIGHT_SCANNER_OutputFcn, ...
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


% --- Executes just before STRUCTURED_LIGHT_SCANNER is made visible.
function STRUCTURED_LIGHT_SCANNER_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to STRUCTURED_LIGHT_SCANNER (see VARARGIN)

% Choose default command line output for STRUCTURED_LIGHT_SCANNER
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes STRUCTURED_LIGHT_SCANNER wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = STRUCTURED_LIGHT_SCANNER_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function SETPATH_Callback(hObject, eventdata, handles)
% hObject    handle to SETPATH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
CurrentDirectory=cd;

% --------------------------------------------------------------------
function FILE_Callback(hObject, eventdata, handles)
% hObject    handle to FILE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function ImportInterriorOrientationParametersLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ImportInterriorOrientationParametersLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
[FileName,PathName] = uigetfile('*.txt','Pick Left Camera');
Camera_Parameters = importdata([PathName FileName]);

   % u0,v0 are coordinates of center of Image in Pixel coordinate system
   H   = Camera_Parameters(11);
   V   = Camera_Parameters(12);
   u0  = H/2+0.5;
   v0  = V/2+0.5;
   Camera_Parameters(15)=u0;
   Camera_Parameters(16)=v0;
   handles.Cam_Num_Left = FileName;
   handles.Camera_Parameters_Left = Camera_Parameters;
   guidata(hObject,handles);
% --------------------------------------------------------------------
function ImportChessBoardImageLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ImportChessBoardImageLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
[filename,filepath]=uigetfile('*.*','Open Chess Board Image From Left Camera');
 Chessboard=imread(fullfile(filepath,filename));
 colormap(gray(256))
 image(Chessboard,'parent',handles.axes1)
 set(handles.axes1,'visible','off');
 handles.LeftChessboard=Chessboard;
 guidata(hObject,handles);
% --------------------------------------------------------------------
function ImportThresholdImagesLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ImportThresholdImagesLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Path = fullfile('Database','Left Position','Coding Images');
ThIMG_1=imread(fullfile(Path,'Thereshold1.jpg'));
ThIMG_2=imread(fullfile(Path,'Thereshold2.jpg'));
ThIMG_1=ThIMG_1(:,:,1);
ThIMG_2=ThIMG_2(:,:,1);
handles.Left_Thereshold1=ThIMG_1;
handles.Left_Thereshold2=ThIMG_2;
guidata(hObject,handles);
% --------------------------------------------------------------------
function ImportCodingImagesLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ImportCodingImagesLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Path = fullfile('Database','Left Position','Coding Images');
IMG_1=imread(fullfile(Path,'Code01.jpg'));
IMG_1=IMG_1(:,:,1);
IMG_2=imread(fullfile(Path,'Code02.jpg'));
IMG_2=IMG_2(:,:,1);
IMG_3=imread(fullfile(Path,'Code03.jpg'));
IMG_3=IMG_3(:,:,1);
IMG_4=imread(fullfile(Path,'Code04.jpg'));
IMG_4=IMG_4(:,:,1);
IMG_5=imread(fullfile(Path,'Code05.jpg'));
IMG_5=IMG_5(:,:,1);
IMG_6=imread(fullfile(Path,'Code06.jpg'));
IMG_6=IMG_6(:,:,1);
IMG_7=imread(fullfile(Path,'Code07.jpg'));
IMG_7=IMG_7(:,:,1);
IMG_8=imread(fullfile(Path,'Code08.jpg'));
IMG_8=IMG_8(:,:,1);
handles.Left_IMG_Code_1=IMG_1;
handles.Left_IMG_Code_2=IMG_2;
handles.Left_IMG_Code_3=IMG_3;
handles.Left_IMG_Code_4=IMG_4;
handles.Left_IMG_Code_5=IMG_5;
handles.Left_IMG_Code_6=IMG_6;
handles.Left_IMG_Code_7=IMG_7;
handles.Left_IMG_Code_8=IMG_8;
guidata(hObject,handles);
% --------------------------------------------------------------------
function ImportScanningImagesLeft_Callback(hObject, eventdata, handles)
% hObject    handle to ImportScanningImagesLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Path = fullfile('Database','Left Position','Scanning Images');
IMG_1=imread(fullfile(Path,'Scan01.jpg'));
IMG_1=IMG_1(:,:,1);
IMG_2=imread(fullfile(Path,'Scan02.jpg'));
IMG_2=IMG_2(:,:,1);
IMG_3=imread(fullfile(Path,'Scan03.jpg'));
IMG_3=IMG_3(:,:,1);
IMG_4=imread(fullfile(Path,'Scan04.jpg'));
IMG_4=IMG_4(:,:,1);
IMG_5=imread(fullfile(Path,'Scan05.jpg'));
IMG_5=IMG_5(:,:,1);
IMG_6=imread(fullfile(Path,'Scan06.jpg'));
IMG_6=IMG_6(:,:,1);
IMG_7=imread(fullfile(Path,'Scan07.jpg'));
IMG_7=IMG_7(:,:,1);
IMG_8=imread(fullfile(Path,'Scan08.jpg'));
IMG_8=IMG_8(:,:,1);
handles.Left_IMG_Scan_1=IMG_1;
handles.Left_IMG_Scan_2=IMG_2;
handles.Left_IMG_Scan_3=IMG_3;
handles.Left_IMG_Scan_4=IMG_4;
handles.Left_IMG_Scan_5=IMG_5;
handles.Left_IMG_Scan_6=IMG_6;
handles.Left_IMG_Scan_7=IMG_7;
handles.Left_IMG_Scan_8=IMG_8;
% --------------------------------------------------------------------
function ImportInterriorOrientationParametersRight_Callback(hObject, eventdata, handles)
% hObject    handle to ImportInterriorOrientationParametersRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Pick Right Camera');
Camera_Parameters = importdata([PathName FileName]);
   
   % u0,v0 are coordinates of center of Image in Pixel coordinate system
   H   = Camera_Parameters(11);
   V   = Camera_Parameters(12);
   u0  = H/2+0.5;
   v0  = V/2+0.5;
   Camera_Parameters(15)=u0;
   Camera_Parameters(16)=v0;
   handles.Cam_Num_Right = FileName;
   handles.Camera_Parameters_Right = Camera_Parameters;
   guidata(hObject,handles);
% --------------------------------------------------------------------
function ImportChessBoardImageRight_Callback(hObject, eventdata, handles)
% hObject    handle to ImportChessBoardImageRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
[filename,filepath]=uigetfile('*.*','Open Chess Board Image From Right Camera');
 Chessboard=imread(fullfile(filepath,filename));
 colormap(gray(256))
 image(Chessboard,'parent',handles.axes1)
 set(handles.axes1,'visible','off');
 handles.RightChessboard=Chessboard;
 guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportThresholdImagesRight_Callback(hObject, eventdata, handles)
% hObject    handle to ImportThresholdImagesRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Path = fullfile('Database','Right Position','Coding Images');
ThIMG_1=imread(fullfile(Path,'Thereshold1.jpg'));
ThIMG_2=imread(fullfile(Path,'Thereshold2.jpg'));
ThIMG_1=ThIMG_1(:,:,1);
ThIMG_2=ThIMG_2(:,:,1);
handles.Right_Thereshold1=ThIMG_1;
handles.Right_Thereshold2=ThIMG_2;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportCodingImagesRight_Callback(hObject, eventdata, handles)
% hObject    handle to ImportCodingImagesRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Path = fullfile('Database','Right Position','Coding Images');
IMG_1=imread(fullfile(Path,'Code01.jpg'));
IMG_1=IMG_1(:,:,1);
IMG_2=imread(fullfile(Path,'Code02.jpg'));
IMG_2=IMG_2(:,:,1);
IMG_3=imread(fullfile(Path,'Code03.jpg'));
IMG_3=IMG_3(:,:,1);
IMG_4=imread(fullfile(Path,'Code04.jpg'));
IMG_4=IMG_4(:,:,1);
IMG_5=imread(fullfile(Path,'Code05.jpg'));
IMG_5=IMG_5(:,:,1);
IMG_6=imread(fullfile(Path,'Code06.jpg'));
IMG_6=IMG_6(:,:,1);
IMG_7=imread(fullfile(Path,'Code07.jpg'));
IMG_7=IMG_7(:,:,1);
IMG_8=imread(fullfile(Path,'Code08.jpg'));
IMG_8=IMG_8(:,:,1);
handles.Right_IMG_Code_1=IMG_1;
handles.Right_IMG_Code_2=IMG_2;
handles.Right_IMG_Code_3=IMG_3;
handles.Right_IMG_Code_4=IMG_4;
handles.Right_IMG_Code_5=IMG_5;
handles.Right_IMG_Code_6=IMG_6;
handles.Right_IMG_Code_7=IMG_7;
handles.Right_IMG_Code_8=IMG_8;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportScanningImagesRight_Callback(hObject, eventdata, handles)
% hObject    handle to ImportScanningImagesRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Path = fullfile('Database','Right Position','Scanning Images');
IMG_1=imread(fullfile(Path,'Scan01.jpg'));
IMG_1=IMG_1(:,:,1);
IMG_2=imread(fullfile(Path,'Scan02.jpg'));
IMG_2=IMG_2(:,:,1);
IMG_3=imread(fullfile(Path,'Scan03.jpg'));
IMG_3=IMG_3(:,:,1);
IMG_4=imread(fullfile(Path,'Scan04.jpg'));
IMG_4=IMG_4(:,:,1);
IMG_5=imread(fullfile(Path,'Scan05.jpg'));
IMG_5=IMG_5(:,:,1);
IMG_6=imread(fullfile(Path,'Scan06.jpg'));
IMG_6=IMG_6(:,:,1);
IMG_7=imread(fullfile(Path,'Scan07.jpg'));
IMG_7=IMG_7(:,:,1);
IMG_8=imread(fullfile(Path,'Scan08.jpg'));
IMG_8=IMG_8(:,:,1);
handles.Right_IMG_Scan_1=IMG_1;
handles.Right_IMG_Scan_2=IMG_2;
handles.Right_IMG_Scan_3=IMG_3;
handles.Right_IMG_Scan_4=IMG_4;
handles.Right_IMG_Scan_5=IMG_5;
handles.Right_IMG_Scan_6=IMG_6;
handles.Right_IMG_Scan_7=IMG_7;
handles.Right_IMG_Scan_8=IMG_8;

% --------------------------------------------------------------------
function LEFT_CAMERA_Callback(hObject, eventdata, handles)
% hObject    handle to LEFT_CAMERA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function RIGHT_CAMERA_Callback(hObject, eventdata, handles)
% hObject    handle to RIGHT_CAMERA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function IMPORT_DATA_Callback(hObject, eventdata, handles)
% hObject    handle to IMPORT_DATA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ZOOMIN.
function ZOOMIN_Callback(hObject, eventdata, handles)
% hObject    handle to ZOOMIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom on

% --- Executes on button press in PAAN.
function PAAN_Callback(hObject, eventdata, handles)
% hObject    handle to PAAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pan

% --- Executes on button press in ZOOMOFF.
function ZOOMOFF_Callback(hObject, eventdata, handles)
% hObject    handle to ZOOMOFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom off

% --- Executes on button press in ZOOMOUT.
function ZOOMOUT_Callback(hObject, eventdata, handles)
% hObject    handle to ZOOMOUT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom out

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Camera_Parameters = handles.Camera_Parameters_Left;
Chessboard=handles.LeftChessboard;
Xim=[];press=0;
for i=1:4
[x y]=ginput(1);
press=press+1;
x=round(x);y=round(y);
Xim=[Xim;x y];
hold on;plot(x,y,'+');
end;
fid_coord=Xim;
calib_coord=[25.5 7.5;25.5 25.5;7.5 7.5;7.5 25.5];
[p]=Projective(calib_coord,fid_coord);
corn=[];
for j=1:10
    for i=1:10
    x=(p(1)*(i*3)+p(2)*(j*3)+p(3))/(p(7)*(i*3)+p(8)*(j*3)+1);
    y=(p(4)*(i*3)+p(5)*(j*3)+p(6))/(p(7)*(i*3)+p(8)*(j*3)+1);
    hold on
    plot(x,y,'.g')
    corn=[corn;x y];
    end;
end;
hold on
plot(corn(:,1),corn(:,2),'.g')
Npoint=size(corn,1);
corner=[];
for i=1:Npoint
    corner=[corner;i corn(i,1) corn(i,2)];
end;
I=Chessboard;
I=im2double(I);
I=rgb2gray(I);
w=50;
 [xc,good,bad,type] = cornerfinder(corner(:,2:3)',I);
 xc=xc';
 X=xc(:,1);
 Y=xc(:,2);
 exact_corner=[corner(:,1) X Y];
 for i=1:size(exact_corner,1)
  text(exact_corner(i,2)+3,exact_corner(i,3)+3,['\leftarrow',num2str(i)],'FontSize',7)% 'EdgeColor','red','LineWidth',2,'EdgeColor','yellow',...
          %'FontSize',5,'BackgroundColor',[.7 .9 .7]);
 end;
 hold on
 plot(X,Y,'.r','MarkerSize',5); 
%==========================================================================  
PixelSize=Camera_Parameters(14);
u0=Camera_Parameters(15);
v0=Camera_Parameters(16);
Chessboard_Pixel_Coordinates=exact_corner;
%Convert pixle coordinates to Image coordinates
disp('Converting From Pixle Coordinates To Raw Image coordinates')
Chessboard_Raw_Coordinates=Pix2Img(Chessboard_Pixel_Coordinates,u0,v0,PixelSize);
%==========================================================================
Calibration_Parameters(1,1)=36939;
for i=2:10
Calibration_Parameters(i,1)=Camera_Parameters(i,1);
end;
disp('Converting From Raw Image Coordinates To Refiend Image Coordinate')
[Chessboard_Refined_Coordinates]=Image_Point_Refinement(Chessboard_Raw_Coordinates,Calibration_Parameters);
 %=========================================================================
 handles.Left_Chessboard_Refined_Coordinates = Chessboard_Refined_Coordinates;
 guidata(hObject,handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Chessboard_Refined_Coordinates =  handles.Left_Chessboard_Refined_Coordinates;
[FileName,Path] = uiputfile('.txt','Save file name');
cd(Path)
dlmwrite(FileName,Chessboard_Refined_Coordinates,'delimiter',' ','newline','pc','precision',8)
cd(CurrentDirectory)

function T1_Callback(hObject, eventdata, handles)
% hObject    handle to T1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1 as text
%        str2double(get(hObject,'String')) returns contents of T1 as a double


% --- Executes during object creation, after setting all properties.
function T1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Camera_Parameters = handles.Camera_Parameters_Right;
Chessboard=handles.RightChessboard;
Xim=[];press=0;
for i=1:4
[x y]=ginput(1);
press=press+1;
x=round(x);y=round(y);
Xim=[Xim;x y];
hold on;plot(x,y,'+');
end;
fid_coord=Xim;
calib_coord=[25.5 7.5;25.5 25.5;7.5 7.5;7.5 25.5];
[p]=Projective(calib_coord,fid_coord);
corn=[];
for j=1:10
    for i=1:10
    x=(p(1)*(i*3)+p(2)*(j*3)+p(3))/(p(7)*(i*3)+p(8)*(j*3)+1);
    y=(p(4)*(i*3)+p(5)*(j*3)+p(6))/(p(7)*(i*3)+p(8)*(j*3)+1);
    hold on
    plot(x,y,'.g')
    corn=[corn;x y];
    end;
end;
hold on
plot(corn(:,1),corn(:,2),'.g')
Npoint=size(corn,1);
corner=[];
for i=1:Npoint
    corner=[corner;i corn(i,1) corn(i,2)];
end;
I=Chessboard;
I=im2double(I);
I=rgb2gray(I);
w=50;
 [xc,good,bad,type] = cornerfinder(corner(:,2:3)',I);
 xc=xc';
 X=xc(:,1);
 Y=xc(:,2);
 exact_corner=[corner(:,1) X Y];
 for i=1:size(exact_corner,1)
  text(exact_corner(i,2)+3,exact_corner(i,3)+3,['\leftarrow',num2str(i)],'FontSize',7)% 'EdgeColor','red','LineWidth',2,'EdgeColor','yellow',...
          %'FontSize',5,'BackgroundColor',[.7 .9 .7]);
 end;
 hold on
 plot(X,Y,'.r','MarkerSize',5); 
%==========================================================================  
PixelSize=Camera_Parameters(14);
u0=Camera_Parameters(15);
v0=Camera_Parameters(16);
Chessboard_Pixel_Coordinates=exact_corner;
%Convert pixle coordinates to Image coordinates
disp('Converting From Pixle Coordinates To Raw Image coordinates')
Chessboard_Raw_Coordinates=Pix2Img(Chessboard_Pixel_Coordinates,u0,v0,PixelSize);
%==========================================================================
Calibration_Parameters(1,1)=36939;
for i=2:10
Calibration_Parameters(i,1)=Camera_Parameters(i,1);
end;
disp('Converting From Raw Image Coordinates To Refiend Image Coordinate')
[Chessboard_Refined_Coordinates]=Image_Point_Refinement(Chessboard_Raw_Coordinates,Calibration_Parameters);
 %=========================================================================
 handles.Right_Chessboard_Refined_Coordinates = Chessboard_Refined_Coordinates;
 guidata(hObject,handles);

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Chessboard_Refined_Coordinates =  handles.Right_Chessboard_Refined_Coordinates;
[FileName,Path] = uiputfile('.txt','Save file name');
cd(Path)
dlmwrite(FileName,Chessboard_Refined_Coordinates,'delimiter',' ','newline','pc','precision',8)
cd(CurrentDirectory)

function T2_Callback(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2 as text
%        str2double(get(hObject,'String')) returns contents of T2 as a double


% --- Executes during object creation, after setting all properties.
function T2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
Camera_Parameters = handles.Camera_Parameters_Left;
Chessboard_Refined_Coordinates = handles.Left_Chessboard_Refined_Coordinates;

[FileName,PathName] = uigetfile('*.xyz','Pick GCP');
ground_Control_Points_coordinates = importdata([PathName FileName]);
GCP=ground_Control_Points_coordinates(:,2:4);
f   = Camera_Parameters(1);
xo=0;
yo=0;
Imagecoord=Chessboard_Refined_Coordinates; 
num=[];
[m,n]=size(Imagecoord);
for i=1:m
    num=[num;i];
end;

points=[num GCP(1:size(num,1),:) Imagecoord(:,2:3)];
 
[Resection_param,Residuals,Cx]=SpaceResection(points,f,xo,yo,m);
omega=Resection_param(1);
phi=Resection_param(2);
kappa=Resection_param(3);
XC=Resection_param(4);
YC=Resection_param(5);
ZC=Resection_param(6);
Resection_Parameters = [omega;phi;kappa;XC;YC;ZC];

ResidualX=[];ResidualY=[];
for i=1:size(Residuals,1)/2
    ResidualX=[ResidualX;i Residuals(2*i-1)];
    ResidualY=[ResidualY;i Residuals(2*i)];
end;
R_max_x = max(abs(ResidualX(:,2)));
R_min_x = min(abs(ResidualX(:,2)));
R_max_y = max(abs(ResidualY(:,2)));
R_min_y = min(abs(ResidualY(:,2)));
var_residual_x=std(ResidualX(:,2));
var_residual_y=std(ResidualY(:,2));
handles.Left_Resection_Parameters=Resection_Parameters;
guidata(hObject,handles);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Resection_Parameters=handles.Left_Resection_Parameters;
[FileName,Path] = uiputfile('.txt','Save file name');
cd(Path)
dlmwrite(FileName, Resection_Parameters,'delimiter',' ','newline','pc','precision',8)
cd(CurrentDirectory)

function T3_Callback(hObject, eventdata, handles)
% hObject    handle to T3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T3 as text
%        str2double(get(hObject,'String')) returns contents of T3 as a double


% --- Executes during object creation, after setting all properties.
function T3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
Camera_Parameters = handles.Camera_Parameters_Right;
Chessboard_Refined_Coordinates = handles.Right_Chessboard_Refined_Coordinates;

[FileName,PathName] = uigetfile('*.xyz','Pick GCP');
ground_Control_Points_coordinates = importdata([PathName FileName]);
GCP=ground_Control_Points_coordinates(:,2:4);
f   = Camera_Parameters(1);
xo=0;
yo=0;
Imagecoord=Chessboard_Refined_Coordinates; 
num=[];
[m,n]=size(Imagecoord);
for i=1:m
    num=[num;i];
end;

points=[num GCP(1:size(num,1),:) Imagecoord(:,2:3)];
 
[Resection_param,Residuals,Cx]=SpaceResection(points,f,xo,yo,m);
omega=Resection_param(1);
phi=Resection_param(2);
kappa=Resection_param(3);
XC=Resection_param(4);
YC=Resection_param(5);
ZC=Resection_param(6);
Resection_Parameters = [omega;phi;kappa;XC;YC;ZC];

ResidualX=[];ResidualY=[];
for i=1:size(Residuals,1)/2
    ResidualX=[ResidualX;i Residuals(2*i-1)];
    ResidualY=[ResidualY;i Residuals(2*i)];
end;
R_max_x = max(abs(ResidualX(:,2)));
R_min_x = min(abs(ResidualX(:,2)));
R_max_y = max(abs(ResidualY(:,2)));
R_min_y = min(abs(ResidualY(:,2)));
var_residual_x=std(ResidualX(:,2));
var_residual_y=std(ResidualY(:,2));
handles.Right_Resection_Parameters=Resection_Parameters;
guidata(hObject,handles);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Resection_Parameters=handles.Right_Resection_Parameters;
[FileName,Path] = uiputfile('.txt','Save file name');
cd(Path)
dlmwrite(FileName, Resection_Parameters,'delimiter',' ','newline','pc','precision',8)
cd(CurrentDirectory)

function T4_Callback(hObject, eventdata, handles)
% hObject    handle to T4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T4 as text
%        str2double(get(hObject,'String')) returns contents of T4 as a double


% --- Executes during object creation, after setting all properties.
function T4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ThIMG_1=handles.Left_Thereshold1;
ThIMG_2=handles.Left_Thereshold2;
TH_IMG=(ThIMG_1+ThIMG_2)/2;
IMG_1=handles.Left_IMG_Code_1;
IMG_2=handles.Left_IMG_Code_2;
IMG_3=handles.Left_IMG_Code_3;
IMG_4=handles.Left_IMG_Code_4;
IMG_5=handles.Left_IMG_Code_5;
IMG_6=handles.Left_IMG_Code_6;
IMG_7=handles.Left_IMG_Code_7;
IMG_8=handles.Left_IMG_Code_8;
THR=str2double(get(handles.T5,'string'));
Code1=(IMG_1>TH_IMG)&(TH_IMG>THR);
Code{1}=Code1;
Code2=(IMG_2>TH_IMG)&(TH_IMG>THR);
Code{2}=Code2;
Code3=(IMG_3>TH_IMG)&(TH_IMG>THR);
Code{3}=Code3;
Code4=(IMG_4>TH_IMG)&(TH_IMG>THR);
Code{4}=Code4;
Code5=(IMG_5>TH_IMG)&(TH_IMG>THR);
Code{5}=Code5;
Code6=(IMG_6>TH_IMG)&(TH_IMG>THR);
Code{6}=Code6;
Code7=(IMG_7>TH_IMG)&(TH_IMG>THR);
Code{7}=Code7;
Code8=(IMG_8>TH_IMG)&(TH_IMG>THR);
Code{8}=Code8;
%==========================================================================
Code_IMG=(Code1*2^7)+(Code2*2^6)+(Code3*2^5)+(Code4*2^4)+(Code5*2^3)+(Code6*2^2)+(Code7*2^1)+(Code8);
%==========================================================================
colormap(jet(256));%imagesc(Code_IMG)
imagesc(Code_IMG,'parent',handles.axes1)
set(handles.axes1,'visible','off')
handles.Left_Image_Code=Code_IMG;
guidata(hObject,handles);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Code_IMG = handles.Left_Image_Code;
[FileName,Path] = uiputfile('.mat','Save file name');
cd(Path)
dlmwrite(FileName, Code_IMG ,'delimiter',' ','newline','pc','precision',8)
cd(CurrentDirectory)

function T5_Callback(hObject, eventdata, handles)
% hObject    handle to T5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T5 as text
%        str2double(get(hObject,'String')) returns contents of T5 as a double


% --- Executes during object creation, after setting all properties.
function T5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ThIMG_1=handles.Right_Thereshold1;
ThIMG_2=handles.Right_Thereshold2;
TH_IMG=(ThIMG_1+ThIMG_2)/2;
IMG_1=handles.Right_IMG_Code_1;
IMG_2=handles.Right_IMG_Code_2;
IMG_3=handles.Right_IMG_Code_3;
IMG_4=handles.Right_IMG_Code_4;
IMG_5=handles.Right_IMG_Code_5;
IMG_6=handles.Right_IMG_Code_6;
IMG_7=handles.Right_IMG_Code_7;
IMG_8=handles.Right_IMG_Code_8;
THR=str2double(get(handles.T6,'string'));
Code1=(IMG_1>TH_IMG)&(TH_IMG>THR);
Code{1}=Code1;
Code2=(IMG_2>TH_IMG)&(TH_IMG>THR);
Code{2}=Code2;
Code3=(IMG_3>TH_IMG)&(TH_IMG>THR);
Code{3}=Code3;
Code4=(IMG_4>TH_IMG)&(TH_IMG>THR);
Code{4}=Code4;
Code5=(IMG_5>TH_IMG)&(TH_IMG>THR);
Code{5}=Code5;
Code6=(IMG_6>TH_IMG)&(TH_IMG>THR);
Code{6}=Code6;
Code7=(IMG_7>TH_IMG)&(TH_IMG>THR);
Code{7}=Code7;
Code8=(IMG_8>TH_IMG)&(TH_IMG>THR);
Code{8}=Code8;
%==========================================================================
Code_IMG=(Code1*2^7)+(Code2*2^6)+(Code3*2^5)+(Code4*2^4)+(Code5*2^3)+(Code6*2^2)+(Code7*2^1)+(Code8);
%==========================================================================
colormap(jet(256));%imagesc(Code_IMG)
imagesc(Code_IMG,'parent',handles.axes1)
set(handles.axes1,'visible','off')
handles.Right_Image_Code=Code_IMG;
guidata(hObject,handles);

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Code_IMG = handles.Right_Image_Code;
[FileName,Path] = uiputfile('.mat','Save file name');
cd(Path)
dlmwrite(FileName, Code_IMG ,'delimiter',' ','newline','pc','precision',8)
cd(CurrentDirectory)


function T6_Callback(hObject, eventdata, handles)
% hObject    handle to T6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T6 as text
%        str2double(get(hObject,'String')) returns contents of T6 as a double


% --- Executes during object creation, after setting all properties.
function T6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile('*.*','Open Scan Image From Left Camera');
IMG=imread(fullfile(filepath,filename));
colormap(gray(256))
image(IMG,'parent',handles.axes1)
set(handles.axes1,'visible','off');
IMG=IMG(:,:,1);
DIMG=double(IMG);
handles.Left_IMG=IMG;
handles.Left_DIMG=DIMG;

ThIMG_1=handles.Left_Thereshold1;
ThIMG_2=handles.Left_Thereshold2;

handles.Left_Th_IMG_1=ThIMG_1;
handles.Left_Th_IMG_2=ThIMG_2;

DTh_IMG_1=double(ThIMG_1);
DTh_IMG_2=double(ThIMG_2);

handles.Left_DTh_IMG_1=DTh_IMG_1;
handles.Left_DTh_IMG_2=DTh_IMG_2;
  
guidata(hObject,handles);

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Refined_Image_Points=handles.Left_Refined_Image_Points;
Pixel_coordinates=handles.Left_Peak;
Size=handles.Size;
if Size>3
Refined_Image_Points(:,4)=Pixel_coordinates(:,4);
end 
[FileName,Path] = uiputfile('.txt','Save file name');
cd(Path)
dlmwrite(FileName, Refined_Image_Points,'delimiter',' ','newline','pc','precision', 8)
cd(CurrentDirectory)

function T7_Callback(hObject, eventdata, handles)
% hObject    handle to T7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T7 as text
%        str2double(get(hObject,'String')) returns contents of T7 as a double


% --- Executes during object creation, after setting all properties.
function T7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y]=ginput(4);
xmin=round(min(x));
xmax=round(max(x));
ymin=round(min(y));
ymax=round(max(y));
handles.Leftxmin=xmin;
handles.Leftxmax=xmax;
handles.Leftymin=ymin;
handles.Leftymax=ymax;
guidata(hObject,handles);

function T8_Callback(hObject, eventdata, handles)
% hObject    handle to T8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T8 as text
%        str2double(get(hObject,'String')) returns contents of T8 as a double


% --- Executes during object creation, after setting all properties.
function T8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end




% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IMG=handles.Left_IMG;
DIMG=handles.Left_DIMG;
Th_IMG_1=handles.Left_Th_IMG_1;
DTh_IMG_1=handles.Left_DTh_IMG_1;
Th_IMG_2=handles.Left_Th_IMG_2;
DTh_IMG_2=handles.Left_DTh_IMG_2;
Code_IMG=handles.Left_Image_Code;
xmin=handles.Leftxmin;
xmax=handles.Leftxmax;
ymin=handles.Leftymin;
ymax=handles.Leftymax;
THR1=str2double(get(handles.T7,'string'));
THR2=str2double(get(handles.T8,'string'));
% TH_IMG=(Th_IMG_1+Th_IMG_2)/2;
% DTH_IMG=(DTh_IMG_1+DTh_IMG_2)/2;
TH_IMG=Th_IMG_1;
DTH_IMG=DTh_IMG_1;
IMG1=IMG-TH_IMG;
DIMG1=DIMG-DTH_IMG;
IMG=IMG1;
[R,C]=size(IMG);
[R1,C1]=find(IMG<10);
S=size(R1);
for i=1:S
    IMG(R1(i),C1(i))=0;
    DIMG(R1(i),C1(i))=0;
end;

[Peak,Row] = CenterLine_Pixel_SimplePeak(DIMG,xmin,xmax,ymin,ymax,THR1,THR2,Code_IMG);
figure(2);imshow(IMG);hold on;plot(Peak(:,3),Peak(:,2),'.y')
handles.Left_Peak=Peak;
handles.Left_Row=Row;
handles.Left_DIMG=DIMG;
guidata(hObject,handles);

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Row=handles.Left_Row;
DIMG=handles.Left_DIMG;
[Peak,White_Col,Temp,r_max,pos,r,search,p_bf,YC] = CenterLine_Pixel_Correlation(DIMG,Row);
figure(2);hold on;plot(Peak(:,3),Peak(:,2),'.r')
handles.Left_Peak=Peak;
handles.Left_White_Col=White_Col;
handles.Left_Temp=Temp;
handles.Left_r_max=r_max;
handles.Left_pos=pos;
handles.Left_r=r;
handles.Left_search=search;
handles.Left_p_bf=p_bf;
handles.Left_YC=YC;
guidata(hObject,handles);

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DIMG=handles.Left_DIMG;
White_Col=handles.Left_White_Col;
Temp=handles.Left_Temp;
r_max=handles.Left_r_max;
pos=handles.Left_pos;
r=handles.Left_r;
search=handles.Left_search;
p_bf=handles.Left_p_bf;
YC=handles.Left_YC;
Peak = CenterLine_SubPixel_LSM(DIMG,White_Col,Temp,r_max,pos,r,search,p_bf,YC);
figure(2);hold on;plot(Peak(:,3),Peak(:,2),'.g')
handles.Left_Peak=Peak;
guidata(hObject,handles);

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile('*.*','Open Scan Image From Right Camera');
IMG=imread(fullfile(filepath,filename));
colormap(gray(256))
image(IMG,'parent',handles.axes1)
set(handles.axes1,'visible','off');
IMG=IMG(:,:,1);
DIMG=double(IMG);
handles.Right_IMG=IMG;
handles.Right_DIMG=DIMG;

ThIMG_1=handles.Right_Thereshold1;
ThIMG_2=handles.Right_Thereshold2;

handles.Right_Th_IMG_1=ThIMG_1;
handles.Right_Th_IMG_2=ThIMG_2;

DTh_IMG_1=double(ThIMG_1);
DTh_IMG_2=double(ThIMG_2);

handles.Right_DTh_IMG_1=DTh_IMG_1;
handles.Right_DTh_IMG_2=DTh_IMG_2;
  
guidata(hObject,handles);

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Refined_Image_Points=handles.Right_Refined_Image_Points;
Pixel_coordinates=handles.Right_Peak;
Size=handles.Size;
if Size>3
Refined_Image_Points(:,4)=Pixel_coordinates(:,4);
end 
[FileName,Path] = uiputfile('.txt','Save file name');
cd(Path)
dlmwrite(FileName, Refined_Image_Points,'delimiter',' ','newline','pc','precision', 8)
cd(CurrentDirectory)

function T9_Callback(hObject, eventdata, handles)
% hObject    handle to T9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T9 as text
%        str2double(get(hObject,'String')) returns contents of T9 as a double


% --- Executes during object creation, after setting all properties.
function T9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y]=ginput(4);
xmin=round(min(x));
xmax=round(max(x));
ymin=round(min(y));
ymax=round(max(y));
handles.Rightxmin=xmin;
handles.Rightxmax=xmax;
handles.Rightymin=ymin;
handles.Rightymax=ymax;
guidata(hObject,handles);


function T10_Callback(hObject, eventdata, handles)
% hObject    handle to T10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T10 as text
%        str2double(get(hObject,'String')) returns contents of T10 as a double


% --- Executes during object creation, after setting all properties.
function T10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IMG=handles.Right_IMG;
DIMG=handles.Right_DIMG;
Th_IMG_1=handles.Right_Th_IMG_1;
DTh_IMG_1=handles.Right_DTh_IMG_1;
Th_IMG_2=handles.Right_Th_IMG_2;
DTh_IMG_2=handles.Right_DTh_IMG_2;
Code_IMG=handles.Right_Image_Code;
xmin=handles.Rightxmin;
xmax=handles.Rightxmax;
ymin=handles.Rightymin;
ymax=handles.Rightymax;
THR1=str2double(get(handles.T9,'string'));
THR2=str2double(get(handles.T10,'string'));
% TH_IMG=(Th_IMG_1+Th_IMG_2)/2;
% DTH_IMG=(DTh_IMG_1+DTh_IMG_2)/2;
TH_IMG=Th_IMG_1;
DTH_IMG=DTh_IMG_1;
IMG1=IMG-TH_IMG;
DIMG1=DIMG-DTH_IMG;
IMG=IMG1;
[R,C]=size(IMG);
[R1,C1]=find(IMG<10);
S=size(R1);
for i=1:S
    IMG(R1(i),C1(i))=0;
    DIMG(R1(i),C1(i))=0;
end;

[Peak,Row] = CenterLine_Pixel_SimplePeak(DIMG,xmin,xmax,ymin,ymax,THR1,THR2,Code_IMG);
figure(1);imshow(IMG);hold on;plot(Peak(:,3),Peak(:,2),'.y')
handles.Right_Peak=Peak;
handles.Right_Row=Row;
handles.Right_DIMG=DIMG;
guidata(hObject,handles);

% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Row=handles.Right_Row;
DIMG=handles.Right_DIMG;
[Peak,White_Col,Temp,r_max,pos,r,search,p_bf,YC] = CenterLine_Pixel_Correlation(DIMG,Row);
figure(1);hold on;plot(Peak(:,3),Peak(:,2),'.r')
handles.Right_Peak=Peak;
handles.Right_White_Col=White_Col;
handles.Right_Temp=Temp;
handles.Right_r_max=r_max;
handles.Right_pos=pos;
handles.Right_r=r;
handles.Right_search=search;
handles.Right_p_bf=p_bf;
handles.Right_YC=YC;
guidata(hObject,handles);

% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DIMG=handles.Right_DIMG;
White_Col=handles.Right_White_Col;
Temp=handles.Right_Temp;
r_max=handles.Right_r_max;
pos=handles.Right_pos;
r=handles.Right_r;
search=handles.Right_search;
p_bf=handles.Right_p_bf;
YC=handles.Right_YC;
Peak = CenterLine_SubPixel_LSM(DIMG,White_Col,Temp,r_max,pos,r,search,p_bf,YC);
figure(1);hold on;plot(Peak(:,3),Peak(:,2),'.g')
handles.Right_Peak=Peak;
guidata(hObject,handles);

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Camera_Parameters = handles.Camera_Parameters_Left;
P = handles.Left_Peak;
Peak = [P(:,1) P(:,3) P(:,2) P(:,4)];
Pixel_coordinates=Peak;
Size=size(Pixel_coordinates,2);
PixelSize=Camera_Parameters(14);
u0=Camera_Parameters(15);
v0=Camera_Parameters(16);
%Convert pixle coordinates to Image coordinates
disp('Converting From Pixle Coordinates To Raw Image coordinates')
Raw_Image_Points_coordinates=Pix2Img(Pixel_coordinates,u0,v0,PixelSize);
Camera_num=36939;

if Camera_num=='Load Canon PowerShot G3 36939'
    Calibration_Parameters(1,1)=36939;
else
    Calibration_Parameters(1,1)=36940;
end;
for i=2:10
Calibration_Parameters(i,1)=Camera_Parameters(i,1);
end;
disp('Converting From Raw Image Coordinates To Refiend Image Coordinate')
[Refined_Image_Points]=Image_Point_Refinement(Raw_Image_Points_coordinates,Calibration_Parameters);
handles.Left_Refined_Image_Points=Refined_Image_Points;
handles.Size=Size;
guidata(hObject,handles);

% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Camera_Parameters = handles.Camera_Parameters_Right;
P = handles.Right_Peak;
Peak = [P(:,1) P(:,3) P(:,2) P(:,4)];
Pixel_coordinates=Peak;
Size=size(Pixel_coordinates,2);
PixelSize=Camera_Parameters(14);
u0=Camera_Parameters(15);
v0=Camera_Parameters(16);
%Convert pixle coordinates to Image coordinates
disp('Converting From Pixle Coordinates To Raw Image coordinates')
Raw_Image_Points_coordinates=Pix2Img(Pixel_coordinates,u0,v0,PixelSize);
Camera_num=36940;

if Camera_num=='Load Canon PowerShot G3 36939'
    Calibration_Parameters(1,1)=36939;
else
    Calibration_Parameters(1,1)=36940;
end;
for i=2:10
Calibration_Parameters(i,1)=Camera_Parameters(i,1);
end;
disp('Converting From Raw Image Coordinates To Refiend Image Coordinate')
[Refined_Image_Points]=Image_Point_Refinement(Raw_Image_Points_coordinates,Calibration_Parameters);
handles.Right_Refined_Image_Points=Refined_Image_Points;
handles.Size=Size;
guidata(hObject,handles);

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Left_Resection_Parameters=handles.Left_Resection_Parameters;
Right_Resection_Parameters=handles.Right_Resection_Parameters;
Camera_Parameters_Left = handles.Camera_Parameters_Left;
Camera_Parameters_Right = handles.Camera_Parameters_Right;
Refined_Image_Points_coordinates_L = handles.Left_Chessboard_Refined_Coordinates;
Refined_Image_Points_coordinates_R = handles.Right_Chessboard_Refined_Coordinates;

fL  = Camera_Parameters_Left(1);
fR  = Camera_Parameters_Right(1);

Optical_Center_L=Left_Resection_Parameters(4:6);
Rotation_Vector_L=Left_Resection_Parameters(1:3);

Optical_Center_R=Right_Resection_Parameters(4:6);
Rotation_Vector_R=Right_Resection_Parameters(1:3);

refined_image_point_left=Refined_Image_Points_coordinates_L(:,2:3);
refined_image_point_left=refined_image_point_left';
refined_image_point_left_homogen=get_homg(refined_image_point_left);
handles.refined_image_point_left=refined_image_point_left;

refined_image_point_right=Refined_Image_Points_coordinates_R(:,2:3);
refined_image_point_right=refined_image_point_right';
refined_image_point_right_homogen=get_homg(refined_image_point_right);
handles.refined_image_point_right=refined_image_point_right;

x1=refined_image_point_left;
x2=refined_image_point_right;

Mini=[x1;x2];

x1(3,:)=-fL;
x2(3,:)=-fR;
[E,R,T,meanE,stddevE,minimE,maximE,MinParalax,MaxParalax]=EssentialMtrix_Calculation(fL,fR,x1,x2,Optical_Center_L,Rotation_Vector_L,Optical_Center_R,Rotation_Vector_R);
handles.Rotation=R;
handles.Translation=T;
handles.Essential_Matrix=E;
handles.maximE=maximE;
guidata(hObject,handles);

% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
E=handles.Essential_Matrix;
maximE=handles.maximE;
R=handles.Rotation;
T=handles.Translation;
[FileName,Path] = uiputfile('.txt','Save File Name For Essential Matrix');
cd(Path)
dlmwrite(FileName,E,'delimiter',' ','newline','pc','precision', 8)
[FileName,Path] = uiputfile('.txt','Save File Name For Maximum Distance Thereshold');
cd(Path)
dlmwrite(FileName,maximE,'delimiter',' ','newline','pc','precision', 8)
[FileName,Path] = uiputfile('.txt','Save File Name For Rotation Matrix');
cd(Path)
dlmwrite(FileName,R,'delimiter',' ','newline','pc','precision', 8)
[FileName,Path] = uiputfile('.txt','Save File Name For Translation Vector');
cd(Path)
dlmwrite(FileName,T,'delimiter',' ','newline','pc','precision', 8)
cd(CurrentDirectory)

% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
E=handles.Essential_Matrix;
maximE=handles.maximE;
Camera_Parameters_Left = handles.Camera_Parameters_Left;
Camera_Parameters_Right = handles.Camera_Parameters_Right;

fL  = Camera_Parameters_Left(1);
fR  = Camera_Parameters_Right(1);
[FileName,PathName] = uigetfile('*.txt','Load Refined Image Point coordinates For Left Scan Image');
Ref_Points_Left = importdata([PathName FileName]);
[FileName,PathName] = uigetfile('*.txt','Load Refined Image Point coordinates For Right Scan Image');
Ref_Points_Right = importdata([PathName FileName]);

Match_Set = Matching_Progress (Ref_Points_Left,Ref_Points_Right,E,fL,fR,maximE);
handles.Match_Set=Match_Set;
guidata(hObject,handles);

% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Match_Set=handles.Match_Set;
[FileName,Path] = uiputfile('.txt','Save file name');
cd(Path)
dlmwrite(FileName,Match_Set,'delimiter',' ','newline','pc','precision', 8)
cd(CurrentDirectory)


% --------------------------------------------------------------------
function ImportCodingImage_Left_Callback(hObject, eventdata, handles)
% hObject    handle to ImportCodingImage_Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
[FileName,PathName] = uigetfile('*.mat','Load Left Coding Image');
cd(PathName)
Code_IMG=load('-ascii',FileName);
handles.Left_Image_Code=Code_IMG;
cd(CurrentDirectory)
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportRefinedImagePointCoordinates_Left_Callback(hObject, eventdata, handles)
% hObject    handle to ImportRefinedImagePointCoordinates_Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Refined Image Point Coordinates For Left Scan Image');
Ref_Points_Left = importdata([PathName FileName]);
handles.Left_Refined_Image_Points=Ref_Points_Left;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportCodingImage_Right_Callback(hObject, eventdata, handles)
% hObject    handle to ImportCodingImage_Right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
[FileName,PathName] = uigetfile('*.mat','Load Right Coding Image');
cd(PathName)
Code_IMG=load('-ascii',FileName);
handles.Right_Image_Code=Code_IMG;
cd(CurrentDirectory)
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportRefinedImagePointCoordinates_Right_Callback(hObject, eventdata, handles)
% hObject    handle to ImportRefinedImagePointCoordinates_Right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Refined Image Point Coordinates For Left Scan Image');
Ref_Points_Right = importdata([PathName FileName]);
handles.Right_Refined_Image_Points=Ref_Points_Right;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportEssentialMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to ImportEssentialMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Refined Image Point Coordinates For Left Scan Image');
E = importdata([PathName FileName]);
handles.Essential_Matrix=E;
guidata(hObject,handles);
% --------------------------------------------------------------------
function ImportMaximumDistanceThereshold_Callback(hObject, eventdata, handles)
% hObject    handle to ImportMaximumDistanceThereshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Refined Image Point Coordinates For Left Scan Image');
maximE = importdata([PathName FileName]);
handles.maximE=maximE;
guidata(hObject,handles);

% --------------------------------------------------------------------
function LeftCamera_Callback(hObject, eventdata, handles)
% hObject    handle to LeftCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function RightCamera_Callback(hObject, eventdata, handles)
% hObject    handle to RightCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function RelativeOrientation_Callback(hObject, eventdata, handles)
% hObject    handle to RelativeOrientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Data_Transfer_Callback(hObject, eventdata, handles)
% hObject    handle to Data_Transfer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function ImportRefinedCornerPoints_Left_Callback(hObject, eventdata, handles)
% hObject    handle to ImportRefinedCornerPoints_Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Image Control point coordinates');
Image_Points_coordinates = importdata([PathName FileName]);
image_control_point=Image_Points_coordinates;
handles.Left_Chessboard_Refined_Coordinates=image_control_point;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportResectionParameters_Left_Callback(hObject, eventdata, handles)
% hObject    handle to ImportResectionParameters_Left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Resection Parameters Of Left Image');
Resection_Parameters = importdata([PathName FileName]);
handles.Left_Resection_Parameters=Resection_Parameters;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportRefinedCornerPoints_Right_Callback(hObject, eventdata, handles)
% hObject    handle to ImportRefinedCornerPoints_Right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Image Control point coordinates');
Image_Points_coordinates = importdata([PathName FileName]);
image_control_point=Image_Points_coordinates;
handles.Right_Chessboard_Refined_Coordinates=image_control_point;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportResectionParameters_Right_Callback(hObject, eventdata, handles)
% hObject    handle to ImportResectionParameters_Right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Resection Parameters Of Left Image');
Resection_Parameters = importdata([PathName FileName]);
handles.Right_Resection_Parameters=Resection_Parameters;
guidata(hObject,handles);

% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Exterrior_Parameters_Left=handles.Left_Resection_Parameters;
Exterrior_Parameters_Right=handles.Right_Resection_Parameters;
Camera_Parameters_Left = handles.Camera_Parameters_Left;
Camera_Parameters_Right = handles.Camera_Parameters_Right;
fL  = Camera_Parameters_Left(1);
fR  = Camera_Parameters_Right(1);
Matched_Points = handles.Match_Set;
M_Point_L=Matched_Points(:,1:2);
M_Point_R=Matched_Points(:,3:4);

[Point3D]=SpaceIntersection(fL,fR,M_Point_L,M_Point_R,Exterrior_Parameters_Left,Exterrior_Parameters_Right);
%==========================================================================
figure(1); hold on;
plot3(Point3D(:,1,1),Point3D(:,2,1),Point3D(:,3,1),'k.','MarkerSize',4); 
xlabel('x'); ylabel('y'); zlabel('z');

plot3(Exterrior_Parameters_Left(4),Exterrior_Parameters_Left(5),Exterrior_Parameters_Left(6),'r.','MarkerSize',60);
plot3(Exterrior_Parameters_Right(4),Exterrior_Parameters_Right(5),Exterrior_Parameters_Right(6),'r.','MarkerSize',60);
title('Euclidean reconstruction from two views'); 

view(220,20); box on; grid off; axis equal; 
%==========================================================================
handles.Point3D=Point3D;
guidata(hObject,handles);

% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CurrentDirectory
Point3D = handles.PointCloud;
[FileName,Path] = uiputfile('.txt','Save file name');
cd(Path)
dlmwrite(FileName,Point3D,'delimiter',' ','newline','pc','precision', 8)
cd(CurrentDirectory)

% --- Executes during object creation, after setting all properties.
function pushbutton35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function pushbutton35_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function T11_Callback(hObject, eventdata, handles)
% hObject    handle to T11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T11 as text
%        str2double(get(hObject,'String')) returns contents of T11 as a double


% --- Executes during object creation, after setting all properties.
function T11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Exterrior_Parameters_Left=handles.Left_Resection_Parameters;
Exterrior_Parameters_Right=handles.Right_Resection_Parameters;
Point3D=handles.Point3D;
Sigma=str2double(get(handles.T11,'string'));
S=size(Point3D,1);
ZPoint=Point3D(:,3);
ZMean=mean(ZPoint);
ZStd=std(ZPoint);
P3D=[];
for i=1:S
if (((ZPoint(i)-ZMean)<Sigma*ZStd)&((ZPoint(i)-ZMean)>-Sigma*ZStd))
P3D=[P3D;Point3D(i,:)];
end
end
%==========================================================================
figure(2); hold on;
plot3(P3D(:,1,1),P3D(:,2,1),P3D(:,3,1),'k.','MarkerSize',4); 
xlabel('x'); ylabel('y'); zlabel('z');

plot3(Exterrior_Parameters_Left(4),Exterrior_Parameters_Left(5),Exterrior_Parameters_Left(6),'r.','MarkerSize',60);
plot3(Exterrior_Parameters_Right(4),Exterrior_Parameters_Right(5),Exterrior_Parameters_Right(6),'r.','MarkerSize',60);
title('Euclidean reconstruction from two views'); 

view(220,20); box on; grid off; axis equal; 
%==========================================================================
handles.PointCloud=P3D;
guidata(hObject,handles);

% --------------------------------------------------------------------
function ImportMatchedPointSet_Callback(hObject, eventdata, handles)
% hObject    handle to ImportMatchedPointSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.txt','Load Raw Image point coordinates');
Matched_Points = importdata([PathName FileName]);
handles.Match_Set=Matched_Points;
guidata(hObject,handles);



% --------------------------------------------------------------------
function PAN_Callback(hObject, eventdata, handles)
% hObject    handle to PAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function VIEW_Callback(hObject, eventdata, handles)
% hObject    handle to VIEW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes during object creation, after setting all properties.
function pushbutton20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function uipanel11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


