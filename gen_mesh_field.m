function E = gen_mesh_field(RWG,centroids,r)
    E = zeros(1,3);
    for i = 1:size(centroids,1)
        for j = 1:3
            E(1,1) = E(1,1) + RWG(i,j,1)/norm(r-centroids(i,:));
            E(1,2) = E(1,2) + RWG(i,j,2)/norm(r-centroids(i,:));
            E(1,3) = E(1,3) + RWG(i,j,3)/norm(r-centroids(i,:));
        end
    end
    E = E*10^(-7);
end
