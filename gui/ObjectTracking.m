function varargout = ObjectTracking(varargin)
% OBJECTTRACKING MATLAB code for ObjectTracking.fig
%      OBJECTTRACKING, by itself, creates a new OBJECTTRACKING or raises the existing
%      singleton*.
%
%      H = OBJECTTRACKING returns the handle to a new OBJECTTRACKING or the handle to
%      the existing singleton*.
%
%      OBJECTTRACKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OBJECTTRACKING.M with the given input arguments.
%
%      OBJECTTRACKING('Property','Value',...) creates a new OBJECTTRACKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ObjectTracking_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ObjectTracking_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ObjectTracking

% Last Modified by GUIDE v2.5 10-Nov-2017 19:40:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ObjectTracking_OpeningFcn, ...
                   'gui_OutputFcn',  @ObjectTracking_OutputFcn, ...
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


% --- Executes just before ObjectTracking is made visible.
function ObjectTracking_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ObjectTracking (see VARARGIN)

% Choose default command line output for ObjectTracking
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ObjectTracking wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ObjectTracking_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_prev.
function pushbutton_prev_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_next.
function pushbutton_next_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton_select.
function togglebutton_select_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton_select


% --- Executes on button press in pushbutton_select.
function pushbutton_select_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton_play.
function togglebutton_play_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton_play


% --- Executes on button press in togglebutton_stop.
function togglebutton_stop_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton_stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton_stop


% --- Executes on button press in pushbutton_iterate.
function pushbutton_iterate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_iterate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton_l1norm.
function radiobutton_l1norm_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_l1norm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_l1norm


% --- Executes on button press in radiobutton_l2norm.
function radiobutton_l2norm_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_l2norm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_l2norm


% --- Executes on button press in radiobutton_gaussian.
function radiobutton_gaussian_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_gaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_gaussian


% --- Executes on button press in pushbutton_iteratemultiple.
function pushbutton_iteratemultiple_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_iteratemultiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_times_Callback(hObject, eventdata, handles)
% hObject    handle to edit_times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_times as text
%        str2double(get(hObject,'String')) returns contents of edit_times as a double


% --- Executes during object creation, after setting all properties.
function edit_times_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_open.
function pushbutton_open_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_playiterate.
function pushbutton_playiterate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_playiterate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
