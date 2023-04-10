function [psf] = wiener_filter(T,O,K)
% Calculates psf (electron beam intensity) using true image and observed
% image
%WIENER_FILTER

T_ = real(T)+1i*imag(T);
OTF = (T_./(T.*T_ + K)).*O;

% psf = abs(fftshift(ifft2(ifftshift(OTF))));
psf = abs(myifft(OTF));
end

