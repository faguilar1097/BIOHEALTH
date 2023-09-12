function [nv]=normalizacion(promedio)
data = fitdist( promedio','Normal');
mu = data.sigma;
sigma = data.sigma;
nv = (promedio-mu)/sigma;
end


