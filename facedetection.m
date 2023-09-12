function  [pomulos, IFaces] = facedetection(imagen);
%       
% imagen = imread('19.jpg');
% imagen=frame;
    faceDetector = vision.CascadeObjectDetector;
    bboxes = faceDetector(imagen);
    
%     faceDetector = vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[200 200]);
%     bboxes = faceDetector(imagen);
    %bboxes(,1)=puntos(:,:);
    [f c]=size(bboxes);
    %corrección en la detección del rostro en los frames.
    if f > 1
      for i=1:f
          Area(i)=(bboxes(i,3))*(bboxes(i,4));
      end
      
          Area_max=max(Area);
          Area_definitiva=find(Area == Area_max)
          bboxes = bboxes(Area_definitiva,:);
    end
    %corrección en la detección del rostro en los frames
    % Definir el área detectada
    IFaces = insertObjectAnnotation(imagen,'rectangle',bboxes,'Face');
%      figure; imshow(uint8(IFaces(:,:,:)));
    %Recortes del área detectada 
%     recorte = imagen(bboxes(2): bboxes(2)+bboxes(3),bboxes(1):bboxes(1)+bboxes(4),:);
    ancho = round((bboxes(3)-(bboxes(3)*.70))/2);
    recorte = imagen(bboxes(2): bboxes(2)+bboxes(3),bboxes(1)+ancho:bboxes(1)+bboxes(4)-ancho,:);
%     figure;     
%     imshow(IFaces);
%     
    
    
    
%     figure;     
%     imshow(recorte);
%     
%      NoseDetector = vision.CascadeObjectDetector('Nose','MinSize',[round(bboxes(3)/5) round(bboxes(4)/5)]);
%     nboxes = NoseDetector(recorte);
      NoseDetector = vision.CascadeObjectDetector('Nose');
   
     NoseDetector.MinSize = [round(bboxes(3)/5) round(bboxes(4)/5)];
     NoseDetector.MaxSize = [round(bboxes(3)/2) round(bboxes(4)/2)];
     nboxes = NoseDetector(recorte);
    
  
    
    [f c]=size(nboxes);
    %corrección en la detección del rostro en los frames.
    if f > 1
       nboxes =  nboxes(1,:);
    end
    
    INose = insertObjectAnnotation(recorte,'rectangle',nboxes,'Nose');
    
    
%     figure;     
%     imshow(INose);
    recorten = recorte(nboxes(2): nboxes(2)+nboxes(3),nboxes(1):nboxes(1)+nboxes(4),:);
%     figure; 
%     imshow(recorten);
    %Pomulo 1 (der)
     alto = round(nboxes(2)*.05); %alto = nboxes(4)+alto;
%     recorte2 = recorte(nboxes(2):round((nboxes(2)+nboxes(4))*1.50),:,:);
    recorte2 = recorte(nboxes(2)-alto:nboxes(2)+nboxes(4),:,:);
%     figure;
%     imshow(recorte2);
    
    pomulo1 = recorte2(:,1:nboxes(1),:);
    pomulo2 = recorte2(:,nboxes(1)+nboxes(3):end,:);
    
%     figure;
%     hold on
%     subplot(1,2,1);
%      imshow(pomulo1);
%      title('Pomulo derecho');
%        subplot(1,2,2);
%      imshow(pomulo2);
%      title('Pomulo izquierdo');
     
     
     pomulos=[pomulo1 pomulo2];
%      figure;
%      imshow(pomulos);
     
end
     
     
     
     
    
    
    
    
    
    