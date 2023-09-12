function [procesamientoLaws,masklaw]=LawsTextureProcess(pomulos)
% pomulos = pomulos_t;
%   pomulos=imresize(pomulos,[200 250]);
%      figure;
%      imshow(pomulos);
      Imagepomulos = rgb2gray(pomulos);
      dimensiones = size(Imagepomulos);
%         figure;
%         imshow(Imagepomulos);
%         title('Original Image');
        [mapz] = laws( Imagepomulos , 3);%3 is serendipitously choose
      
        
%         figure;

for i=1:9
%   subplot(3,3,i);
%     title('Texturas de pómulos');
%   imshow(mapz{1,i}); title(['#' num2str(i),'(3,3,' num2str(i),')' ]);
   lawmask=cell2mat(mapz(i));
   glcms = graycomatrix(lawmask);
   stats = graycoprops(glcms);
   energy_maskv(1,i)=stats.Energy;
end
   

% figure;
% plot(energy_maskv,'b');
% hold on 
% xlabel('# DE MÁSCARA DE LAWS');
% title('Energy masks');

procesamientoLaws=energy_maskv(6);
masklaw=mapz{1,6};




end