function Fourier_Mag = f_espectro(fuente)
%% ingresar directamente la fuente a procesar
L = length(fuente);
Fourier_Spectrum =fft(fuente);
Fourier_Mag=abs(2*Fourier_Spectrum/L);
Fourier_Mag = Fourier_Mag(1:end/2+1);

end