function b=Schmidt_orthogonalization(a)
[m,n] = size(a);
b=zeros(m,n);
b(:,1)=a(:,1);
for i=2:n
    for j=1:i-1
        b(:,i)=b(:,i)-dot(a(:,i),b(:,j))/dot(b(:,j),b(:,j))*b(:,j);
    end
    b(:,i)=b(:,i)+a(:,i);
end
end
