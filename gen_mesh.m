clear all

[X,Y,Z] = ndgrid(-0.16:0.005:0.16 , -0.16:0.005:0.16, 0.097);
tri = delaunay(X,Y);
P(:,1) = X(:);
P(:,2) = Y(:);
P(:,3) = Z(:);
hold on

[RGW,centroid] = gen_RWG(P,tri);
RGW=reshape(permute(RGW,[2 1 3]),[numel(tri) 3]);
%E = gen_mesh_field(RGW,centroid,[1,1,0]);
[~,~,~,~,inodes,Aloop,Arwg,~,~,~]=extractmesharrays(tri,P);
Aloop=Arwg*Aloop(:,inodes);
[~,cc]=ndgrid(1:3,1:numel(tri)/3);

FEMord=2;
reflev=0;
load(strcat('E:\Kevin Wen\TMS_Efield_Solvers\samplescenario',num2str(reflev),'.mat'));
E_field = zeros(3,2,size(Aloop,2));
r = [0 0;
    0 0;
    0.0849 0.07];

for j = 1:size(Aloop,2)
    ns=nnz(Aloop(:,j));
    rs=zeros([3 ns]);
    js=zeros([3 ns]);
    ct=1;
    for i=1:numel(Aloop(:,1))
        if Aloop(i,j)~=0
            rs(1:3,ct)=transpose(centroid(cc(i),1:3));
            js(1:3,ct)=Aloop(i,j)*RGW(i,1:3);
            ct=ct+1;
        end
    end
    %Runcode requires addpath from TMS E-Field Solvers
    addpath('E:\Kevin Wen\TMS_Efield_Solvers\FEM_MEX_C_codes');
    [E1,~,~,~,~]=runcode(te2p',p',conductivity,rs,js,r,FEMord);
    E_field(:,:,j) = E1;
end

save Efieldsloop.mat E_field;