x0 = ones(961,1);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
objective(x0);
A = fmincon(@objective_mesh,x0,A,b,Aeq,beq,lb,ub,@cost_min_mesh);
objective(A)
cost_min_mesh(A)