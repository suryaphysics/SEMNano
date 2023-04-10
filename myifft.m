function [output] = myifft(input)
% myfft performs a 2D IFFT of the input

output = fftshift(ifft2(ifftshift(input)));

end

