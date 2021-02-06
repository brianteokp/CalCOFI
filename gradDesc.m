function [theta,J_history] = gradDesc (X,y,alpha,num_iter,theta)

J_history = zeros(num_iter,1);

for iter = 1:num_iter
  m = length(y);
  h = X * theta;
  
  gradient1 = sum(h-y);
  gradient2 = (h-y)' * X(:,2);
  
  theta(1) = theta(1) - alpha * (1/m) * gradient1;
  theta(2) = theta(2) - alpha * (1/m) * gradient2;
  
  J_history(iter) = computeCost(X,y,theta);
endfor;
  
endfunction
