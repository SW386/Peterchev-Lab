function [RWG,centroids] = gen_RWG(P,tri)
    RWG = zeros(size(tri,1), 3,3);
    centroids = zeros(size(tri,1),3);
    for t = 1:size(tri,1)
        P1 = P(tri(t,1),:);
        P2 = P(tri(t,2),:);
        P3 = P(tri(t,3),:);
        centroid = mean([P1;P2;P3]);
        centroids(t,:) = centroid;
        RWG1 = (centroid-P1)/2;
        RWG2 = (centroid-P2)/2;
        RWG3 = (centroid-P3)/2;
        RWG(t,1,:) = RWG1;
        RWG(t,2,:) = RWG2;
        RWG(t,3,:) = RWG3;
    end
end