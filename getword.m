%getword  （字符获取）函数源代码：
%字符获取,自定义的字符函数
function[word,result]=getword(ii)
word=[];flag=0;y1=8;y2=0.5;
while flag==0
    [m,n]=size(ii);
    wide=0;
    while sum(ii(:,wide+1))~=0 && wide<=n-2
        wide=wide+1;
    end
    temp=charslice(imcrop(ii,[1 1 wide m]));
    [m1,n1]=size(temp);
    if wide<y1 && n1/m1>y2
        ii(:,1:wide)=0;
        if sum(sum(ii))~=0
            ii=charslice(ii);  % 切割出最小范围
        else word=[];flag=1;
        end
    else
        word=charslice(imcrop(ii,[1 1 wide m]));
        ii(:,1:wide)=0;
        if sum(sum(ii))~=0;
            ii=charslice(ii);
            flag=1;
        else ii=[];
        end
    end
end
result=ii;
 
