function varargout = CornerDetection_And_ImageRefinement_GUI(varargin)
% CORNERDETECTION_AND_IMAGEREFINEMENT_GUI M-file for CornerDetection_And_ImageRefinement_GUI.fig
%      CORNERDETECTION_AND_IMAGEREFINEMENT_GUI, by itself, creates a new CORNERDETECTION_AND_IMAGEREFINEMENT_GUI or raises the existing
%      singleton*.
%
%      H = CORNERDETECTION_AND_IMAGEREFINEMENT_GUI returns the handle to a new CORNERDETECTION_AND_IMAGEREFINEMENT_GUI or the handle to
%      the existing singleton*.
%
%      CORNERDETECTION_AND_IMAGEREFINEMENT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CORNERDETECTION_AND_IMAGEREFINEMENT_GUI.M with the given input arguments.
%
%      CORNERDETECTION_AND_IMAGEREFINEMENT_GUI('Property','Value',...) creates a new CORNERDETECTION_AND_IMAGEREFINEMENT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CornerDetection_And_ImageRefinement_GUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CornerDetection_And_ImageRefinement_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help CornerDetection_And_ImageRefinement_GUI

% Last Modified by GUIDE v2.5 07-Sep-2019 14:06:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CornerDetection_And_ImageRefinement_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CornerDetection_And_ImageRefinement_GUI_OutputFcn, ...
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


% --- Executes just before CornerDetection_And_ImageRefinement_GUI is made visible.
function CornerDetection_And_ImageRefinement_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CornerDetection_And_ImageRefinement_GUI (see VARARGIN)

% Choose default command line output for CornerDetection_And_ImageRefinement_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CornerDetection_And_ImageRefinement_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CornerDetection_And_ImageRefinement_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function OpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to OpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile('*.*','open image');
 IMG=imread(fullfile(filepath,filename));
 colormap(gray(250))
 image(IMG,'parent',handles.axes1)
 set(handles.axes1,'visible','off');
 handles.IMG=IMG;
 guidata(hObject,handles);

% --------------------------------------------------------------------
function FILE_Callback(hObject, eventdata, handles)
% hObject    handle to FILE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in Manual_Extraction.
function Manual_Extraction_Callback(hObject, eventdata, handles)
% hObject    handle to Manual_Extraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
format long g
I=handles.IMG;
Xim=[];press=0;RGB_Th=[];
for i=1:4
[x y]=ginput(1);
press=press+1;
x=round(x);y=round(y);
Xim=[Xim;x y];
hold on;plot(x,y,'+');
end;
handles.Xim=Xim;
guidata(hObject,handles);

% --- Executes on button press in Corner_Extraction.
function Corner_Extraction_Callback(hObject, eventdata, handles)
% hObject    handle to Corner_Extraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fid_coord=handles.Xim;
Plate_num=handles.Plate_num;
calib_coord=[125 125;125 425;425 125;425 425];
[p]=Projective(calib_coord,fid_coord);
corn=[];
for j=1:10
    for i=1:10
    x=(p(1)*(i*50)+p(2)*(j*50)+p(3))/(p(7)*(i*50)+p(8)*(j*50)+1);
    y=(p(4)*(i*50)+p(5)*(j*50)+p(6))/(p(7)*(i*50)+p(8)*(j*50)+1);
    hold on
    plot(x,y,'.g')
    corn=[corn;x y];
    end;
end;
hold on
plot(corn(:,1),corn(:,2),'.g')
Npoint=size(corn,1);
corner=[];
if Plate_num == 'A'
    for i=1:Npoint
        corner=[corner;i corn(i,1) corn(i,2)];
    end;
elseif Plate_num == 'B'
    for i=1:Npoint
        corner=[corner;i+Npoint corn(i,1) corn(i,2)];
    end;
elseif Plate_num == 'C'
    for i=1:Npoint
        corner=[corner;i+2*Npoint corn(i,1) corn(i,2)];  
    end;
end;

handles.corner=corner;
guidata(hObject,handles);

% --- Executes on button press in Exact_Corner.
function Exact_Corner_Callback(hObject, eventdata, handles)
% hObject    handle to Exact_Corner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=handles.IMG;
I=im2double(I);
I=rgb2gray(I);
w=50;
corner=handles.corner;
 [xc,good,bad,type] = cornerfinder(corner(:,2:3)',I);
 xc=xc';
 X=xc(:,1);
 Y=xc(:,2);
 exact_corner=[corner(:,1) X Y];
 for i=1:size(exact_corner,1)
  text(exact_corner(i,2)+3,exact_corner(i,3)+3,['\leftarrow',num2str(corner(i,1))],'FontSize',7)% 'EdgeColor','red','LineWidth',2,'EdgeColor','yellow',...
          %'FontSize',5,'BackgroundColor',[.7 .9 .7]);
 end;
 hold on
 plot(X,Y,'.r','MarkerSize',5); 
 handles.exact_corner= exact_corner;
 handles.Size=size(exact_corner,2);
guidata(hObject,handles);




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in Save_Raw_Coordinates.
function Save_Raw_Coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to Save_Raw_Coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FileName =(get(handles.edit1,'string'));
exact_corner=handles.exact_corner;
handles.Pixel_coordinates=exact_corner;
dlmwrite(FileName, exact_corner,'delimiter',' ','newline','pc','precision',8)
guidata(hObject,handles);

% --------------------------------------------------------------------
function ZOOMIN_Callback(hObject, eventdata, handles)
% hObject    handle to ZOOMIN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom on

% --------------------------------------------------------------------
function VIEW_Callback(hObject, eventdata, handles)
% hObject    handle to VIEW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function ZOOMOUT_Callback(hObject, eventdata, handles)
% hObject    handle to ZOOMOUT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom out



% --------------------------------------------------------------------
function ZOOMOFF_Callback(hObject, eventdata, handles)
% hObject    handle to ZOOMOFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom off



% --------------------------------------------------------------------
function PAN_Callback(hObject, eventdata, handles)
% hObject    handle to PAN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pan



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'value');
str=get(hObject,'string');
switch str{val}
    case 'PowerShot G3 36939'
        Camera_num='Load Canon PowerShot G3 36939';
    case 'PowerShot G3 36940'
        Camera_num='Load Canon PowerShot G3 36940';
    case 'ZED Left'
        Camera_num='ZED Left';
    case 'ZED Right'
        Camera_num='ZED Right';
        
end
handles.Camera_num=Camera_num;
guidata(hObject,handles);
% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Camera_num = handles.Camera_num;
[FileName,PathName] = uigetfile('*.txt',Camera_num);
Camera_Parameters = importdata([PathName FileName]);

   C   = Camera_Parameters(1);    
   XP  = Camera_Parameters(2);
   YP  = Camera_Parameters(3);
   K1  = Camera_Parameters(4);
   K2  = Camera_Parameters(5);
   K3  = Camera_Parameters(6);
   P1  = Camera_Parameters(7);
   P2  = Camera_Parameters(8);
   B1  = Camera_Parameters(9);
   B2  = Camera_Parameters(10);
   H   = Camera_Parameters(11);
   V   = Camera_Parameters(12);
   Sx  = Camera_Parameters(13);
   Sy  = Camera_Parameters(14);
   
   % u0,v0 are coordinates of center of Image in Pixel coordinate system
   u0  = H/2+0.5;
   v0  = V/2+0.5;
   Camera_Parameters(15)=u0;
   Camera_Parameters(16)=v0;
     
   set(handles.T1,'string',V);
   set(handles.T2,'string',H);
   set(handles.T3,'string',Sx);
   set(handles.T4,'string',Sy);
   set(handles.T5,'string',C);
   set(handles.T6,'string',XP);
   set(handles.T7,'string',YP);
   set(handles.T8,'string',K1);
   set(handles.T9,'string',K2);
   set(handles.T10,'string',K3);
   set(handles.T11,'string',P1);
   set(handles.T12,'string',P2);
   set(handles.T13,'string',B1);
   set(handles.T14,'string',B2);
   set(handles.T15,'string',u0);
   set(handles.T16,'string',v0);
       
handles.Camera_Parameters=Camera_Parameters;
guidata(hObject,handles);



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Camera_Parameters=handles.Camera_Parameters;
Pixel_coordinates=handles.Pixel_coordinates;
PixelSize=Camera_Parameters(14);
u0=Camera_Parameters(15);
v0=Camera_Parameters(16);
%Convert pixle coordinates to Image coordinates
disp('Converting From Pixle Coordinates To Raw Image coordinates')
Raw_Image_Points_coordinates=Pix2Img(Pixel_coordinates,u0,v0,PixelSize);
handles.Raw_Image_Points_coordinates=Raw_Image_Points_coordinates;
guidata(hObject,handles);


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
FileName2 =(get(handles.edit3,'string'));
Raw_Image_Points_coordinates=handles.Raw_Image_Points_coordinates;
dlmwrite(FileName2, Raw_Image_Points_coordinates,'delimiter',' ','newline','pc','precision', 8)

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Camera_num=handles.Camera_num;
Camera_Parameters=handles.Camera_Parameters;
Raw_Image_Points_coordinates=handles.Raw_Image_Points_coordinates;

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
handles.Refined_Image_Points=Refined_Image_Points;
guidata(hObject,handles);


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
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
FileName =(get(handles.edit4,'string'));
Refined_Image_Points=handles.Refined_Image_Points;
Size=handles.Size;
if Size>3
Pixel_coordinates=handles.Pixel_coordinates;
Refined_Image_Points(:,4)=Pixel_coordinates(:,4);
end
dlmwrite(FileName, Refined_Image_Points,'delimiter',' ','newline','pc','precision', 8)


% --------------------------------------------------------------------
function Import_Pixel_Coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to Import_Pixel_Coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
format short g
[FileName,PathName] = uigetfile('*.txt','Load Pixel Coordinates');
Pixel_coordinates = importdata([PathName FileName]);
handles.Pixel_coordinates=Pixel_coordinates;
handles.Size=size(Pixel_coordinates,2);
guidata(hObject,handles);
% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --------------------------------------------------------------------
function SSSS_Callback(hObject, eventdata, handles)
% hObject    handle to SSSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'value');
str=get(hObject,'string');
switch str{val}
    case 'Plate A'
        Plate_num='A';
    case 'Plate B'
        Plate_num='B';
    case 'Plate C'
        Plate_num='C';
        
end
handles.Plate_num=Plate_num;
guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
