% % This is regarding the features extraction of an image
% 
% Texture : An important approach to region description is to quantify its texure
% content. This descriptor provides the measures of properties such as smoothness,
% coarseness and regularity. Three approaches that can be catergorized under this
% 1. Statistical approache
%     Find the histogram of the image to know the distribution of gray level intensities
%     a. Mean of z= sum((z).*p(z)); measures the average gray level of image
%     b. Variance = sum((z)-mean).*p(z); measure of gray level contrast that can be used to 
%     establish descriptors of relative smoothness.
%     c. R=1-(1/(1+variance)); measure of smoothness.
%     d. Third moment is a measure of skewness 
%     skewness=sum((z-m).*p(z));
%     e. Entropy measure of distibution. It is a measure used to describe the randomness 
%     of the gray level intensities.
%     entropy=-sum(p(z)log(p(z)); 
%     f. Coocurrance matrix. captures the spatial dependence of wavelet detail coefficients depending on 
%     different directions and different distances.
%     Four coocurrance matrix is calculated for each detail along 4 different directions given by
%     0,45,90,135 degrees directions.or can take along different directions. The distances are normally taken based on level of decomposition.
%     g. Maximum probablity max(max(C)). it results in pixel pair that is most dominant in the image.
%     h. Entropy 
%     i. Energy(angular second moment) : sum(sum(c.^2)). measures the number of repeated pairs.
%     
%     j. Contrast sum((i-j).^2.*c)). Measures the local contrast of an image. The contrast is expected to be low 
%     if the gray levels of each pixel pair are similar.
%     k. Homogeneity  sum(c./(1+abs(i-j))); 
%     l. Sum mean (0.5*sum((i+j).*c));
%     m. Variance.
%     n. Inverse Differnce moment :sum(c./abs(i-j)) i~=j; tells us the smoothness of the image.
%     
%     o. Cluster tendency: sum(i+j-2mean).^2.*c    ; measures the grouping of pixels that have similar gray level values.
% 
% 2. Spectral Approach
%   As Fourier spectrum is ideally suited for describing the directionality
% of periodic orr almost periodic 2-D patterns in image. These global texture patterns, although easily distinguisable as concentrations
% of high-energy bursts in the spectrum, generally are quite difficult to detect with
% spatial methods because of local nature of these techniques.
%     a. Prominent peaks in the spectrum gives the principal direction of the texture patterns.
%     b. The location of the peaks in the frequency plane gives the fundamental spatial period pf the patterns.
%     c. Eliminating any peridoc components via filtering leaves non-periodic images
%     which can then be described by statistical techniques.
% 
% 

function [features]=feature_extraction_wavelet(f)

% Extracting the Features from Cooccurance matrix
% Create Four unit vectors along four directions






