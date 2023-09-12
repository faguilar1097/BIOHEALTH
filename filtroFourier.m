function canal1f = filtroFourier(fuente,fs)

[b,a]=butter(2,[.75 4]/(fs/2));
canal1f=filter(b,a,fuente);
Fourier_filtrado = f_espectro(canal1f)

end