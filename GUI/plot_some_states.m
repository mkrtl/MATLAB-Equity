% There are the following global variables: indexes_used, wbd_data.

function varargout = plot_some_states(varargin)
% PLOT_SOME_STATES MATLAB code for plot_some_states.fig
%      PLOT_SOME_STATES, by itself, creates a new PLOT_SOME_STATES or raises the existing
%      singleton*.
%
%      H = PLOT_SOME_STATES returns the handle to a new PLOT_SOME_STATES or the handle to
%      the existing singleton*.
%
%      PLOT_SOME_STATES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_SOME_STATES.M with the given input arguments.
%
%      PLOT_SOME_STATES('Property','Value',...) creates a new PLOT_SOME_STATES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_some_states_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_some_states_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help plot_some_states

% Last Modified by GUIDE v2.5 16-Aug-2017 10:31:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_some_states_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_some_states_OutputFcn, ...
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


% --- Executes just before plot_some_states is made visible.
function plot_some_states_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_some_states (see VARARGIN)
% Choose default command line output for plot_some_states
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Run generate_all_countries just once in the beginning and make it
% accessible for all functions in this file with the 'global' command.
% Other functions therefore do not have to run generate_all_countries 
% anymore:

global wbd_data
wbd_data = generate_all_countries();

% UIWAIT makes plot_some_states wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_some_states_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Access wbd_data:

global wbd_data

% Fill listbox with names of wbd_data:

listbox_names = cell(1,length(wbd_data));
for i = 1 : length(wbd_data)
    listbox_names(i) = cellstr(wbd_data(i).country);
end

% Set listbox object with names of wbd_data:

set(hObject,'String',listbox_names);

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
% Default lines:
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Access wbd_data:
global wbd_data

axes(handles.axes1);
x_values = linspace(0,1,1000);
A = get(handles.listbox1,'String');
name = A{get(handles.listbox1,'Value')};
index = find_index(wbd_data,string(name));


global indexes_used


% Indexes of wbd_data used:
indexes_used(end+1) = index;

% Name of the countries plotted:
country_names = strings(length(indexes_used),1);


% Fill array of country_names:

for i = 1 : length(indexes_used)
    country_names(i) = wbd_data(indexes_used(i)).country;
end

% Make sure, that every country is just plotted once, meaning it just
% appears once in indexes_used and country_names. Keep order of those
% arrays ( which is achieved by 'stable'):

indexes_used = unique(indexes_used,'stable');
country_names = unique(country_names,'stable');

% Plot datapoints and Lorenz curve seperately:

for i = 1 : length(country_names)
    epsilon = wbd_data(indexes_used(i)).epsilon;
    curves(i) = plot(x_values,mixed_lorenz(x_values,epsilon,0.6));
    hold on
    datapoints(i) = plot(wbd_data(indexes_used(i)).share_pop,wbd_data(indexes_used(i)).cumulated_dist_vector,'+');
    hold on
end

% Check for 'Datapoints'-checkbox and decide whether or not to display
% them:
if ~get(handles.checkbox1,'Value')
    set(datapoints,'Visible','Off')
else
    set(datapoints,'Visible','On')
end     
    
hold off
for i = 1 : length(country_names)
    
    legend_entries(2*i-1) = country_names(i);
    % Legend entries of Lorenz Curves
    
    legend_entries(2*i) = join(["Daten ",country_names(i)]);
    % Legend entries of datapoints
end

legend(legend_entries,'Location','Northwest')
legend('show')


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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Hint: get(hObject,'Value') returns toggle state of checkbox1
pushbutton1_Callback(hObject, eventdata, handles);

% Change of checkbox initiates a new plot, but with different settings
% regarding the datapoints. The last country is actually plotted once
% again, which is eliminated by the unique-Statement in
% Pushbutton1_Callback. 


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

% Reset the indexes_used-array such that the next time, this vector is
% empty:

global indexes_used
indexes_used = [];

% Close GUI:
delete(hObject);
