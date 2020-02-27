function [xcoil,ycoil,zcoil,zzcoil...
    ]=getcoilwindings2(theta,phi,bigR,Att,N)


ms=max(Att);
mi=min(Att);
del=(ms-mi)/N;
levs=mi+del/2:del:ms-del/2;
subplot(2,1,1),
[cou,hout] = contour(theta,phi,Att,levs);

view([0 0 1]);
hold on
subplot(2,1,2),

    en=0;
c=cou;
ct=1;
while en<numel(c(1,:))
    st=en+1;
en=c(2,st)+st;
height=c(1,st);
if sign(c(1,st))==1
    col='r';
    sig(ct)=1;
else
    sig(ct)=-1;
    col='b';
end
st=st+1;

clear temp

xcoil{ct}=bigR*sin(c(1,st:en)).*cos(c(2,st:en));
ycoil{ct}=bigR*sin(c(1,st:en)).*sin(c(2,st:en));
zcoil{ct}=bigR*cos(c(1,st:en));
zzcoil{ct}=height;
ct=ct+1;
if height==1
plot3(xcoil{ct},ycoil{ct},zcoil{ct},'blue','linewidth',2);
elseif height==2
plot3(xcoil{ct},ycoil{ct},zcoil{ct},'red','linewidth',2);
end
hold on

end

