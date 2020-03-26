function object = objective(i) 
    r = 85;
    R = 85;
    theta = pi/10;
    phi = pi/10;
    N = 25;
    object = -norm(gen_field(r,R,theta,phi,N,i));
end
