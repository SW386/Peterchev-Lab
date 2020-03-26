function [c,ceq] = cost_min_mesh(A)
c = 0;

load('Efieldsloop.mat');
field_inner = zeros(3,1);
for i = 1:size(E_field,3)
    field_inner(1,1) = field_inner(1,1) + A(i)*E_field(1,2,i);
    field_inner(2,1) = field_inner(1,1) + A(i)*E_field(2,2,i);
    field_inner(3,1) = field_inner(1,1) + A(i)*E_field(3,2,i);
end

ceq = 1- norm(field_inner);
end
