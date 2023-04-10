function[wavelength] = volt2wavelen (V)

% Function to calculate the relativistic wavelength from accelerating
% volatge
% Input : accelerating voltage of electron beam
% Output: relativistic wavelength


h = 6.6256 * 10e-34;    % Plack's constant (J.s)
c = 299790000;          % Speed of light in vacuum (m/s)
m_e = 9.1091 * 10e-31;  % mass of an electron (kg)
e = 1.602 * 10e-19;     % charge of an electron (C)

wavelength = (h*c) / sqrt( 2* e*V* m_e* c^2 + (e*V)^2 );

end