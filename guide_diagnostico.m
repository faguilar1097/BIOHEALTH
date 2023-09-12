function varargout = guide_diagnostico(varargin)
% GUIDE_DIAGNOSTICO MATLAB code for guide_diagnostico.fig
%      GUIDE_DIAGNOSTICO, by itself, creates a new GUIDE_DIAGNOSTICO or raises the existing
%      singleton*.
%
%      H = GUIDE_DIAGNOSTICO returns the handle to a new GUIDE_DIAGNOSTICO or the handle to
%      the existing singleton*.
%
%      GUIDE_DIAGNOSTICO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDE_DIAGNOSTICO.M with the given input arguments.
%
%      GUIDE_DIAGNOSTICO('Property','Value',...) creates a new GUIDE_DIAGNOSTICO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guide_diagnostico_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guide_diagnostico_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guide_diagnostico

% Last Modified by GUIDE v2.5 05-May-2022 23:15:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guide_diagnostico_OpeningFcn, ...
                   'gui_OutputFcn',  @guide_diagnostico_OutputFcn, ...
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


% --- Executes just before guide_diagnostico is made visible.
function guide_diagnostico_OpeningFcn(hObject, eventdata, handles, varargin)
global mainHandles nombre edad HR textura fecha sexo 
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guide_diagnostico (see VARARGIN)
mainHandles = guidata(guide_inicial)
% Choose default command line output for guide_diagnostico
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% 
% data_paciente = mainHandles.Datospaciente
%% Datos del paciente
nombre = mainHandles.Nombre;
set(handles.nombre,'String',nombre);

edad = mainHandles.Edad;
set(handles.edad,'String',edad);

sexo = mainHandles.Sexo;
set(handles.sexo,'String',sexo);

formatOut = 'mm/dd/yy';
fecha=datestr(now,formatOut);
set(handles.fecha,'String',fecha);



% UIWAIT makes guide_diagnostico wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guide_diagnostico_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in excel.
function excel_Callback(hObject, eventdata, handles)
% hObject    handle to excel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nombre edad HR textura fecha sexo

e = actxserver('Excel.Application');
Datos=importdata('DatosModular.xlsx');
W=cell2mat(Datos(2,1));W=str2num(W);
Wdata=W+2;
info = {nombre,num2str(edad),sexo,num2str(HR),num2str(textura)};
ini =  ['B' num2str(Wdata)];
fin =  ['F' num2str(Wdata)];
rango = [ini ':' fin];

writecell(info,'DatosModular.xlsx','Range',rango);
W=W+1;
writematrix(num2str(W),'DatosModular.xlsx','Range','A2');

dia=day(fecha);
mes=month(fecha);mes=num2str(mes);
if length(mes)==1
    cero = '0';
    mes=[cero mes];
end
agno=year(fecha);
ID_registro=[num2str(W) num2str(edad) sexo num2str(dia) mes num2str(agno)];
set(handles.registro,'String',ID_registro);
celda=['G' num2str(Wdata)];
writematrix(ID_registro,'DatosModular.xlsx','Range',celda);
msgbox('Datos registrados correctamente',"Datos Excel");


% --- Executes on button press in grabar.
function grabar_Callback(hObject, eventdata, handles)
% hObject    handle to grabar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
grabar_dataset();


% --- Executes on button press in procesar.
function procesar_Callback(hObject, eventdata, handles)
% hObject    handle to procesar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global nombre edad HR textura fecha sexo mainHandles
nombre = nombre;
fecha = fecha;
sexo = sexo;
edad =edad;
% %%  leer video

  
   v = VideoReader('prueba2.avi');
        f_foto=round(v.NumFrames/2);
       
% 
% %  % Señales RGB
 cont = 1;
           while hasFrame(v)
               frame= readFrame(v);
               if cont == f_foto
                    foto = frame;
                  
                end
               frame=imresize(frame,0.5);
               
               pomulos = facedetection(frame); 
               [pr, pv, pb] = promedios(pomulos);

                %Creación de señales de colorimetría 
                promedior(cont) = pr; 
                promediov(cont) = pv; 
                promediob(cont) = pb;
                cont = cont+1;
                if cont == f_foto
                    foto = frame;
                  
                end
           end
%             %% Normalización
%             load('promedior');
%              load('promediov');
%               load('promediob');
%               
%               load('foto');
%         close all;
            normalizacionr=normalizacion(promedior);
            normalizacionv=normalizacion(promediov);
            normalizacionb=normalizacion(promediob);
            x_labeln='Muestras';
            y_labeln='Intensidad';

            plot(handles.rojo,normalizacionr,'r');
             xlabel(handles.rojo,x_labeln);
            ylabel(handles.rojo,y_labeln);
            axis(handles.rojo,'tight');
            title(handles.rojo,'Señales RGB');
            
            plot(handles.verde,normalizacionv,'g');
              xlabel(handles.verde,x_labeln);
            ylabel(handles.verde,y_labeln);
            axis(handles.verde,'tight');
            
            plot(handles.azul,normalizacionb,'b');
            xlabel(handles.azul,x_labeln);
            ylabel(handles.azul,y_labeln);
            axis(handles.azul,'tight');
 



%% BSS

s = [promedior; promediov; promediob];
sn = [normalizacionr; normalizacionv; normalizacionb];
N = sn;

[Y, A, W]=fastica(s);
[Yn, An, Wn]=fastica(sn);
t=1:length(Y(1,:));
lim = length(Y(1,:));
 x_labelbss='Muestras';
 y_labelbss='Amplitud';

plot(handles.canal1,t,Yn(1,:));
title(handles.canal1,'Fuentes encontradas con BSS');
xlim(handles.canal1,[0 lim]);
xlabel(handles.canal1,x_labelbss);
ylabel(handles.canal1,y_labelbss);
axis(handles.canal1,'tight');

plot(handles.canal2,t,Yn(2,:));
xlim(handles.canal2,[0 lim]);
xlabel(handles.canal2,x_labelbss);
ylabel(handles.canal2,y_labelbss);
 axis(handles.canal2,'tight');


plot(handles.canal3,t,Yn(3,:));
xlim(handles.canal3,[0 lim]);
xlabel(handles.canal3,x_labelbss);
ylabel(handles.canal3,y_labelbss);
 axis(handles.canal3,'tight');
%% Fourier

fs=15;
L = length(Yn);
T= L/fs;
vt = 1/fs:1/fs:T;
frec = fs*(0:(L/2))/L;
%Obtención del espectro de fourier para cada canal
Fourier_Mag1 = f_espectro(Yn(1,:));
Fourier_Mag2 = f_espectro(Yn(2,:));
Fourier_Mag3 = f_espectro(Yn(3,:));

Fourier_filtradoc1=filtroFourier(Yn(1,:),fs);
Fourier_filtradoc2=filtroFourier(Yn(2,:),fs);
Fourier_filtradoc3=filtroFourier(Yn(3,:),fs);
%% Detección del Ritmo cardiaco
t=1:length(Fourier_filtradoc2);
lim=length(Fourier_filtradoc2);
x_labelbss='Muestras';
y_labelbss='Amplitud';
[x,y]=findpeaks(Fourier_filtradoc2,'MinPeakHeight',mean(Fourier_filtradoc2));
plot(handles.picos,t,Fourier_filtradoc2,y,x,'o');
% plot(handles.picos,y,x,'o');
title(handles.picos,'Pulsos detectados');
xlim(handles.picos,[0 lim]);
xlabel(handles.picos,x_labelbss);
ylabel(handles.picos,y_labelbss);

prop=(length(Fourier_filtradoc2)*100)/450;
prop=100/prop;

HR=length(findpeaks(Fourier_filtradoc2,'MinPeakHeight',mean(Fourier_filtradoc2)));
HR=round(HR*prop);

set(handles.ritmocardiaco,'String',HR);
% Diagnostico ritmo
% HR=67.567;
% HR=round(HR);
% age = 24

age = str2double(edad);
diagnosticoHR = HRDiagnostic(age, HR);
set(handles.ritmodiag,'String',diagnosticoHR);

% TEXTURA DE LAWS

[pomulos_t,rostro] = facedetection(foto);
%   Procesamiento de LAWS
 [textura,mask]=LawsTextureProcess(pomulos_t);
 
axes(handles.deteccion_rostro);
imshow(rostro);
title(handles.deteccion_rostro,'Detección automática del rostro');

axes(handles.pomulos);
imshow(pomulos_t);
title(handles.pomulos,'Recorte de los pómulos');

axes(handles.mascara);
imshow(mask);
title(handles.mascara,{['Máscara de Laws #6']...
               [ 'Energy value: ' num2str(textura)]});
           
%Diagnóstico piel
edad=[];
age = 0;

edad = mainHandles.Edad;
% textura = .88661;
skin_texture=0;
age = str2double(edad);
skin_texture = round(textura*100);
skintexture = skin_texture/100;
fage =msgbox(["Edad: " num2str(age)]);
ftxture=msgbox(["Textura: " num2str(skintexture)]);
pause(2);
diagnosticoSkin = TextureDiagnostic(age,skintexture);
set(handles.skindiag,'String',diagnosticoSkin);


           


% --- Executes on button press in salir.
function salir_Callback(hObject, eventdata, handles)
% hObject    handle to salir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function nombre_Callback(hObject, eventdata, handles)
% hObject    handle to nombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nombre as text
%        str2double(get(hObject,'String')) returns contents of nombre as a double


% --- Executes during object creation, after setting all properties.
function nombre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nombre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edad_Callback(hObject, eventdata, handles)
% hObject    handle to edad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edad as text
%        str2double(get(hObject,'String')) returns contents of edad as a double


% --- Executes during object creation, after setting all properties.
function edad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sexo_Callback(hObject, eventdata, handles)
% hObject    handle to sexo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sexo as text
%        str2double(get(hObject,'String')) returns contents of sexo as a double


% --- Executes during object creation, after setting all properties.
function sexo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sexo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
