function object = objective(i) 
    r = 70;
    R = 85;
    theta = pi/4;
    phi = pi/4;
    N = 25;
    object = norm(gen_field(r,R,theta,phi,N,i));
end
