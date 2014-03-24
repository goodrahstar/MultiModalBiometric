%%
[file, path] = uigetfile('*.jpeg;*.jpg;*.bmp', 'Pick a File');
filea=strcat(path,file);
Foot_image=imresize(imread(filea),0.5);

Separate_foot=separate_foot(Foot_image);
Left=rgb2gray(Separate_foot.left.aimg);
%% 
[Radvector,xp1] = radon(Left,0:179);
R_max=log(max(Radvector(:,:))); 
load Radvector_max_all
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

Npoint{1,k}= (sel_max{k,1}*R_max')';
Npoint{2,k}= (sel_max{k,2}*R_max')';
end
%% 
load Feature_point_with_Radvector_FOOT
p=Npoint';
p=cell2mat(p);
for k=1:21
Database_point(k,1)=mean(Coord_points{1,k}) ;   
Database_point(k,2)=mean(Coord_points{2,k}) ;   

hold on, plot(Database_point(k,1),Database_point(k,2),'*');
pause(1);drawnow();
% 
hold on, plot(p(k,1),p(k,2),'Or');
pause(1);drawnow();
end

