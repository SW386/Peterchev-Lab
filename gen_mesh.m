[X,Y,Z] = ndgrid(0:0.01:0.32 , 0:0.01:0.32,0);
tri = delaunay(X,Y);
P(:,1) = X(:);
P(:,2) = Y(:);
P(:,3) = Z(:);

[RGW,centroid] = gen_RWG(P,tri);
E = gen_mesh_field(RGW,centroid,[1,1,0]);
