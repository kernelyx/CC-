function [ Temperature ] = thermalsimGauss_old( p, mediumX, mediumY, leftBound, rightBound, topBound, bottomBound )
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
%   Temperature: solved thermal map

%solve linear system with Gaussian elimination
%Step 1: initialize the linear system
[row, col] = size(p);
len = row*col;
% T(:,1) = leftBound;
% T(1,:) = topBound;
% T(:,col) = rightBound;
% T(row,:) = bottomBound;

K = 157;
meduim = mediumX;
parm = K/meduim;

B = reshape(-p,len , 1);
B = B/parm;
A = zeros(len,len);
%step2: extract system feature with linear equation
for r = 1:row
   for c = 1:col
       indx = col*(r-1)+c;
       if( (r-1) == 0 )%leftBound
           B(indx) = B(indx) - leftBound(c);
       end
       if( (r+1) > row)%rightBound
           B(indx) = B(indx) - rightBound(c);
       end
       if( (c-1)== 0 )%bottomBound
           B(indx) = B(indx) - topBound(r);
       end
       if( (c+1) > col )%topBound
           B(indx) = B(indx) - bottomBound(r);
       end
       A(indx,indx)   = -4;
       
        if(c>1)
            A(indx,indx-1) = 1;
        end
        if(c<col)
            A(indx,indx+1) = 1;
        end
        if( r >1 )
            A(indx,indx-col)   = 1;
        end
        if(r<row)
            A(indx,indx+col)   = 1;
        end
        
   end
  
end

%step3: implement Gaussian elimination
T = zeros(len,1);
for i=1:len
for j=i+1:len 
    ratio = (-A(j,i)/A(i,i));
    tmpA=A(i,:).* ratio; 
    A(j,:)=tmpA+(A(j,:)); 
    tmpB = B(i)*ratio;
    B(j) = tmpB + B(j);
end 
end 

for i=len:-1:2
    T(i) = B(i)/A(i,i);
    B(i-1) = B(i-1) - A(i-1,i:len)*T(i:len) ;
end
T(1) = B(1)/A(1,1);

%step4: display the result
% T= inv(A)*B;
Temperature = reshape(T, row,col);
thermalplot(Temperature');

end









