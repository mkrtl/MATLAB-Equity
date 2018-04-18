function varargout = Cumulate_before_year_gui(varargin)
% CUMULATE_BEFORE_YEAR_GUI MATLAB code for Cumulate_before_year_gui.fig
%      CUMULATE_BEFORE_YEAR_GUI, by itself, creates a new CUMULATE_BEFORE_YEAR_GUI or raises the existing
%      singleton*.
%
%      H = CUMULATE_BEFORE_YEAR_GUI returns the handle to a new CUMULATE_BEFORE_YEAR_GUI or the handle to
%      the existing singleton*.
%
%      CUMULATE_BEFORE_YEAR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CUMULATE_BEFORE_YEAR_GUI.M with the given input arguments.
%
%      CUMULATE_BEFORE_YEAR_GUI('Property','Value',...) creates a new CUMULATE_BEFORE_YEAR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Cumulate_before_year_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Cumulate_before_year_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Cumulate_before_year_gui

% Last Modified by GUIDE v2.5 20-Mar-2018 17:15:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cumulate_before_year_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Cumulate_before_year_gui_OutputFcn, ...
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


% --- Executes just before Cumulate_before_year_gui is made visible.
function Cumulate_before_year_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Cumulate_before_year_gui (see VARARGIN)

% Choose default command line output for Cumulate_before_year_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Cumulate_before_year_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Cumulate_before_year_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

year = get(handles.slider1,'Value');

set(handles.text2,'String',year)

global wbd_data_historic

% Generate vector of States, if not already existing: 
if isempty(wbd_data_historic)
    
    wbd_data_historic = generate_all_countries_historic_gui();
end

% Fill listbox with names of wbd_data_historic:
wbd_data_historic_before = find_indices_before(wbd_data_historic,year);
listbox_names = cell(1,length(wbd_data_historic_before));
for i = 1 : length(wbd_data_historic_before)
    listbox_names(i) = cellstr(wbd_data_historic_before(i).country);
end
listbox_names = unique(listbox_names,'stable');
% Set listbox object with names of wbd_data_historic:

set(handles.listbox1,'String',listbox_names);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

global wbd_data_historic
global indexes_used 

indexes_used = [];

% Generate vector of States, if not already existing: 
if isempty(wbd_data_historic)
    
    wbd_data_historic = generate_all_countries_historic_gui();
end

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

listbox_names = cell(1,length(wbd_data_historic));
for i = 1 : length(wbd_data_historic)
    listbox_names(i) = cellstr(wbd_data_historic(i).country);
end
listbox_names = unique(listbox_names,'stable');
% Set listbox object with names of wbd_data_historic:

set(hObject,'String',listbox_names);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wbd_data_historic
global indexes_used
country_name = get(handles.listbox1,'String');
country_name = country_name{get(handles.listbox1,'Value')};
year = get(handles.slider1,'Value')
index = find_index_before_year(wbd_data_historic,string(country_name),year);
indexes_used = [indexes_used,index];

cumulated_obj = common_distribution(wbd_data_historic(indexes_used),"Cumulated object");

plot(cumulated_obj.share_pop,cumulated_obj.cumulated_dist_vector,'+');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
