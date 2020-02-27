function [c,ceq] = cost_min(i)
    r = 85;
    R = 85;
    theta = pi/10;
    phi = pi/10;
    N = 25;
    c = -energy(R,N,i);
    ceq = 1 - norm(gen_field(r,R,theta,phi,N,i));
end

function U = energy(R,N,i)
    const = (4*pi*10^(-7))/2;
    U = 0;
    globind=@(m,l) l+1+m*(N-(m-1)/2);
    for L = 1:N
        for M = -L:L
            if M >= 0
              index = globind(M,L);
            else
              index = globind(abs(M),L)+ globind(N,N);
            end
            U = U + ((i(index))^2 * R) / (2*L + 1);
        end
    end
    U = const*U;
  
end
