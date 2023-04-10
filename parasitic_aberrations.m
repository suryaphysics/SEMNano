function[aberrated_wavefront_para] = parasitic_aberrations(X,Y,A0,A1,C1,A2,B2,A3,S3,C3,...
    A4,B4,D4,R5,S5,C5,A5,B6,D6,F6,A6,C7,S7,R7,G7,A7)

% Function to calculate aberrated wavefront using parasitic aberrations provided by the user

K = X + 1i*Y;
K_ = X - 1i*Y;

aberrated_wavefront_para = ...
        A0* (K_) + ...         % Beam/image Shift
        A1* (K_).^2 + ... % Two-fold axial astigmatism (or axial astigmatism of the 1st order)
        (1/2)* C1* (K .* K_) + ... % Defocus 
        (1/3)* A2* (K_).^3 + ... % Three-fold axial astigmatism (or axial astigmatism of the 2nd order)    
        B2* (K ).^2 .* (K_) + ... % Second-order axial coma
        (1)* A3* (K_).^4 + ... % Four-fold axial astigmatism or axial astigmatism of the 3rd order Cs
        S3* (K ).^3 .* (K_) + ... % Twofold astigmatism of Cs (or Third order twofold astigmatism, or Axial star aberration of the 3rd order)
        (1/4)* C3* (K .* K_).^2 + ... % Third-order spherical aberration (always positive for round lenses 
        (1/5)* A4* (K_).^5 + ... % Five-fold axial astigmatism or axial astigmatism of the 4th order
        B4* (K ).^3 .* (K_).^2 + ... % Fourth-order axial coma
        D4* (K ).^4 .* (K_) + ... % Fourth order threefold astigmatism (or Three lobe aberration)
        R5* (K ).^5 .* (K_) + ... % Fourfold astigmatism of C5 (or Fifth order rosette aberration)
        S5* (K ).^4 .* (K_).^2 + ... % Twofold astigmatism of C5 (or Fifth-order axial star aberration)
        (1/6)* C5* (K .* K_).^3 + ... % Fifth-order spherical aberration
        (1/6)* A5* (K_).^6 + ... % Six-fold axial astigmatism or sixfold axial astigmatism of the 5th order
        B6* (K ).^4 .* (K_).^3 + ... % Sixth order axial coma
        D6* (K ).^5 .* (K_).^2 + ... % Sixth order three-lobe aberration
        F6* (K ).^6 .* (K_) + ... % Sixth order pentacle aberration
        (1/7)* A6* (K_).^7 + ... % Sevenfold astigmatism
        (1/8)* C7* (K .* K_).^4 + ... % Seventh-order spherical aberration
        S7* (K ).^5 .* (K_).^3 + ... % Seventh-order star aberration
        R7* (K ).^6 .* (K_).^2 + ... % Seventh-order rosette aberration
        G7* (K ).^7 .* (K_) + ... % Seventh-order chaplet aberration
        (1/8)* A7* (K_).^8; % Eightfold astigmatism
    
end
