function k = stream_function(M,L,P,theta,phi)
    if M>0 
        const = sqrt((2*L+1)*factorial(L-M)/(2*pi*factorial(L+M)));
        Yml = const*P(L,M+1)*cos(M*phi);
    elseif M==0
        Yml = sqrt((2*L+1)/(4*pi))*P(1,1);
    else 
        const = -sqrt((2*L+1)*factorial(L+M)/(2*pi*factorial(L-M)));
        Yml = const*P(L,-M+1)*sin(M*phi);
    end
    k = Yml/(sqrt(L*(L+1)));
end



