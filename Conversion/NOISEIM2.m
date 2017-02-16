function [image] = NOISEIM2 (startim,prop,isplot)
% ----------------------------------------------------------------------
% [image] = cm2vaDeg(startim,prop,isplot)
% ----------------------------------------------------------------------
% Goal of the function :
% Create noise image of color stimulus
% ----------------------------------------------------------------------
% Input(s) :
% startim = starting image                                  
% prop  = proportion of pixels to apply the salt and pepper noise to        
% ----------------------------------------------------------------------
% Output(s):
% image = noiseimage           
% ----------------------------------------------------------------------
% Function created by Nick Hedger
% Project : All
% Version : 1.0
% ----------------------------------------------------------------------

% Set up cell for R, G and B planes
RPLANE=cell(1,1);


for i=1:1    
RPLANE{i}=startim;
end

% Obtain the amplitude spectra of each of the planes
[RPLANE2,RSPEC]=specMatch(RPLANE);


% Create random noise of same size as the planes. Prop controls the 
% density of the noise e.g. 0.5 - noise is applied to half of the pixels. 
NOISE=cell(1,1);
NOISE{1}=imnoise(startim,'salt & pepper',prop);

% Give the noise the same amplitude spectra as the R G and B planes from
% the image
[RNOISE]=specMatch(NOISE,0,RSPEC);


% Create new rgb image by combining the 3 noise images
NOISE=RNOISE{1};


% normalise.
image=normalise(NOISE);
if isplot
subplot(1,2,1)
imshow(image)
subplot(1,2,2)
imshow(startim)
else
end