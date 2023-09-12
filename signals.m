clear all; close all; clc;
s_ox=load('senal oximetro.mat');
s_ox=s_ox.yy;
senales=load('sfilt.mat');
senales=senales.senalesfilt;
s1=senales(1,:);
s2=senales(2,:);
s3=senales(3,:);
L=length(s2);
% L=225
L2=length(s_ox);
s_oxrecortada=s_ox((L2-L):end-1);

[b,a]=butter(2,[.75 4]/(15/2));
s_oxrecortada=filter(b,a,s_oxrecortada);

% figure;
% plot(oximfilt);

%Normalizar
for i=1:length(s1)
    oximetron(i) = (s_oxrecortada(i)- min(s_oxrecortada)) / (max(s_oxrecortada) - min(s_oxrecortada));
    s1n(i) = (s1(i)- min(s1)) / (max(s1) - min(s1));
    s2n(i) = (s2(i)- min(s2)) / (max(s2) - min(s2));
    s3n(i) = (s3(i)- min(s3)) / (max(s3) - min(s3));
       
end




figure;
subplot(3,1,1);
plot(s1n);
title('Canal 1');
xlabel('Números de muestras');
ylabel('Voltaje (V)');
hold on 
plot(oximetron,'r');
xlim([0 length(s1)]);
subplot(3,1,2);
plot(s2n);
title('Canal 2');
xlabel('Números de muestras');
ylabel('Voltaje (V)');
hold on 
plot(oximetron,'r');
xlim([0 length(s1)]);
subplot(3,1,3);
plot(s3n);
title('Canal 3');
xlabel('Números de muestras');
ylabel('Voltaje (V)');
hold on 
plot(oximetron,'r');
xlim([0 length(s1)]);


[pksox,locsox]=findpeaks(oximetron,'MinPeakHeight',mean(oximetron));
[pks1,locs1]=findpeaks(s1n,'MinPeakHeight',mean(s1n));
[pks2,locs2]=findpeaks(s2n,'MinPeakHeight',mean(s2n));
[pks3,locs3]=findpeaks(s3n,'MinPeakHeight',mean(s3n));

L=length(oximetron);
tiempo=1:L;

figure;
subplot(3,1,1);
plot(s1n);
hold on
plot(locs1,pks1,'o');
title('Canal 1');
xlabel('Números de muestras');
ylabel('Voltaje (V)');
hold on 
plot(tiempo,oximetron,'r');
hold on 
plot(locsox,pksox,'*');
xlim([0 length(s1)]);
% legend('Fuente 1',,'Sensor');

subplot(3,1,2);
plot(s2n);
hold on
plot(locs2,pks2,'o');
title('Canal 2');
xlabel('Números de muestras');
ylabel('Voltaje (V)');
hold on 
plot(tiempo,oximetron,'r');
hold on 
plot(locsox,pksox,'*');
xlim([0 length(s1)]);
% legend('Fuente 2','Sensor');

subplot(3,1,3);
plot(s3n);
hold on
plot(locs3,pks3,'o');
title('Canal 3');
xlabel('Números de muestras');
ylabel('Voltaje (V)');
hold on 
plot(tiempo,oximetron,'r');
hold on 
plot(locsox,pksox,'*');
xlim([0 length(s1)]);
% legend('Fuente 3','Sensor');



%%Correlacion 
lim=37;

%PICOS
cs1pks=corrcoef(pksox(1:37),pks1);
cs2pks=corrcoef(pksox,pks2(1:38));
cs3pks=corrcoef(pksox,pks3(1:38));
%LOCS
cs1locs=corrcoef(locsox(1:37),locs1);
cs2locs=corrcoef(locsox,locs2(1:38));
cs3locs=corrcoef(locsox,locs3(1:38));

