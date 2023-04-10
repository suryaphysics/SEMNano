function [d_g,M,f_num,f_c,u_i_irrad_n,normalized_psf,TF,x_i,y_i,fx,fy] = ...
    output_parameters(Beta_g, i_p, alpha_p, D, V_0, d_s,x0, y0, wd,w040,w131,w222,...
    A0,A1,C1,A2,B2,A3,S3,C3,A4,B4,D4,R5,S5,C5,A5,B6,D6,F6,A6,C7,S7,R7,G7,A7,N)

%% Description

% CODE TO SIMULATE ELECTRON PROBE FORMATION IN A SCHOTTKY OR Cold-FEG SEM
% USING ELECTRON WAVE OPTICS AND SEIDEL ABERRATIONS. THEN WE USE THE
% ABERRATED BEAM INTENSITY TO IMAGE THE SPECIMEN. DECONVOLUTION IS
% PERFORMED TO RECOVER THE BEAM INTENSITY FROM A FINAL NOISY IMAGE USING
% WIENER FILTER. 

% *** FUNCTIONS ***
% -> volt2wavelen()         - calculates relativistic wavelength of an electron given accelerating voltage
% -> circ()                 - creates a cicular binary mask with a given radius
% -> myfft()                - 2D FFT of array
% -> myifft()               - 2D IFFT of array
% -> add_noise()            - adds uniformly distributed noise to image
% -> wiener_filter()        - inverse filter to reconstruct input from noisy output
% -> generate_FS_data()     - generate focal series data through defocus variation
% -> fresnel_propagation()  - performs propagation using chrip (fresnel) transfer function
% -> aberration_func()      - calculates aberrated wavefront using defocus and 3
%                             seidel aberrations provided by the user

%% SECTION 1 - Input Parameters


V_0 = V_0*1000;
d_s = d_s * 1e-9;
D = D * 1e-6;
alpha_p = alpha_p * 1e-3;

lambda = volt2wavelen(V_0);                         % Relativistic wavelength
k = 2*pi/lambda;                                    % Wavenumber 
d_g = sqrt( (4*i_p) / (Beta_g* pi^2* alpha_p^2) );  % Geometrical probe width calculated from the brightness equation
z_i = (D/2)/alpha_p;                                % Object distance
M = d_g / d_s;                                      % Magnifiction = Image height/ object height
z_o = z_i/M;                                        % Image distance
f = z_o*z_i/(z_o+z_i);                              % Focal length 
f_num = f/D;                                        % f# - f-number of the objective lens
f_c = alpha_p/lambda;                               % cutoff frequency in fx space.
%% SECTION 2 - Image plane parameters

L_i = 5e-8;                             % < N*lambda*f_num/2 Image plane length (Satisfying nyquist and diffraction samlpling)
dx_i = L_i/N;                           % image plane sample interval
x_i = -L_i/2 : dx_i : L_i/2 - dx_i;     % array of sampling locations 
y_i = x_i;
[X,Y] = meshgrid(x_i,y_i);              % Meshgrid

u_g = exp(-((X.^2 + Y.^2)/(d_g)^2));    % Gaussian beam at the sample, demagnified geometrical image.

%% SECTION 3 - Objective lens aperture function 

fx = -1/(2*dx_i) : 1/L_i : 1/(2*dx_i)-(1/L_i); % Frequency coordinates
fy = fx;
[Fx,Fy]= meshgrid(fx,fy);                      % Meshgrid
aper_TF = circ(sqrt(Fx.^2 + Fy.^2)/f_c);       % Coherent transfer function without aberrations

%Function to calculate aberrated wavefront.

W_seidel = seidel_aberrations(x0,y0, -(0.5/f_c)*Fx, -(0.5/f_c)*Fy, wd*lambda,...
    w040*lambda,w131*lambda,w222*lambda);

W_parasitic = parasitic_aberrations(-(0.5/f_c)*Fx, -(0.5/f_c)*Fy, A0*lambda,A1*lambda,...
    C1*lambda,A2*lambda,B2*lambda,A3*lambda,S3*lambda,C3*lambda,A4*lambda,B4*lambda,...
    D4*lambda,R5*lambda,S5*lambda,C5*lambda,A5*lambda,B6*lambda,D6*lambda,F6*lambda,...
    A6*lambda,C7*lambda,S7*lambda,R7*lambda,G7*lambda,A7*lambda);

W =  W_seidel + real(W_parasitic);

abr_aper_TF = aper_TF.*exp(1i*k*W);               % Transfer function of the aberrated lens in fx-fy coordinates 
abr_coh_psf = fftshift(fft2(ifftshift(abr_aper_TF))); % coherent PSF of the aberrated lens 

%% SECTION 4 - Coherent Imaging of electron beam through lens

U_g = fftshift(fft2(ifftshift(u_g)));            % FT of the geometrical image
u_i = fftshift(ifft2(ifftshift(U_g.*abr_aper_TF)));  % IFT of bandlimited FT of geometrical image
u_i_irrad = abs(u_i).^2;                         % Irradiance of diffracted image
u_i_irrad_n = u_i_irrad/max(u_i_irrad(:));       % Normalized intensity

d_g = d_g * 1e+9;
f_c = f_c * 1e-9;
temp = real(abr_coh_psf); 
normalized_psf = temp/max(temp(:));
TF = real(abr_aper_TF);

end

