function varargout = groups_of_states(varargin)
% GROUPS_OF_STATES MATLAB code for groups_of_states.fig
%      GROUPS_OF_STATES, by itself, creates a new GROUPS_OF_STATES or raises the existing
%      singleton*.
%
%      H = GROUPS_OF_STATES returns the handle to a new GROUPS_OF_STATES or the handle to
%      the existing singleton*.
%
%      GROUPS_OF_STATES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GROUPS_OF_STATES.M with the given input arguments.
%
%      GROUPS_OF_STATES('Property','Value',...) creates a new GROUPS_OF_STATES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before groups_of_states_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to groups_of_states_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help groups_of_states

% Last Modified by GUIDE v2.5 29-Sep-2017 11:37:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @groups_of_states_OpeningFcn, ...
                   'gui_OutputFcn',  @groups_of_states_OutputFcn, ...
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


% --- Executes just before groups_of_states is made visible.
function groups_of_states_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to groups_of_states (see VARARGIN)

% Choose default command line output for groups_of_states
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes groups_of_states wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = groups_of_states_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_state.
function listbox_state_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_state contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_state

global wbd_data_historic
global chosen_country
global year_historic
global index_historic


countries = get(handles.listbox_state,'String');
chosen_country = countries{get(handles.listbox_state,'Value')};
index_historic = find_index(wbd_data_historic,string(chosen_country));
year_historic = zeros(1,length(index_historic));
for i = 1 : length(index_historic)
    year_historic(i) = wbd_data_historic(index_historic(i)).year_of_data;
end
year_historic_cell = cellstr(string(year_historic));
set(handles.listbox_year,'String',cell(year_historic_cell));
set(handles.listbox_year,'Value',1);

% --- Executes during object creation, after setting all properties.
function listbox_state_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_state (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global wbd_data_historic

% Generate vector of States, if not already existing: 

if isempty(wbd_data_historic)
    
    wbd_data_historic = generate_all_countries_historic();
end

% Fill listbox with names of wbd_data_historic:

listbox_names = cell(1,length(wbd_data_historic));
for i = 1 : length(wbd_data_historic)
    listbox_names(i) = cellstr(wbd_data_historic(i).country);
end
listbox_names = unique(listbox_names,'stable');
% Set listbox object with names of wbd_data_historic:

set(hObject,'String',listbox_names);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_year.
function listbox_year_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_year (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_year contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_year


% --- Executes during object creation, after setting all properties.
function listbox_year_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_year (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_buttom.
function add_buttom_Callback(hObject, eventdata, handles)

% hObject    handle to add_buttom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Access global variables:

global year_historic
global indexes_used
global wbd_data_historic
guidata(hObject,handles);
name = get(handles.listbox_state,'String');
name = name{get(handles.listbox_state,'Value')};
year = get(handles.listbox_year,'String');
% year = year{get(handles.listbox2,'Value')};
year = year_historic(get(handles.listbox_year,'Value'));


index = find_index_year(wbd_data_historic,string(name),year);

% Indexes of wbd_data_historic used:
indexes_used(end+1) = index;
indexes_used = unique(indexes_used,'stable')

set(handles.listbox_year,'Value',1);
grouped_states = strings(length(indexes_used),1) ; 
for i = 1 : length(indexes_used)
    grouped_states(i) = join([wbd_data_historic(indexes_used(i)).country," ",int2str(wbd_data_historic(indexes_used(i)).year_of_data)]);
end
grouped_states = cellstr(grouped_states);

% set(handles.listbox3,'String',wbd_data_historic(indexes_used(i)).country)
set(handles.listbox3,'String',grouped_states)





% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global plotted_groups
plotted_groups = [Equity("Test",0,0)];


% --- Executes on button press in pushbutton_plot_group.
function pushbutton_plot_group_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_group (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global wbd_data_historic
global indexes_used
global plotted_groups

grouped_equity = common_distribution_gui(indexes_used,wbd_data_historic)


if plotted_groups(1).country == "Test"
    
    plotted_groups(1) = grouped_equity;
else
    plotted_groups(end+1) = grouped_equity;
    
end


set(handles.listbox3,'Value',1)
set(handles.listbox3,'String',"Choose countrys")

datapoints_boolean = get(handles.checkbox_datapoints,'Value');

curves_boolean = get(handles.checkbox_curves,'Value');

plot_lorenz_groups(plotted_groups,datapoints_boolean,curves_boolean)

indexes_used = [];


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global plotted_groups
cla(handles.axes1);
indexes_used = [];
plotted_groups = Equity("Test",0,0)


% --- Executes on button press in checkbox_curves.
function checkbox_curves_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_curves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_curves
global plotted_groups

datapoints_boolean = get(handles.checkbox_datapoints,'Value');

curves_boolean = get(handles.checkbox_curves,'Value');

plot_lorenz_groups(plotted_groups,datapoints_boolean,curves_boolean)


% --- Executes on button press in checkbox_datapoints.
function checkbox_datapoints_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_datapoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global plotted_groups

datapoints_boolean = get(handles.checkbox_datapoints,'Value');

curves_boolean = get(handles.checkbox_curves,'Value');

plot_lorenz_groups(plotted_groups,datapoints_boolean,curves_boolean)
% Hint: get(hObject,'Value') returns toggle state of checkbox_datapoints

