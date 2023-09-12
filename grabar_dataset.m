function grabar_dataset()
 %% Parámetros para la grabación
clear all
clc

fps=15;
% prompt2="Introduzca duración (s):"; % Se pide la duración en segundos
% duracion=input(prompt2);
duracion = 15;
nTrigger=duracion*fps; %Numero repeticiones de trigger
vid3=videoinput('winvideo', 1, 'MJPG_640x480');
src3=getselectedsource(vid3);

%% Configuramos los parámetros para la grabación
vid3.FramesPerTrigger=1;
vid3.TriggerRepeat = nTrigger;
% Establecemos el trigger de forma manual para sincronizar las 4 fuentes
triggerconfig(vid3,'manual');
%% Establecemos los parámetros de los flujos de datos para grabar en disco
diskLoggerWColor=VideoWriter('prueba2.avi', 'Uncompressed AVI');
diskLoggerWColor.FrameRate=fps;
%% Creamos los flujos de datos para grabar en disco
open(diskLoggerWColor);
%% Comenzamos la grabacción
start(vid3);
preview(vid3);
for i = 1:nTrigger
trigger(vid3)
writeVideo(diskLoggerWColor, getdata(vid3));
end
%% Finalizamos la grabación
stop(vid3);

%% Cerramos los flujos de datos
close(diskLoggerWColor);
clear camObject;
clear vid3;
closepreview;
end