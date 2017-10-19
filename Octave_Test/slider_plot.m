function varargout = slider_plot(varargin)
% SLIDER_PLOT MATLAB code for slider_plot.fig
%      SLIDER_PLOT, by itself, creates a new SLIDER_PLOT or raises the existing
%      singleton*.
%
%      H = SLIDER_PLOT returns the handle to a new SLIDER_PLOT or the handle to
%      the existing singleton*.
%
%      SLIDER_PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDER_PLOT.M with the given input arguments.
%
%      SLIDER_PLOT('Property','Value',...) creates a new SLIDER_PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before slider_plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to slider_plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help slider_plot

% Last Modified by GUIDE v2.5 15-Aug-2017 11:41:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @slider_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @slider_plot_OutputFcn, ...
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


% --- Executes just before slider_plot is made visible.
function slider_plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to slider_plot (see VARARGIN)

% Choose default command line output for slider_plot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes slider_plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = slider_plot_OutputFcn(hObject, eventdata, handles) 
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
slider_value = get(handles.slider1,'Value');
set(handles.edit1,'String',num2str(slider_value));
guidata(hObject,handles);

axes(handles.axes1);
x_values = linspace(0,1,1000);
epsilon = get(handles.edit1,'String');
epsilon = str2num(epsilon);
y_values = mixed_lorenz(x_values,epsilon,0.6);
plot(x_values,y_values);
legend(join(['Epsilon = ',num2str(epsilon,2)]),'Location','Northwest');
legend('show');
guidata(hObject,handles);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
slider_value = get(handles.edit1,'String');
slider_value = str2num(slider_value);

if isempty(slider_value) || slider_value > 1 || slider_value <= 0
    set(handles.slider1,'Value',0);
    set(handles.edit1,'String','0');
else
    set(handles.slider1,'Value',slider_value);
end
axes(handles.axes1);
x_values = linspace(0,1,1000);
epsilon = get(handles.edit1,'String');
epsilon = str2num(epsilon);
y_values = mixed_lorenz(x_values,epsilon,0.6);
ylim([0 1]);
legend(join(['Epsilon = ',num2str(epsilon,2)]),'Location','Northwest');
legend('show');
plot(x_values,y_values);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

