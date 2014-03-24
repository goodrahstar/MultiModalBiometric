for k=1:21
load('Radvector_max_all.mat')
R(1,:)=Radvector_max{k,1};
R(2,:)=Radvector_max{k,2};
R(3,:)=Radvector_max{k,3};
R(4,:)=Radvector_max{k,4};
R(5,:)=Radvector_max{k,5};
CV=cov(R);
[V,D] = eig(CV);
Footfe=V(1,:);

load('Radvector_max_all_palm.mat')
R(1,:)=Radvector_max{k,1};
R(2,:)=Radvector_max{k,2};
R(3,:)=Radvector_max{k,3};
R(4,:)=Radvector_max{k,4};
R(5,:)=Radvector_max{k,5};
CV=cov(R);
[V,D] = eig(CV);
Palmfe=V(1,:);
Class(k,:)=Palmfe+Footfe;
end
%%

theta= 0:179;
for sa=1:21
% load(sprintf('%s%i.mat',root1,i));
for i=1:5
try
Fi=sprintf('D_mat\\%i-%i.jpg',sa,i);
Im=imread(Fi);
catch exception
     if ~exist(Fi, 'file')
         [~, ~, extension] = fileparts(Fi);
          switch extension
         case '.jpg'
            altFilename = strrep(Fi, '.jpg', '.jpeg');
         case '.jpeg'
            altFilename = strrep(Fi, '.jpeg', '.jpg');
         
          end 
     end
     
     try 
         Im= imread(altFilename);
      catch exception2
         % Rethrow original error.
         rethrow(exception)
     end
end
foot=separate_foot(Im);
I=rgb2gray(foot.left.aimg);
% 
[Radvector,xp1] = radon(I,theta);
Radvector_max=log(max(Radvector(:,:))); 
Parameter(sa,i)=Class(sa,:)*Radvector_max';
end
end
%% 
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
%  Getting points
% point{1,k}= (sel_max{k,1}*R')';
% point{2,k}= (sel_max{k,2}*R')';
end

%%
for k=1:21
p(:,1)=point{1,k};
p(:,2)=point{2,k};
hold on, plot(p(1,1),p(1,2),'*r')
hold on, plot(p(2,1),p(2,2),'+g')
hold on, plot(p(3,1),p(3,2),'sb')
hold on, plot(p(4,1),p(4,2),'pk')
hold on, plot(p(5,1),p(5,2),'hm')
pause(0.1);drawnow();
end


%%
for sa=1:21
    for i=1:5
Parameter(sa,i)=Class(sa,:)*Radvector_max{sa,i}';
    end
end

