%returns [mel]
function [mel]=f2mel(f)

%so mel will be the result of this calculation on the right

  mel=2595 * log10(double(1+f/700));

  
  