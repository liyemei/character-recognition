function  y=charslice(ii)
[m,n]=size(ii);
top=1;bottom=m;left=1;right=n;
while sum(ii(top,:))==0 && top<m
    top=top+1;
end
while sum(ii(bottom,:))==0 && bottom>=1
    bottom=bottom-1;
end
while sum(ii(:,left))==0 && left<n
    left=left+1;
end
while sum(ii(:,right))==0 && right>=1
    right=right-1;
end
ydiff=bottom-top;
xdiff=right-left;
y=imcrop(ii,[left top xdiff ydiff]);
 
