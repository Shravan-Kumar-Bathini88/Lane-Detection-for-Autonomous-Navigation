% This function calculates the Co-occurance matrix ,normalized one, of a gray level image
% which is actually a measure for statistical property of texture.
%
%
% The output is unrolled vectors, and it is needed to convert to matrix form
% by using
%
%
%G=reshape(C,size_x,size_y);
%%
function[C]=Cooccurance_n(f,p)

[rows,columns]=size(f);
%g=reshape(f,rows,columns);
maxf=max(f(:));
A=zeros(maxf+1,maxf+1);
for i=1:rows
    for j=1:columns
       q=[i,j];
       rs=floor(q+p);
        if((rs(1)<= rows && rs(2)<= columns)&&(rs(1)>0 && rs(2)>0)) 
            A(f(i,j)+1,f(rs(1),rs(2))+1)=A(f(i,j)+1,f(rs(1),rs(2))+1) + 1;
        end
       
    end
    
end
 n=sum(sum(A));
 A=A/n;
% [size_x ,size_y]=size(A);
C=A;



