x0 = zeros(961,1);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
objective(x0);
A = fmincon(@objective_mesh,x0,A,b,Aeq,beq,lb,ub,@cost_min_mesh);