Npsss=100;
bigR=1;
    [phi,theta]=meshgrid(0:2*pi/Npsss:2*pi,0:pi/Npsss:pi);
i = optimization();
Nvals=size(theta);
C=zeros(Nvals);
for j = 1:Nvals(1)
    for k = 1:Nvals(2)
        k_matrix = stream_function(theta(j,k),phi(j,k),N,i);
        S = sum(k_matrix, 'all');
        C(j,k) = S;
    end
end
Ivals=C;
%%
[xcoil,ycoil,zcoil,zzcoil...
    ]=getcoilwindings_sphere2(theta,phi,bigR,Ivals,10);

for i=1:numel(xcoil)
    hold on
    if sign(zzcoil{i})==1
plot3(xcoil{i},ycoil{i},zcoil{i},'blue','linewidth',2);
    else
plot3(xcoil{i},ycoil{i},zcoil{i},'red','linewidth',2);
    end
end