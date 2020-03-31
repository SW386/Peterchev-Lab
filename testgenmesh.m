load('Efieldsloop.mat');
[X,Y,Z] = ndgrid(-0.15:0.01:0.16 , -0.15:0.01:0.16, 0.097);
tri = delaunay(X,Y);
P(:,1) = X(:);
P(:,2) = Y(:);
P(:,3) = Z(:);
hold on

[RGW,centroid] = gen_RWG(P,tri);
RGW=reshape(permute(RGW,[2 1 3]),[numel(tri) 3]);
%E = gen_mesh_field(RGW,centroid,[1,1,0]);
[~,~,~,~,inodes,Aloop,Arwg,~,~,~]=extractmesharrays(tri,P);

Efieldmap = zeros(size(P,1), 1);
E_outer = squeeze(E_field(:,1,:));
normE=sqrt(sum(E_outer.^2,1));
Efieldmap(inodes)=normE;
close all;
trisurf(tri,P(:,1),P(:,2),P(:,3),Efieldmap(:))