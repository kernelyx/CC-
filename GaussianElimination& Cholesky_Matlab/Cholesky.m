function [res,L] = Cholesky(A,B) 
[m,n]=size(A);
    L=zeros(m,m);%Initialize to all zeros
for i=1:n
   L(i, i) = sqrt(A(i, i) - L(i, :)*L(i, :)');
   for j=(i + 1):n
      L(j, i) = (A(j, i) - L(i,:)*L(j ,:)')/L(i, i);
   end
end

%solve lower triangle matrix
m= 3;
y = L\B
V = zeros(m,1);
for i=1:m-1
    V(i) = L(i,i)\B(i);
    B(i+1) = B(i+1) - sum(L(i+1,1:i)*V(1:i)) ;
end
V(m) = L(m,m)\B(m);
V

%solve upper triangle matrix
tmp = L';
T = zeros(m,1);
for i=m:-1:2
    T(i) = V(i)/tmp(i,i);
    V(i-1) = V(i-1) - tmp(i-1,i:m)*T(i:m);
end

T(1) = V(1)/tmp(1,1);
res = T;

%step4: display the result
% Temperature = reshape(T, rows,cols);
% thermalplot(Temperature');
end
