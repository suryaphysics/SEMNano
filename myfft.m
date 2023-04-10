function [output] = myfft(input)
% myfft performs a 2D FFT of the input

output = fftshift(fft2(ifftshift(input)));

end

