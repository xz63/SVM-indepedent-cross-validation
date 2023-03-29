function a=scramble2(Y)
% Author: Dr. Xian Zhang from Yale school of medicine, Psychiatry Department
%Y has two values  and a is the scrambled Y
%rng('default') 
a=Y;
yr(1)=max(Y);
yr(2)=min(Y);
for j=1:2
    inds=find(Y==yr(j));
    n=length(inds); n2=floor(n/2);
    clear yy2
    yy2((n2+1):(2*n2))=yr(1);
    yy2(1:n2)=yr(2);
    if n2*2<n; yy2(n) = yr(mod(round(rand(1,1)*100),2)+1); end
    [~,ii]=sort(rand(n,1));
    yy2=yy2(ii);
    a(inds)=yy2;
end
