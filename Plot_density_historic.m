function varargout = Plot_density_historic(varargin)
% PLOT_DENSITY_HISTORIC MATLAB code for Plot_density_historic.fig
%      PLOT_DENSITY_HISTORIC, by itself, creates a new PLOT_DENSITY_HISTORIC or raises the existing
%      singleton*.
%
%      H = PLOT_DENSITY_HISTORIC returns the handle to a new PLOT_DENSITY_HISTORIC or the handle to
%      the existing singleton*.
%
%      PLOT_DENSITY_HISTORIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_DENSITY_HISTORIC.M with the given input arguments.
%
%      PLOT_DENSITY_HISTORIC('Property','Value',...) creates a new PLOT_DENSITY_HISTORIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Plot_density_historic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Plot_density_historic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Plot_density_historic

% Last Modified by GUIDE v2.5 21-Aug-2017 17:02:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Plot_density_historic_OpeningFcn, ...
                   'gui_OutputFcn',  @Plot_density_historic_OutputFcn, ...
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


% --- Executes just before Plot_density_historic is made visible.
function Plot_density_historic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Plot_density_historic (see VARARGIN)

% Choose default command line output for Plot_density_historic
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global indexes_used
global wbd_data_historic
% UIWAIT makes Plot_density_historic wait for user response (see UIRESUME)
% uiwait(handles.figure1);
if ~isempty(indexes_used)
    plot_standard_lorenz_density_gui(indexes_used,wbd_data_historic);
end

% --- Outputs from this function are returned to the command line.
function varargout = Plot_density_historic_OutputFcn(hObject, eventdata, handles) 
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

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
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


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

global wbd_data_historic
wbd_data_historic = generate_all_countries_historic();
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

global year_historic
global indexes_used
global wbd_data_historic

axes(handles.axes1);
x_values = linspace(0,1,1000);
name = get(handles.listbox1,'String');
name = name{get(handles.listbox1,'Value')};
year = get(handles.listbox2,'String');
%year = year{get(handles.listbox2,'Value')};
year = year_historic(get(handles.listbox2,'Value'));


index = find_index_year(wbd_data_historic,string(name),year);

% Indexes of wbd_data_historic used:
indexes_used(end+1) = index;

% Find unique values of indexes_used, such that every object is just
% plotted once: 

indexes_used = unique(indexes_used,'stable');

% Plot standard lorenz density according to following function: 

plot_standard_lorenz_density_gui(indexes_used,wbd_data_historic);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global indexes_used
indexes_used = [];
cla(handles.axes1);


% --------------------------------------------------------------------
function export_plot_Callback(hObject, eventdata, handles)
% hObject    handle to export_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global indexes_used
global wbd_data_historic

figure;
x_values = 0:0.001:1;
a = 0.6;



for i = 1 : length(indexes_used)
    
    legend_entries(i) = join([wbd_data_historic(indexes_used(i)).country," ",wbd_data_historic(indexes_used(i)).year_of_data]);
    % Legend entries of Lorenz Curves
    plot(x_values,mixed_lorenz_density(x_values,wbd_data_historic(indexes_used(i)).epsilon,a))
    hold on
    
end

legend(legend_entries,'Location','Northwest')
legend('show')   
title('Standard Lorenzdichte')
xlabel('Bevölkerungsanteil x')
ylabel('Vielfaches des Durchschnittseinkommens')
grid on
% Set y- Limit, such that 99 % of all x-values can be seen:
y_limit = zeros(1,length(indexes_used));
for i = 1 : length(indexes_used)
    y_limit(i) = mixed_lorenz_density(0.99,wbd_data_historic(indexes_used(i)).epsilon,a);
end
    
ylim([0 max(y_limit)]) 
% set(Fig2,'visible','off')
hold off;

function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global indexes_used
indexes_used = [];

% Hint: delete(hObject) closes the figure
delete(hObject);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_states_historic;
delete(handles.figure1);
