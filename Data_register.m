% This file take the image as input and returns the feature vector from the
% input image. Input image is foot print and palm print 

%% Input image 
[file, path] = uigetfile('*.jpeg;*.jpg;*.bmp', 'Pick a File');
filea=strcat(path,file);
Image=imread(filea);
%% Preprocessing
Separate_foot=separate_foot(Image);
clear Image;
Left=rgb2gray(Separate_foot.left.img);
%% 
[Radvector,xp1] = radon(Left,0:179);
for k=1:21
R(1,:)=Radvector_max{k,1};
R(2,:)=Radvector_max{k,2};
R(3,:)=Radvector_max{k,3};
R(4,:)=Radvector_max{k,4};
R(5,:)=Radvector_max{k,5};
CV=cov(R);
[V,D] = eig(CV);
% selecting max eigen 
sel_max{k,1}= V(1,:);  
sel_max{k,2}= V(2,:);
end
