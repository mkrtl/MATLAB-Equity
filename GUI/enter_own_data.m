function varargout = enter_own_data(varargin)
% Is used in plot_states_historic, such that a user can put in in its own
% data.

% ENTER_OWN_DATA MATLAB code for enter_own_data.fig
%      ENTER_OWN_DATA, by itself, creates a new ENTER_OWN_DATA or raises the existing
%      singleton*.
%
%      H = ENTER_OWN_DATA returns the handle to a new ENTER_OWN_DATA or the handle to
%      the existing singleton*.
%
%      ENTER_OWN_DATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENTER_OWN_DATA.M with the given input arguments.
%
%      ENTER_OWN_DATA('Property','Value',...) creates a new ENTER_OWN_DATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before enter_own_data_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to enter_own_data_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help enter_own_data

% Last Modified by GUIDE v2.5 20-Mar-2018 10:57:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @enter_own_data_OpeningFcn, ...
                   'gui_OutputFcn',  @enter_own_data_OutputFcn, ...
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


% --- Executes just before enter_own_data is made visible.
function enter_own_data_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to enter_own_data (see VARARGIN)

% Choose default command line output for enter_own_data
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes enter_own_data wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = enter_own_data_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wbd_data_historic
entered_matrix = (get(handles.uitable1,'data'));
ordered_matrix = order_income(entered_matrix(:,1),entered_matrix(:,2));
country_name = get(handles.name_country,'String')
temporary_equity = Equity(country_name,ordered_matrix(:,2),ordered_matrix(:,1));
year_data = get(handles.year_data,'String');
submitted_data = State(country_name,ordered_matrix(:,2),(1-temporary_equity.epsilon_model)/(1+temporary_equity.epsilon_model),ordered_matrix(:,1),year_data,0,0);
wbd_data_historic(end+1) = submitted_data;
delete(handles.figure1);



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

n = str2double(get(handles.edit6,'String'));
handles.uitable1.Data = zeros(n,2);



% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function name_country_Callback(hObject, eventdata, handles)
% hObject    handle to name_country (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name_country as text
%        str2double(get(hObject,'String')) returns contents of name_country as a double


% --- Executes during object creation, after setting all properties.
function name_country_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_country (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function year_data_Callback(hObject, eventdata, handles)
% hObject    handle to year_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of year_data as text
%        str2double(get(hObject,'String')) returns contents of year_data as a double


% --- Executes during object creation, after setting all properties.
function year_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to year_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
