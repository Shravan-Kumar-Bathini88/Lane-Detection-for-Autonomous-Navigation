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

%% Extracting the Features from Cooccurance matrix
% Create Four unit vectors along four directions

p1=[0 1];
p2=[1 0];
p3=[1 1];
p4=[-1 -1];
%% Obtaining Wavelet Coefficients

[C,S]=wavedec2(f,3,'haar');% USING HAAR WAVELET
CA=appcoef2(C,S,'haar');
[CH1,CV1,CD1]=detcoef2('all',C,S,1);% At Level 1 Horizontal,Vertical,Diagonal
[CH2,CV2,CD2]=detcoef2('all',C,S,2);% At Level 2
[CH3,CV3,CD3]=detcoef2('all',C,S,3);% At Level 3

%% Conversion
CA=uint16(CA);
CH1=conversion_uint8(CH1);
CV1=conversion_uint8(CV1);
CD1=conversion_uint8(CD1);
CH2=conversion_uint8(CH2);
CV2=conversion_uint8(CV2);
CD2=conversion_uint8(CD2);
CH3=conversion_uint8(CH3);
CV3=conversion_uint8(CV3);
CD3=conversion_uint8(CD3);

%% Obtaining Co-occurance matrix for each wavelet detail along each direction

CA_p1=Cooccurance(CA,p1);CA_p2=Cooccurance(CA,p2);CA_p3=Cooccurance(CA,p3);CA_p4=Cooccurance(CA,p4);

CH1_p1=Cooccurance(CH1,p1);CH1_p2=Cooccurance(CH1,p2);CH1_p3=Cooccurance(CH1,p3);CH1_p4=Cooccurance(CH1,p4);

CV1_p1=Cooccurance(CV1,p1);CV1_p2=Cooccurance(CV1,p2);CV1_p3=Cooccurance(CV1,p3);CV1_p4=Cooccurance(CV1,p4);

CD1_p1=Cooccurance(CD1,p1);CD1_p2=Cooccurance(CD1,p2);CD1_p3=Cooccurance(CD1,p3);CD1_p4=Cooccurance(CD1,p4);

CH2_p1=Cooccurance(CH2,p1);CH2_p2=Cooccurance(CH2,p2);CH2_p3=Cooccurance(CH2,p3);CH2_p4=Cooccurance(CH2,p4);

CV2_p1=Cooccurance(CV2,p1);CV2_p2=Cooccurance(CV2,p2);CV2_p3=Cooccurance(CV2,p3);CV2_p4=Cooccurance(CV2,p4);

CD2_p1=Cooccurance(CD2,p1);CD2_p2=Cooccurance(CD2,p2);CD2_p3=Cooccurance(CD2,p3);CD2_p4=Cooccurance(CD2,p4);

CH3_p1=Cooccurance(CH3,p1);CH3_p2=Cooccurance(CH3,p2);CH3_p3=Cooccurance(CH3,p3);CH3_p4=Cooccurance(CH3,p4);

CV3_p1=Cooccurance(CV3,p1);CV3_p2=Cooccurance(CV3,p2);CV3_p3=Cooccurance(CV3,p3);CV3_p4=Cooccurance(CV3,p4);

CD3_p1=Cooccurance(CD3,p1);CD3_p2=Cooccurance(CD3,p2);CD3_p3=Cooccurance(CD3,p3);CD3_p4=Cooccurance(CD3,p4);

%% Obtaining Gray Cooccurance matrix descriptors
%---------------------------
stats_p1=graycoprops(CA_p1);
stats_p2=graycoprops(CA_p2);
stats_p3=graycoprops(CA_p3);
stats_p4=graycoprops(CA_p4);

features=[stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];
%---------------------------
stats_p1=graycoprops(CH1_p1);
stats_p2=graycoprops(CH1_p2);
stats_p3=graycoprops(CH1_p3);
stats_p4=graycoprops(CH1_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];

%---------------------------
stats_p1=graycoprops(CV1_p1);
stats_p2=graycoprops(CV1_p2);
stats_p3=graycoprops(CV1_p3);
stats_p4=graycoprops(CV1_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];
%---------------------------
stats_p1=graycoprops(CD1_p1);
stats_p2=graycoprops(CD1_p2);
stats_p3=graycoprops(CD1_p3);
stats_p4=graycoprops(CD1_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];
%---------------------------
stats_p1=graycoprops(CH2_p1);
stats_p2=graycoprops(CH2_p2);
stats_p3=graycoprops(CH2_p3);
stats_p4=graycoprops(CH2_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];
%---------------------------
stats_p1=graycoprops(CV2_p1);
stats_p2=graycoprops(CV2_p2);
stats_p3=graycoprops(CV2_p3);
stats_p4=graycoprops(CV2_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];

%---------------------------
stats_p1=graycoprops(CD2_p1);
stats_p2=graycoprops(CD2_p2);
stats_p3=graycoprops(CD2_p3);
stats_p4=graycoprops(CD2_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];
%---------------------------
stats_p1=graycoprops(CH3_p1);
stats_p2=graycoprops(CH3_p2);
stats_p3=graycoprops(CH3_p3);
stats_p4=graycoprops(CH3_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];

%---------------------------
stats_p1=graycoprops(CV3_p1);
stats_p2=graycoprops(CV3_p2);
stats_p3=graycoprops(CV3_p3);
stats_p4=graycoprops(CV3_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];
%---------------------------
stats_p1=graycoprops(CD3_p1);
stats_p2=graycoprops(CD3_p2);
stats_p3=graycoprops(CD3_p3);
stats_p4=graycoprops(CD3_p4);

features=[features ,stats_p1.Contrast stats_p1.Homogeneity stats_p1.Energy stats_p1.Correlation];
features=[features ,stats_p2.Contrast stats_p2.Homogeneity stats_p2.Energy stats_p2.Correlation];
features=[features ,stats_p3.Contrast stats_p3.Homogeneity stats_p3.Energy stats_p3.Correlation];
features=[features ,stats_p4.Contrast stats_p4.Homogeneity stats_p4.Energy stats_p4.Correlation];

%%
% To add the Cluster tendency feature-------------------------------------


CA_p1=Cooccurance_n(CA,p1);CA_p2=Cooccurance_n(CA,p2);CA_p3=Cooccurance_n(CA,p3);CA_p4=Cooccurance_n(CA,p4);
CH1_p1=Cooccurance_n(CH1,p1);CH1_p2=Cooccurance_n(CH1,p2);CH1_p3=Cooccurance_n(CH1,p3);CH1_p4=Cooccurance_n(CH1,p4);
CV1_p1=Cooccurance_n(CV1,p1);CV1_p2=Cooccurance_n(CV1,p2);CV1_p3=Cooccurance_n(CV1,p3);CV1_p4=Cooccurance_n(CV1,p4);
CD1_p1=Cooccurance_n(CD1,p1);CD1_p2=Cooccurance_n(CD1,p2);CD1_p3=Cooccurance_n(CD1,p3);CD1_p4=Cooccurance_n(CD1,p4);
CH2_p1=Cooccurance_n(CH2,p1);CH2_p2=Cooccurance_n(CH2,p2);CH2_p3=Cooccurance_n(CH2,p3);CH2_p4=Cooccurance_n(CH2,p4);
CV2_p1=Cooccurance_n(CV2,p1);CV2_p2=Cooccurance_n(CV2,p2);CV2_p3=Cooccurance_n(CV2,p3);CV2_p4=Cooccurance_n(CV2,p4);
CD2_p1=Cooccurance_n(CD2,p1);CD2_p2=Cooccurance_n(CD2,p2);CD2_p3=Cooccurance_n(CD2,p3);CD2_p4=Cooccurance_n(CD2,p4);
CH3_p1=Cooccurance_n(CH3,p1);CH3_p2=Cooccurance_n(CH3,p2);CH3_p3=Cooccurance_n(CH3,p3);CH3_p4=Cooccurance_n(CH3,p4);
CV3_p1=Cooccurance_n(CV3,p1);CV3_p2=Cooccurance_n(CV3,p2);CV3_p3=Cooccurance_n(CV3,p3);CV3_p4=Cooccurance_n(CV3,p4);
CD3_p1=Cooccurance_n(CD3,p1);CD3_p2=Cooccurance_n(CD3,p2);CD3_p3=Cooccurance_n(CD3,p3);CD3_p4=Cooccurance_n(CD3,p4);
%-------------------------------------
cluster=cluster_tendency_mean(CA_p1);
cluster=cluster+cluster_tendency_mean(CA_p2);
cluster=cluster+cluster_tendency_mean(CA_p3);
cluster=cluster+cluster_tendency_mean(CA_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CH1_p1);
cluster=cluster+cluster_tendency_mean(CH1_p2);
cluster=cluster+cluster_tendency_mean(CH1_p3);
cluster=cluster+cluster_tendency_mean(CH1_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CV1_p1);
cluster=cluster+cluster_tendency_mean(CV1_p2);
cluster=cluster+cluster_tendency_mean(CV1_p3);
cluster=cluster+cluster_tendency_mean(CV1_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CD1_p1);
cluster=cluster+cluster_tendency_mean(CD1_p2);
cluster=cluster+cluster_tendency_mean(CD1_p3);
cluster=cluster+cluster_tendency_mean(CD1_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CH2_p1);
cluster=cluster+cluster_tendency_mean(CH2_p2);
cluster=cluster+cluster_tendency_mean(CH2_p3);
cluster=cluster+cluster_tendency_mean(CH2_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CV2_p1);
cluster=cluster+cluster_tendency_mean(CV2_p2);
cluster=cluster+cluster_tendency_mean(CV2_p3);
cluster=cluster+cluster_tendency_mean(CV2_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CD2_p1);
cluster=cluster+cluster_tendency_mean(CD2_p2);
cluster=cluster+cluster_tendency_mean(CD2_p3);
cluster=cluster+cluster_tendency_mean(CD2_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CH3_p1);
cluster=cluster+cluster_tendency_mean(CH3_p2);
cluster=cluster+cluster_tendency_mean(CH3_p3);
cluster=cluster+cluster_tendency_mean(CH3_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CV3_p1);
cluster=cluster+cluster_tendency_mean(CV3_p2);
cluster=cluster+cluster_tendency_mean(CV3_p3);
cluster=cluster+cluster_tendency_mean(CV3_p4);
cluster=cluster/2;
features=[features,(cluster/4)];
%-------------------------------------
cluster=cluster_tendency_mean(CD3_p1);
cluster=cluster+cluster_tendency_mean(CD3_p2);
cluster=cluster+cluster_tendency_mean(CD3_p3);
cluster=cluster+cluster_tendency_mean(CD3_p4);
cluster=cluster/2;
features=[features,(cluster/4)];



%% Spectral Approach
% Features extracted are location of highest value , the mean and variance
% of both the amplitude and axial variations, and the distance between
% mean and the highest value of the function.
% And the number of peaks is of great importance--------------------------

[Srad,Sang,S]=specxture(f);
subplot(221);
plot(Srad);
subplot(222);
plot(Sang);
subplot(223);
imshow(S);
subplot(224);
imshow(f);

max_Srad=find(Srad==max(Srad));%location of highest value
max_Sang=find(Sang==max(Sang));%location of highest value


Srad=Srad/sum(Srad);
Sang=Sang/sum(Sang);

d1=1:length(Srad);
mean_Srad=ceil(d1*Srad');
d2=1:length(Sang);
mean_Sang=ceil(d2*Sang');

variance_Srad=((d1-mean_Srad).^2)*Srad';
variance_Sang=((d2-mean_Sang).^2)*Sang';

%Distance between mean and the highest value of the function.

Distance_m_h_Srad=abs(max_Srad-mean_Srad);
Distance_m_h_Sang=abs(max_Sang-mean_Sang);

features=[features,max_Srad,max_Sang,mean_Srad,mean_Sang,variance_Srad,variance_Sang,Distance_m_h_Srad,Distance_m_h_Sang];

%% Statistical approach from Image itself

texture_content_f=statxture(f);

features=[features,texture_content_f];






























