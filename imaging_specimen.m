function [final_img] = imaging_specimen(specimen,probe)
specimen_fft = myfft(specimen);                                     % Spectrum of the specimen's structure signal
aberrated_beam_fft = myfft(probe);                              % Spectrum of aberrated beam intensity 
final_img = abs(myifft(specimen_fft.*aberrated_beam_fft));       % Image of the specimen using the aberrated beam intensity
end

