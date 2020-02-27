N = 25;
i = optimization();
[X,Y,Z] = sphere(100);
[az,el,r] = cart2sph(X,Y,Z);
C = zeros(101);
for j = 1:101
    for k = 1:101
        theta = az(j,k);
        phi = el(j,k);
        k_matrix = stream_function(theta,phi,N,i);
        S = sum(k_matrix, 'all');
        C(j,k) = S;
    end
end
surf(X,Y,Z,C)
        
        