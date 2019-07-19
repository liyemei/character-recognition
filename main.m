tic
I=imread('字符.jpg');  %打开图片
%figure(1);imshow(I);title('原始图像','color','b');
 
I=rgb2gray(I);  %RGB图片转化成灰度图像
%figure(2);imshow(I);title('灰度图像','color','b');
 
i_max=double(max(max(I)));  %获取亮度最大值
i_min=double(min(min(I)));  %获取亮度最小值
thresh=round(i_max-((i_max-i_min)/3));  %计算灰度图像转化成二值图像的门限thresh
I=(I>=thresh);  %I为二值图像
%figure(3);imshow(I);title('二值图像','color','b');
 
seY=[1;1;1];  %构造结构元素
I=imdilate(I,seY);  %腐蚀图像
I=imerode(I,seY);  %膨胀图像
seX=[1 1 1];
I=imdilate(I,seX);
I=imerode(I,seX);
%figure(4);imshow(I);title('腐蚀膨胀后的图像','color','b');
 
ii=double(I);
[m,n]=size(ii);  %获取图像大小信息
%确定文字区域
%纵向扫描
countY=zeros(m,1);
for i=1:m
    for j=1:n
        if ii(i,j)==0
            countY(i,1)=countY(i,1)+1;
        end
    end
end
[maxY indexY]=max(countY);
tempY1=indexY;
while (countY(tempY1,1)>3) && (tempY1>1)
    tempY1=tempY1-1;
end
tempY2=indexY;
while (countY(tempY2,1)>3) && (tempY2<m)
    tempY2=tempY2+1;
end
tempY1=tempY1-1;
tempY2=tempY2+1;
iiY=I(tempY1:tempY2,:);  %确定了Y方向上的文字区域
%figure(5);imshow(iiY);title('Y方向区域大致确定后的图像','color','b');
 
%横向扫描
countX=zeros(1,n);
for j=1:n
    for i=tempY1:tempY2
        if ii(i,j)==0
            countX(1,j)=countX(1,j)+1;
        end
    end
end
tempX1=1;
while (countX(1,tempX1)<3) && (tempX1<n)
    tempX1=tempX1+1;
end
tempX2=n;
while (countX(1,tempX2)<3) && (tempX2>1)
    tempX2=tempX2-1;
end
tempX1=tempX1-1;
tempX2=tempX2+1;
iiXY=iiY(:,tempX1:tempX2);  %确定了整体的文字区域
%figure(6);imshow(iiXY);title('X、Y方向区域都大致确定后的图像','color','b');
 
ii=(iiXY~=1);%黑色背景，白色字体
%figure(7);imshow(ii);title('背景和文字交换颜色的图像','color','b');
 
ii=bwareaopen(ii,200);  %删除面积小于200的杂质图像
%figure(8);imshow(ii);title('删除杂质干扰的图像','color','b');
 
myI=charslice(ii);  %限定文字区域
%figure(9);imshow(ii);title('限定文字区域的图像','color','b');
 
y1=10;y2=0.25;flag=0;
maxnum=40;k=1;  %maxnum为字符个数限定值，k用于统计实际字符个数
word=cell(1,maxnum);  %建立单元阵列，用于储存字符
 
figure(10)
while size(myI,2)>10  %当myI的长度小等于10，可确定没有字符了
    [word{k},myI]=getword(myI);  %获取字符
    k=k+1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if k==2
        subplot(5,1,1);imshow(myI);title('第一次切割后的图像','color','b');
    end
    if k==3
        subplot(5,1,2);imshow(myI);title('第二次切割后的图像','color','b');
    end
    if k==5
        subplot(5,1,3);imshow(myI);title('第四次切割后的图像','color','b');
    end
    if k==16
        subplot(5,1,4);imshow(myI);title('第十五次切割后的图像','color','b');
    end
end
subplot(5,1,5);imshow(myI);title('最后一次切割后的图像','color','b');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
cnum=k-1;  %实际字符总个数
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(11);
for j=1:cnum
subplot(5,8,j),imshow(word{j}),title(int2str(j));  %显示字符
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
for j=1:cnum
    word{j}=imresize(word{j},[40 40]);  %字符规格化成40×40的
end
figure(12);
for j=1:cnum
subplot(5,8,j),imshow(word{j}),title(int2str(j));  %显示字符
end
 
for j=1:cnum
imwrite(word{j},[int2str(j),'.jpg']);  %保存字符
end
 
defx=40;defy=40;
code=char('由于作者水平有限书中难免存在缺点和疏漏之处恳请读批评指正，。');%创建字符集
codenum=size(code,2);  %获取字符集中字符个数
for i=1:cnum
    ch=int2str(i);  %数字转化为字符
    tempbw=imread([ch '.jpg']);  %打开预匹配字符
    for k=1:codenum
        fname=strcat('C:\Users\Administrator\Desktop\数字图像处理大作业\字符匹配库\',code(k),'.jpg'); %字符匹配库中的字符
        sample=imread(fname);
        subsam=abs(tempbw-sample);  %作比较
        count=sum(sum(subsam));  %匹配误差统计
        err(k)=count;
    end
    erro=err(1:codenum);
    minerror=min(erro);  %找出误差最小的模板字符
    findc=find(erro==minerror);  %获取模板字符序号
    Code(i)=code(findc);  %将字符装入Code
end
 
figure(13);
imshow(ii);
tt=title(['文字信息: ', Code(1:cnum)],'Color','b');  %显示字符信息
set(tt,'fontsize',24);  %设置字体
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%将图片文字写入newtxt文本
new=['newtxt','.txt'];
c=fopen(new,'a+');    
fprintf(c,'%s\n',Code(1:cnum));
fclose(c);
t=toc
 
charslice  （字符分割）函数源代码：
%字符分割，自定义的切割函数
