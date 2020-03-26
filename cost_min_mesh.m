function [c,ceq] = cost_min_mesh(A)
load('C:\Users\Shufan Wen\Desktop\Lab\Peterchev-Lab\Efieldsloop.mat');
field_outer = zeros(3,1);
for i = 1:size(E_field,3)
    field_outer(1,1) = field_outer(1,1) + A(i)*E_field(1,1,i);
    field_outer(2,1) = field_outer(2,1) + A(i)*E_field(2,1,i);
    field_outer(3,1) = field_outer(3,1) + A(i)*E_field(3,1,i);
end
c = 1-norm(field_inner);
ceq = 0;
end
