function [noisy] = add_noise(I,np)

% Function to add uniform noise 
np = round(np*100);
[a,~] = size(I);
N = (randi([-np,np],a)/100); % Noise distribution

noisy = I + N;%.* I; % Noisy output

end
