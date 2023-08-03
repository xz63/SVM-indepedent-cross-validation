function a=scramble2(Y)
% Author: Dr. Xian Zhang from Yale school of medicine, Psychiatry Department
%Y has two values  and a is the scrambled Y
%rng('default') 
a=Y;
b=rand(length(Y),1);
[~,ii]=sort(b);
a=Y(ii);
a=(b>0.5)+1;

