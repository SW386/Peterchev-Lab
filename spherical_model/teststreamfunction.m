function teststreamfunction
N=5;
theta = 1;
phi = 2;
[Ypos,Yneg,Srpos,Srneg] = Yfunc2(N,theta,phi);
test = [Srpos, Srneg];

globind=@(m,l) l+1+m*(N-(m-1)/2);

P=gen_matrix(N, cos(theta));
stream_function(1,2,P,phi)
Srpos(globind(1,2))



end

function Yval=computey(L,M,theta,phi)
[Ypos,Yneg]=Yfunc2(L,theta,phi);
if M>0
Yval=Ypos{2}(L+1+M*(L-(M-1)/2),:);
else 
    M = abs(M)
Yval=Yneg{2}(L+1+M*(L-(M-1)/2),:);
end

end

function [Ypos,Yneg,Srpos,Srneg]=Yfunc2(lmax,theta,phi)
globind=@(m,l) l+1+m*(lmax-(m-1)/2);
Npt=length(theta(:));
theta=reshape(theta(:),[1 Npt]);
phi=reshape(phi(:),[1 Npt]);
Ypos{2}=zeros([globind(lmax,lmax),Npt 3]);
Yneg{2}=zeros([globind(lmax,lmax),Npt 3]);
ct=1;
for m=1:lmax
Pvals=legendrep(m,lmax,cos(theta));
Pvals2=legendrep2(m,lmax,cos(theta)); %ensure no 0/0 at a small cost
Pprime=legendrepprime(m,lmax,cos(theta),Pvals);%this prime has the -sin(theta) integrated
for inloop=m:lmax
    l=inloop;
    harmind=globind(m,l);
    locind=inloop-m+1;
    Const=1/sqrt(l*(l+1))*sqrt(((2*l+1)/(2*pi)*factorial(l-m)/factorial(l+m)));    
Ypos{2}(harmind,:,2)=-Const*Pvals2(locind,:).*(-m*sin(m*phi)); %derivative w.r.t. phi
Ypos{2}(harmind,:,3)=(Const).*Pprime(locind,:).*cos(m*phi); %derivative w.r.t. theta
Yneg{2}(harmind,:,2)=Const*Pvals2(locind,:).*(m*cos(m*phi)); %derivative w.r.t. phi
Yneg{2}(harmind,:,3)=-(Const).*Pprime(locind,:).*sin(m*phi); %derivative w.r.t. theta

end
end
Pvals=legendrep(0,lmax,cos(theta));
Pprime=legendrepprime(0,lmax,cos(theta),Pvals);
for inloop=2:lmax+1
    l=inloop-1;
    harmind=globind(0,l);m=0;
    Const=1/sqrt(l*(l+1))*sqrt(((2*l+1)/(4*pi)*factorial(l-m)/factorial(l+m)));
Ypos{2}(harmind,:,3)=Const*Pprime(inloop,:);
Yneg{2}(harmind,:,3)=Ypos{2}(harmind,:,3);
end
[Srpos,Srneg]=Yval(lmax,theta,phi);
end
function [Ypos,Yneg]=Yval(lmax,theta,phi)
globind=@(m,l) l+1+m*(lmax-(m-1)/2);
Ypos=zeros([globind(lmax,lmax),length(theta(:))]);
Yneg=zeros([globind(lmax,lmax),length(theta(:))]);
for m=1:lmax
    legen=legendrep(m,lmax,cos(theta(:)));
    for innerloop=m:lmax
        l=innerloop;
        harmind=globind(m,l);
        Const=-1/sqrt(l*(l+1))*sqrt(((2*l+1)/(2*pi)*factorial(l-m)/factorial(l+m)));
        Ypos(harmind,:)=Const*legen(l-m+1,:).*cos(m*phi);
        Yneg(harmind,:)=-Const*legen(l-m+1,:).*sin(m*phi);
    end
end
legen=legendrep(0,lmax,cos(theta(:)));
    for innerloop=1:lmax
        l=innerloop;
        m=0;
        Const=-1/sqrt(l*(l+1))*sqrt(((2*l+1)/(2*pi)*factorial(l-m)/factorial(l+m)));
Ypos(l+1,:)=Const*legen(l+1,:)/sqrt(2);
Yneg(l+1,:)=Ypos(innerloop+1,:);
    end
end
function P=legendrep(m,l,x)
%computes all legendre polynomials in an array P^{m}_{m,m+1,...,l} 0=<m<=l
P=zeros([(l-m)+1 length(x(:))]);
x=reshape(x(:),[1 length(x(:))]);
fac2=prod(1:2:(2*m-1));
P(1,:)=(-1)^(m)*fac2*(1-x.^2).^(m/2); %P^m_l l=m
if m<l
P(2,:)=x.*(2*m+1).*P(1,:);%P^m_l l=m+1
end
for lval=m+2:l
P(lval-m+1,:)=((2*lval-1)*x.*P(lval-m,:)-(lval+m-1)*P(lval-m-1,:))/(lval-m); %P^m_l l=m+1+loopit
end

end
function P=legendrep2(m,l,x)
%computes all legendre polynomials in an array P^{m}_{m,m+1,...,l} 0=<m<=l
P=zeros([(l-m)+1 length(x(:))]);
x=reshape(x(:),[1 length(x(:))]);
fac2=prod(1:2:(2*m-1));
P(1,:)=(-1)^(m)*fac2*(1-x.^2).^(m/2-1/2);
if m<l
P(2,:)=x*(2*m+1).*P(1,:);
end
for lval=m+2:l
P(lval-m+1,:)=((2*lval-1)*x.*P(lval-m,:)-(lval+m-1)*P(lval-m-1,:))/(lval-m);
end
end
function Pprime=legendrepprime(m,l,x,P)
%computes all legendre polynomials in an array P'^{m}_{m,m+1,...,l} 0=<m<=l
Pprime=zeros([(l-m)+1 length(x(:))]);
x=reshape(x(:),[1 length(x(:))]);
fac2=prod(1:2:(2*m-1));
if m~=0
Pprime(1,:)=m/2*(-1)^(m)*fac2*(-2*x).*(1-x.^2).^(m/2-1); 
else
Pprime(1,:)=0;     
end
if m<l
Pprime(2,:)=(2*m+1).*P(1,:).*(1-x.^2).^(1/2)+(2*m+1).*x.*Pprime(1,:);
end
for lval=m+2:l
Pprime(lval-m+1,:)=((2*lval-1)*P(lval-m,:).*(1-x.^2).^(1/2)+...
    (2*lval-1)*x.*Pprime(lval-m,:)-(lval+m-1)*Pprime(lval-m-1,:))/(lval-m);
end
Pprime=-Pprime;%-(1-x.^2)^1/2 is negative sin

end

function [P, dPx] = gen_matrix(N, x)
    P = zeros(N, N+1);
    dPx = zeros(N, N+1);
    for M = 0:N
        if M == 0
            base0 = x;
            base1 = 0.5*(3*x^2-1);
            P(1,M+1) = base0;
            P(2,M+1) = base1;
        elseif M == 1
            base0 = -sqrt(1-x^2);
            base1 = 3*x*base0;
        else 
            base0 = (-1)^M*prod(1:2:(2*M-1))*sqrt((1-x^2)^M);
            base1 = (2*M+1)*x*base0;
        end
        for L = 1:N
            if L == M && M~=0
                P(L,M+1) = base0;
            elseif L == M+1 && M~=0
                P(L,M+1) = base1;
            elseif L >= 3 
                P(L, M+1) = (x*(2*L-1)*P(L-1,M+1) - (L+M-1)*P(L-2, M+1))/(L-M);
            end 
        end    
    end
    for M = 0:N
        if M == 0
            base0 = 1;
            base1 = 3*x;
            dPx(1,M+1) = base0;
            dPx(2,M+1) = base1;
        elseif M == 1
            base0 = x*(1-x^2)^(-1/2);
            base1 = (2*M+1)*P(M,M+1) + (2*M+1)*x*base0;
        else 
            base0 = (-1)^M*prod(1:2:(2*M-1))*(-x*M*(1-x^2)^(M/2-1));
            base1 = (2*M+1)*P(M,M+1) + (2*M+1)*x*base0;
        end
        for L = 1:N
            if L == M && M~=0
                dPx(L,M+1) = base0;
            elseif L == M+1 && M~=0
                dPx(L,M+1) = base1;
            elseif L >= 3 
                dPx(L,M+1) = ((2*L-1)*P(L-1,M+1) + x*(2*L-1)*dPx(L-1,M+1) - (L+M-1)*dPx(L-2,M+1))/(L-M);
            end 
        end
    end
end