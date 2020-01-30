function E = gen_field(r,R,theta,phi,N,i)
    const = 1/(4*pi*10^(-7));
    temp_val = zeros(3,1);
    E = zeros(3,1);
    [P, dPx] = gen_matrix(N, cos(theta));
    for L = 1:N
        for M = -L:L
            Ymll = cross_prod(M, L, r, theta, phi, P, dPx);
            scalar = (i/(2*L+1))*(r/R)^L;
            temp_val(2,1) = Ymll(2)*scalar + temp_val(2,1);
            temp_val(3,1) = Ymll(3)*scalar + temp_val(3,1);
        end
    end
    E(2,1) = const*temp_val(2,1);
    E(3,1) = const*temp_val(3,1);
end

function Ymll = cross_prod(M, L, r, theta, phi, P, dPx)
    dYml = gen_gradient(M,L,theta,phi, P,dPx);
    rvector = zeros(3,1);
    rvector(1,1) = (sqrt(L*(L+1)))^(-1) * r;
    Ymll = cross(rvector, dYml);
end

function dYml = gen_gradient(M,L,theta,phi,P,dPx)
    dYml = zeros(3,1);
    if M > 0
        const = sqrt((2*L+1)*factorial(L-M)/(2*pi*factorial(L+M)));
        dYml(2,1) = const*dPx(L,M+1)*(-sin(theta))*cos(M*phi);
        dYml(3,1) = const*P(L,M+1)*(-M*sin(M*phi));
    elseif M == 0
        dYml(2,1) = sqrt((2*L+1)/(4*pi))*dPx(1,1)*(-sin(theta));
    else
        const = -sqrt((2*L+1)*factorial(L+M)/(2*pi*factorial(L-M)));
        dYml(2,1) = const*dPx(L,-M+1)*(-sin(theta))*sin(M*phi);
        dYml(3,1) = const*P(L,-M+1)*(M*cos(M*phi));
    end
end





