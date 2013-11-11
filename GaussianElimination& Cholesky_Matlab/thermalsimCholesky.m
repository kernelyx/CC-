function [ Temperature ] = thermalsimCholesky( p, mediumX, mediumY, leftBound, rightBound, topBound, bottomBound )
%THERMALSIMCHOLESKY solves the 2D steady state thermal problem using
%Cholesky factorization
%   INPUT:
%   p:  discretized power density
%   mediumX:    x-dimension of the medium
%   mediumY:    y-dimension of the medium
%	leftBound:	Temperature at the left boundary (x=0), leftBound(j) means
%	the temperature at T(0,j)
%	rightBound:	Temperature at the right boundary (x=N+1)
%	topBound:	Temperature at the top boundary (y=M+1)
%	bottomBound:	Temperature at the bottom boundary (y=0)
%
%   OUTPUT:
%   Temperature: solved thermal map

[row, col] = size(p);
len = row*col;
len = row*col;
dx2  = (mediumX/(row-1))^2;
dy2  = (mediumY/(col-1))^2;
K    = 157;
rate = dx2/dy2;

B = zeros(row,col);
B   = -p/K;
B(1,:) = B(1,:)-(1/dx2)*leftBound';
B(row,:) = B(row,:)-(1/dx2)*rightBound';
B(:,1)   = B(:,1)-(1/dy2)*bottomBound;
B(:,col) = B(:,col)-(1/dy2)*topBound;
B =im2col(B',[col row],'distinct');


% len = row*col;
% B = reshape(B',len , 1);
% B = B/parm;
% A = zeros(len,len);
% %step2: extract system feature with linear equation
% for r = 1:row
%    for c = 1:col
%        indx = col*(r-1)+c;
%        A(indx,indx)   = -2 - 2*rate;
%        
%         if(c>1)
%             A(indx,indx-1) = rate;
%         end
%         if(c<col)
%             A(indx,indx+1) = rate;
%         end
%         if( r >1 )
%             A(indx,indx-col)   = 1;
%         end
%         if(r<row)
%             A(indx,indx+col)   = 1;
%         end
%         
%    end
%   
% end

st = -2*((1/dx2)+(1/dy2))*ones(1,len);
Aj=(1/dy2)*ones(1,len-1);
for i=1:(row-1)
   Aj(i*col)=0;
end
Ai=(1/dx2)*ones(1,len-col);
A=diag(st)+diag(Ai,col)+diag(Ai,-col)+diag(Aj,1)+diag(Aj,-1);


% step 3 implement cholesky to solve the problem
A = -A;
B = -B;
L=zeros(len,len);%Initialize to all zeros
for i=1:len
   L(i, i) = sqrt(A(i, i) - L(i, :)*L(i, :)');
   for j=(i + 1):len
      L(j, i) = (A(j, i) - L(i,:)*L(j ,:)')/L(i, i);
   end
end

% L = chol(A);

%solve lower triangle matrix
V = zeros(len,1);
for i=1:len-1
    V(i) = B(i)/L(i,i);
    B(i+1) = B(i+1) - L(i+1,1:i)*V(1:i) ;
end
V(len) = B(len)/L(len,len);

%solve upper triangle matrix
tmp = L';
T = zeros(len,1);
for i=len:-1:2
    T(i) = V(i)/tmp(i,i);
    V(i-1) = V(i-1) - tmp(i-1,i:len)*T(i:len);
end

T(1) = V(1)/tmp(1,1);

%step4: display the result
%T = inv(L*L')*B;
Temperature=col2im(T,[col row],[col row],'distinct'); % reshape cause the blank in blue
thermalplot(Temperature');
title('Cholesky-case3');

end 
 
 
 
 
 
 
 
 
