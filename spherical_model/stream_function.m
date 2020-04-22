function k_matrix = stream_function(theta,phi,N,i)
    k_matrix = zeros(N, 2*N+1);
    [P, dPx] = gen_matrix(N, cos(theta));
    globind=@(m,l) l+1+m*(N-(m-1)/2);
    for L = 1:N
        for M = -L:L
            if M >= 0
              i_index = globind(M,L);
            else
              i_index = globind(abs(M),L)+ globind(N,N);
            end
            k = -1*eval(M,L,P,phi)*i(i_index)/sqrt(L*(L+1));
            M_index = M+L+1;
            k_matrix(L,M_index) = k;
        end
    end
end
function k = eval(M,L,P,phi)
    if M>0 
        const = sqrt((2*L+1)*factorial(L-M)/(2*pi*factorial(L+M)));
        Yml = const*P(L,M+1)*cos(M*phi);
    elseif M==0
        Yml = sqrt((2*L+1)/(4*pi))*P(L,1);
    else 
        const = -sqrt((2*L+1)*factorial(L+M)/(2*pi*factorial(L-M)));
        Yml = const*P(L,-M+1)*sin(M*phi);
    end
    k = Yml/(sqrt(L*(L+1)));
end



