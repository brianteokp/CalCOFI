function J = computeCost (X,y,theta)

m = length(y);
h = X * theta;
diff = h - y;
sq = diff.^2;
J = 1/(2*m) * sum(sq);

endfunction
