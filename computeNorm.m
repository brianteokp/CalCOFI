function NormTheta = computeNorm (X,y)
  
  NormTheta = pinv(X' * X) * X' * y

endfunction
