function [ Temperature ] = Gauss( p, mediumX, mediumY, LB, RB, TB, BB )
%THERMALSIMGAUSS solves the 2D steady state thermal problem using Gaussian
%elimination
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
%   Temperature: solved thermal map°@32X32

k=157;
[m n]=size(p);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dx2=(mediumX/(m-1))^2;
dy2=(mediumY/(n-1))^2;
unknow=m*n;
b=(-1/k)*p;
b(1,:)=b(1,:)-(1/dx2)*LB';
b(m,:)=b(m,:)-(1/dx2)*RB';
b(:,1)=b(:,1)-(1/dy2)*BB;
b(:,n)=b(:,n)-(1/dy2)*TB;
right_col=im2col(b',[n m],'distinct');
%%%%%%%%%% coefficient matrix %%%%%%%%%
%%%%%%%% self *2 T (i,j) %%%%%%%%%%%%
v=-2*((1/dx2)+(1/dy2))*ones(1,unknow);
dj=(1/dy2)*ones(1,unknow-1);
   for i=1:(m-1)
    dj(i*n)=0;
   end
di=(1/dx2)*ones(1,unknow-n);
A=diag(v)+diag(di,n)+diag(di,-n)+diag(dj,1)+diag(dj,-1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xg] = gauss_elimnation(A,right_col);
Tg=col2im(xg,[n m],[n m],'distinct');
Temperature=Tg';

thermalplot(Temperature);
end

function [x] = gauss_elimnation(a,b)  
  a(:,length(a)+1)=b; 
  [rows cols]=size(a); 
%   answer=zeros(rows,1); 
  for i=1:cols 
    for j=i+1:rows 
    tmp=a(i,:).*(-a(j,i)/a(i,i));
    a(j,:)=tmp+(a(j,:)); 
    end 
  end 

    x = zeros( rows, 1 );
   for i=rows:-1:1
   x(i) = ( a(i,cols) - a(i, 1:rows)*x )/a(i, i);
   end
   
   
end



