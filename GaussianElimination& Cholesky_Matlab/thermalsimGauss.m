function [ Temperature ] = thermalsimGauss( p, mediumX, mediumY, leftBound, rightBound, topBound, bottomBound )
%This function solves the 2D steady state thermal problem using Gaussian elimination
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

%Step 1: initialize the linear system
k=157;
[row col]=size(p);
dx2=(mediumX/(row-1))^2;
dy2=(mediumY/(col-1))^2;
len=row*col;
b=(-1/k)*p;
b(1,:)=b(1,:)-(1/dx2)*leftBound';
b(row,:)=b(row,:)-(1/dx2)*rightBound';
b(:,1)=b(:,1)-(1/dy2)*bottomBound;
b(:,col)=b(:,col)-(1/dy2)*topBound;
right_col=im2col(b',[col row],'distinct');

%step2: extract system feature with coefficient matrix
st = -2*((1/dx2)+(1/dy2))*ones(1,len);
Aj=(1/dy2)*ones(1,len-1);
for i=1:(row-1)
   Aj(i*col)=0;
end
Ai=(1/dx2)*ones(1,len-col);
Aj=diag(st)+diag(Ai,col)+diag(Ai,-col)+diag(Aj,1)+diag(Aj,-1);

%step3: implement Gaussian elimination
Aj(:,length(Aj)+1)=right_col; 
[rows cols]=size(Aj); 
for i=1:cols 
    for j=i+1:rows 
        tmp=Aj(i,:).*(-Aj(j,i)/Aj(i,i));
        Aj(j,:)=tmp+(Aj(j,:)); 
    end 
end 

x = zeros( rows, 1 );
for i=rows:-1:1
    x(i) = ( Aj(i,cols) - Aj(i, 1:rows)*x )/Aj(i, i);
end

%step4: display the result   
T=col2im(x,[col row],[col row],'distinct');
Temperature=T';
thermalplot(Temperature);
title('GaussianElimination-Case3')
end










