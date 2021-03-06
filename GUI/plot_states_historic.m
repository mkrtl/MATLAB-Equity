
function varargout = plot_states_historic(varargin)
% PLOT_STATES_HISTORIC MATLAB code for plot_states_historic.fig
%      PLOT_STATES_HISTORIC, by itself, creates a new PLOT_STATES_HISTORIC or raises the existing
%      singleton*.
%
%      H = PLOT_STATES_HISTORIC returns the handle to a new PLOT_STATES_HISTORIC or the handle to
%      the existing singleton*.
%
%      PLOT_STATES_HISTORIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_STATES_HISTORIC.M with the given input arguments.
%
%      PLOT_STATES_HISTORIC('Property','Value',...) creates a new PLOT_STATES_HISTORIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_states_historic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_states_historic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_states_historic

% Last Modified by GUIDE v2.5 22-Aug-2017 11:00:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_states_historic_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_states_historic_OutputFcn, ...
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


% --- Executes just before plot_states_historic is made visible.
function plot_states_historic_OpeningFcn(hObject, eventdata, handles, varargin)

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_states_historic (see VARARGIN)

% Choose default command line output for plot_states_historic
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_states_historic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_states_historic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global wbd_data_historic
global chosen_country
global year_historic


countries = get(handles.listbox1,'String');
chosen_country = countries{get(handles.listbox1,'Value')};
index_historic = find_index(wbd_data_historic,string(chosen_country));
year_historic = zeros(1,length(index_historic));
for i = 1 : length(index_historic)
    year_historic(i) = wbd_data_historic(index_historic(i)).year_of_data;
end
year_historic_cell = cellstr(string(year_historic));
set(handles.listbox2,'String',cell(year_historic_cell));
set(handles.listbox2,'Value',1);


% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global wbd_data_historic

% Generate vector of States, if not already existing: 
if isempty(wbd_data_historic)
    
    wbd_data_historic = generate_all_countries_historic_gui();
end

% Fill listbox with names of wbd_data_historic:

listbox_names = cell(1,length(wbd_data_historic));
for i = 1 : length(wbd_data_historic)
    listbox_names(i) = cellstr(wbd_data_historic(i).country);
end
listbox_names = unique(listbox_names,'stable');
% Set listbox object with names of wbd_data_historic:

set(hObject,'String',listbox_names);


% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Access global variables:

global year_historic
global indexes_used
global wbd_data_historic
guidata(hObject,handles);
axes(handles.axes1);
name = get(handles.listbox1,'String');
name = name{get(handles.listbox1,'Value')};
year = year_historic(get(handles.listbox2,'Value'));


index = find_index_year(wbd_data_historic,string(name),year);

% Indexes of wbd_data_historic used:
indexes_used(end+1) = index;
indexes_used = unique(indexes_used,'stable')

plot_standard_lorenz_gui(indexes_used,wbd_data_historic,get(handles.checkbox1,'Value'))

set(handles.listbox2,'Value',1);
% Is needed, as change of country could lead to a value of listbox2, which
% does not exist, as there are not this many datasets for this country.
% Application breaks down in these cases. 
% Value = 1 ensures every country has this value for listbox2.

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global indexes_used
indexes_used = [];

% Clear arrays, which indicate which countries were plotted.

cla(handles.axes1);
% Clear canvas, but keep options.
guidata(hObject,handles);
% Update GUI


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global indexes_used
indexes_used = [];

% Hint: delete(hObject) closes the figure
delete(hObject);


% Menu callbacks: 

% --------------------------------------------------------------------
function export_plot_Callback(hObject, eventdata, handles)
% hObject    handle to export_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global indexes_used
global wbd_data_historic

figure;

x_values = 0:0.001:1;

if get(handles.checkbox1,'Value')
    legend_entries = strings(1, 2 * length(indexes_used));

for i = 1 : length(indexes_used)
    epsilon = wbd_data_historic(indexes_used(i)).epsilon;
    plot(x_values,mixed_lorenz(x_values,epsilon,0.6));
    hold on
    plot(wbd_data_historic(indexes_used(i)).share_pop,wbd_data_historic(indexes_used(i)).cumulated_dist_vector,'+');
    legend(join([wbd_data_historic(indexes_used(i)).country, " Datapoints"]));
    hold on
end
for i = 1 : length(indexes_used)
    
    legend_entries(2*i-1) = join([wbd_data_historic(indexes_used(i)).country," ",wbd_data_historic(indexes_used(i)).year_of_data]);
    % Legend entries of Lorenz Curves
    
    legend_entries(2*i) = join(["Daten ",wbd_data_historic(indexes_used(i)).country," ",wbd_data_historic(indexes_used(i)).year_of_data]);
    % Legend entries of datapoints
end

else 
    legend_entries = strings(1, length(indexes_used));
    for i = 1 : length(indexes_used)
    epsilon = wbd_data_historic(indexes_used(i)).epsilon;
    plot(x_values,mixed_lorenz(x_values,epsilon,0.6));
    hold on
    end
    for i = 1 : length(indexes_used)
    
    legend_entries(i) = join([wbd_data_historic(indexes_used(i)).country," ",wbd_data_historic(indexes_used(i)).year_of_data]);
    % Legend entries of Lorenz Curves
    

    end
end
legend(legend_entries,'Location','Northwest')
legend('show')   
title('Standard Lorenzkurve')
xlabel('Bevölkerungsanteil x')
ylabel('Einkommensanteil')
grid on
hold off;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global indexes_used
global wbd_data_historic

delete(handles.figure1);
Plot_density_historic;
plot_standard_lorenz_density_gui(indexes_used,wbd_data_historic)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global submitted_data
global wbd_data_historic

enter_own_data;

uiwait
delete(handles.figure1);
% plot(submitted_data.share_pop,submitted_data.cumulated_dist_vector,'+')
plot_states_historic;


