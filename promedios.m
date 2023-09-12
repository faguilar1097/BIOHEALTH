function [promedior, promediov, promediob] = promedios(recorte)
 imr = double(recorte(:,:,1));
 imv = double(recorte(:,:,2));
 imb = double(recorte(:,:,3));
 
 umr=mean(mean(imr));
 umv=mean(mean(imv));
 umb=mean(mean(imb));

bynr = imr > umr;
bynv = imv > umv;
bynb = imb > umb;


canalr= bynr .* imr;
promedior =mean(mean(canalr));

canalv= bynv .* imv;
promediov =mean( mean(canalv));

canalb= bynb .* imb;
promediob =mean( mean(canalb));

end