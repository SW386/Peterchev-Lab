function i = optimization()
x0 = zeros(1000,1);
A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
objective(x0);
i = fmincon(@objective,x0,A,b,Aeq,beq,lb,ub,@cost_min);
end