function[aberrated_wavefront_seid] = seidel_aberrations(x0, y0, X,Y, wd, w040, w131, w222)

% Function to calculate aberrated wavefront using defocus and 3
% seidel aberrations provided by the user

% Polar coordinate conversion in aperture coordinates ( X= -(0.5/f_c)*Fx )
theta = atan2(y0,x0);
x0r = sqrt(x0^2 + y0^2);
Xr = X*cos(theta) + Y*sin(theta);
Yr = -X*sin(theta) + Y*cos(theta);
rho = Xr.^2 + Yr.^2;

aberrated_wavefront_seid = wd*rho + ...           % Defocus
                      w040*rho.^2 + ...      % Spherical aberration   
                      w131*x0r*rho.*Xr + ... % Coma
                      w222*x0r^2*Xr.^2 ;     % Astigmatism   

end
