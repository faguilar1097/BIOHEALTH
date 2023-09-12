
function varargout = guide_inicial(varargin)

% GUIDE_INICIAL MATLAB code for guide_inicial.fig
%      GUIDE_INICIAL, by itself, creates a new GUIDE_INICIAL or raises the existing
%      singleton*.
%
%      H = GUIDE_INICIAL returns the handle to a new GUIDE_INICIAL or the handle to
%      the existing singleton*.
%
%      GUIDE_INICIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_INICIAL.M with the given input arguments.
%
%      GUIDE_INICIAL('Property','Value',...) creates a new GUIDE_INICIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guide_inicial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guide_inicial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guide_inicial

% Last Modified by GUIDE v2.5 29-Apr-2022 22:52:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guide_inicial_OpeningFcn, ...
                   'gui_OutputFcn',  @guide_inicial_OutputFcn, ...
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
end

% --- Executes just before guide_inicial is made visible.
function guide_inicial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guide_inicial (see VARARGIN)

% Choose default command line output for guide_inicial
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

Imagen = imread('portada.png');
Imagen = rgb2gray(Imagen);
axes(handles.axes1);
imshow(Imagen);

% UIWAIT makes guide_inicial wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = guide_inicial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in comenzar.
function comenzar_Callback(hObject, eventdata, handles)
% hObject    handle to comenzar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Nombre = get(handles.Nombre,'String');
% Edad = get(handles.Edad,'String');
% Sexo = get(handles.Sexo,'String');
handles.Nombre = get(handles.Nombre,'String');
handles.Edad = get(handles.Edad,'String');
handles.Sexo = get(handles.Sexo,'String');

%  handles.Datospaciente = {Nombre,Edad,Sexo};
guidata(hObject,handles);
% f = msgbox(["Su nombre es: " Nombre;"Su edad es: " Edad;"Su sexo es: " Sexo]);
% f = msgbox(Nombre);
% f2 = msgbox(Edad);
% f3 = msgbox(Sexo);
f = msgbox("Datos correctamente almacenados","Datos paciente");
% grabar_dataset();
guide_diagnostico
end
 


function Nombre_Callback(hObject, eventdata, handles)
% hObject    handle to Nombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nombre as text
%        str2double(get(hObject,'String')) returns contents of Nombre as a double
end

% --- Executes during object creation, after setting all properties.
function Nombre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function Edad_Callback(hObject, eventdata, handles)
% hObject    handle to Edad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edad as text
%        str2double(get(hObject,'String')) returns contents of Edad as a double

end
% --- Executes during object creation, after setting all properties.
function Edad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function Sexo_Callback(hObject, eventdata, handles)
% hObject    handle to Sexo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sexo as text
%        str2double(get(hObject,'String')) returns contents of Sexo as a double

end
% --- Executes during object creation, after setting all properties.
function Sexo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sexo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');

end
end
