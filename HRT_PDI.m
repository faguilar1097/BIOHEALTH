 clear all; close all; clc;
%% CARGAR VIDEO E INICIALIZAR VARIABLES
% v = VideoReader('prueba2.avi');
% [x y z nf]=size(v);
% promedior = zeros([1 nf]);
% promediov= zeros([1 nf]);
% promediob = zeros([1 nf]);
% frame = zeros([1 nf]);

boton=0;
while boton~=9
    boton=menu('HRT-PDI',...
        '1.Grabar video',...
        '2.Detección de rasgos del rostro',...
        '3.Normalización',...
        '4.BSS',...
        '5.Espectro de Fourier y Filtrado',...
        '6.HRT',...
        '7.Análisis de texturas de LAWS',...
        '8.Diagnóstico HR y Piel',...
        '9.Salir');
    
       if boton == 1,
%         grabar_dataset();
        v = VideoReader('prueba2.avi');
        close all;
        f_foto=round(v.NumFrames/2);
       elseif boton == 2,
           cont = 1;
           while hasFrame(v)
               frame= readFrame(v);
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
        elseif boton == 3,
            %% Normalización
            normalizacionr=normalizacion(promedior);
            normalizacionv=normalizacion(promediov);
            normalizacionb=normalizacion(promediob);
            % Graficación señales normales vs señales normalizadas
            figure;
            subplot(3,2,1);
            plot(promedior,'r');
            title('Señales crudas');
            subplot(3,2,3);
            plot(promediov,'g');
            subplot(3,2,5);
            plot(promediob,'b');
            subplot(3,2,2);
            plot(normalizacionr,'r');
            title('Señales normalizadas');
            subplot(3,2,4);
            plot(normalizacionv,'g');
            subplot(3,2,6);
            plot(normalizacionb,'b');
       
       elseif boton == 4,
            %%BSS
            s = [promedior; promediov; promediob];
            sn = [normalizacionr; normalizacionv; normalizacionb];
            N = sn;
            
            [Y, A, W]=fastica(s);
            [Yn, An, Wn]=fastica(sn);
            t=1:length(Y(1,:));
            
            figure;
            plot(t,Yn(1,:),t,Yn(2,:)+5,t,Yn(3,:)+30);
            title('Fuentes encontradas de normalizadas');
            legend('Fuente 1','Fuente 2','Fuente 3');

       elseif boton == 5,
           %%Fourier
           fs=15;
           L = length(Yn);
           T= L/fs;
           vt = 1/fs:1/fs:T;
           frec = fs*(0:(L/2))/L;
           %Obtención del espectro de fourier para cada canal
           Fourier_Mag1 = f_espectro(Yn(1,:));
           Fourier_Mag2 = f_espectro(Yn(2,:));
           Fourier_Mag3 = f_espectro(Yn(3,:));
           
           figure;
            subplot (3,1,1);
            stem(frec(2:113),Fourier_Mag1(2:113));
            xlabel('f(Hz)');
            ylabel('|P(f)|');
            title('Espectro del canal 1');
            subplot (3,1,2);
            stem(frec(2:113),Fourier_Mag2(2:113));
            xlabel('f(Hz)');
            ylabel('|P(f)|');
            title('Espectro del canal 2');
            subplot (3,1,3);
            stem(frec(2:113),Fourier_Mag3(2:113));
            xlabel('f(Hz)');
            ylabel('|P(f)|');
            title('Espectro del canal 3');
           %Filtrado
           
           Fourier_filtradoc1=filtroFourier(Yn(1,:),fs);
           Fourier_filtradoc2=filtroFourier(Yn(2,:),fs);
           Fourier_filtradoc3=filtroFourier(Yn(3,:),fs);
           
           
           
           figure; 
            subplot(3,1,1);
            stem(frec,Fourier_filtradoc1);
            xlabel('f (Hz)');
            ylabel('P(f)');
            title('Espectro filtrado del canal 1');
            subplot(3,1,2);
            stem(frec,Fourier_filtradoc2);
            xlabel('f (Hz)');
            ylabel('P(f)');
            title('Espectro filtrado del canal 2');
            subplot(3,1,3);
            stem(frec,Fourier_filtradoc3);
            xlabel('f (Hz)');
            ylabel('P(f)');
            title('Espectro filtrado del canal 3');
           
           figure;
            subplot(3,1,1);
            plot(Fourier_filtradoc1);
            title('canal 1 filtrado');
            subplot(3,1,2);
            plot(Fourier_filtradoc2);
            title('canal 2 filtrado');
            subplot(3,1,3);
            plot(Fourier_filtradoc3);
            title('canal 3 filtrado');
           
           
            
        elseif boton == 6,
     figure();
        plot(Fourier_filtradoc2);hold on;
        title('canal 2 filtrado');
        [x,y]=findpeaks(Fourier_filtradoc2,'MinPeakHeight',mean(Fourier_filtradoc2));
         [x1,y1]=findpeaks(Fourier_filtradoc1,'MinPeakHeight',mean(Fourier_filtradoc1));
          [x3,y3]=findpeaks(Fourier_filtradoc3,'MinPeakHeight',mean(Fourier_filtradoc3));
        plot(y,x,'o');

        prop=(length(Fourier_filtradoc2)*100)/450;
        prop=100/prop;

        %%Obtención del RC
        HR=length(findpeaks(Fourier_filtradoc2,'MinPeakHeight',mean(Fourier_filtradoc2)));
        HR=HR*prop;
        
         HR1=length(findpeaks(Fourier_filtradoc1,'MinPeakHeight',mean(Fourier_filtradoc1)));
        HR1=HR1*prop;
        
         HR3=length(findpeaks(Fourier_filtradoc3,'MinPeakHeight',mean(Fourier_filtradoc3)));
        HR3=HR3*prop;
        
        
        box = msgbox(['La frecuencia cardiaca es: ', num2str(HR)]);
        
        
%         frec=frec*60;
%         figure; 
%         subplot(3,1,1);
%         stem(frec,Fourier_Magc1f);
%         subplot(3,1,2);
%         stem(frec,Fourier_Magc2f);
%         subplot(3,1,3);
%         stem(frec,Fourier_Magc3f);
         elseif boton == 7,
 %Procesamiento de texturas de la piel             
 %Obtención del frame 
        
           [pomulos_t,rostro] = facedetection(foto);
  %Procesamiento de LAWS
           [textura,mask]=LawsTextureProcess(pomulos_t);
           
           figure;
           imshow(rostro);
               figure;
           imshow(pomulos_t);
               figure;
           imshow(mask);
           title({['Máscara de Laws #6']...
               [ 'Energy value: ' num2str(textura)]});
           
           
               
         elseif boton == 8,
%Diagnóstico textura y HR 
           edad=input('Ingrese la edad del paciente: ');
           diagnosticoSkin = TextureDiagnostic (edad,textura);
           diagnosticoHR = HRDiagnostic(edad, HR)
           box_HR = msgbox(diagnosticoHR);
           box_textura = msgbox(diagnosticoSkin);
           
           
       end
end