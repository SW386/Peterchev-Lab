function object = objective_mesh(A)
load('Efieldsloop.mat');
field_outer = zeros(3,1);
for i = 1:size(E_field,3)
    field_outer(1,1) = field_outer(1,1) + A(i)*E_field(1,1,i);
    field_outer(2,1) = field_outer(1,1) + A(i)*E_field(2,1,i);
    field_outer(3,1) = field_outer(1,1) + A(i)*E_field(3,1,i);
end
field_inner = zeros(3,1);
for i = 1:size(E_field,3)
    field_inner(1,1) = field_inner(1,1) + A(i)*E_field(1,2,i);
    field_inner(2,1) = field_inner(2,1) + A(i)*E_field(2,2,i);
    field_inner(3,1) = field_inner(3,1) + A(i)*E_field(3,2,i);
end
object = norm(field_inner(1,1))/norm(field_outer(1,1));
end
