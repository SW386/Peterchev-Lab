load('Efieldsloop.mat');
[X,Y,Z] = ndgrid(-0.16:0.005:0.16 , -0.16:0.005:0.16, 0.097);
size(X)
tri = delaunay(X,Y);
P(:,1) = X(:);
P(:,2) = Y(:);
P(:,3) = Z(:);

load('A_weights.mat');
Efieldmap = zeros(size(P,1), 1);
Efieldmap(inodes)= A;
trisurf(tri,P(:,1),P(:,2),P(:,3),Efieldmap(:));
close all;

mEf=max(Efieldmap(:));
minEf=min(Efieldmap(:));
N = 8;
del=(mEf-minEf)/N;
range=minEf+del/2:del:mEf-del/2;
[cout,hout] = tricontour(P(:,1:2),tri,Efieldmap,range);

view(2);