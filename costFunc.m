function [jVal,gradient] = costFunc (X,y,theta)
m=length(y);

h = X * theta;
diff = h - y;
sq = diff.^2;
jVal = 1/(2*m) * sum(sq);

gradient(1) =  sum(h-y);
%Note that your gradient includes the 1/m portion!
gradient(1) = 1/m * gradient(1);
gradient(2) = (h-y)' * X(:,2);
gradient(2) = 1/m * gradient(2);

endfunction
