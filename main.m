tic
I=imread('�ַ�.jpg');  %��ͼƬ
%figure(1);imshow(I);title('ԭʼͼ��','color','b');
 
I=rgb2gray(I);  %RGBͼƬת���ɻҶ�ͼ��
%figure(2);imshow(I);title('�Ҷ�ͼ��','color','b');
 
i_max=double(max(max(I)));  %��ȡ�������ֵ
i_min=double(min(min(I)));  %��ȡ������Сֵ
thresh=round(i_max-((i_max-i_min)/3));  %����Ҷ�ͼ��ת���ɶ�ֵͼ�������thresh
I=(I>=thresh);  %IΪ��ֵͼ��
%figure(3);imshow(I);title('��ֵͼ��','color','b');
 
seY=[1;1;1];  %����ṹԪ��
I=imdilate(I,seY);  %��ʴͼ��
I=imerode(I,seY);  %����ͼ��
seX=[1 1 1];
I=imdilate(I,seX);
I=imerode(I,seX);
%figure(4);imshow(I);title('��ʴ���ͺ��ͼ��','color','b');
 
ii=double(I);
[m,n]=size(ii);  %��ȡͼ���С��Ϣ
%ȷ����������
%����ɨ��
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
iiY=I(tempY1:tempY2,:);  %ȷ����Y�����ϵ���������
%figure(5);imshow(iiY);title('Y�����������ȷ�����ͼ��','color','b');
 
%����ɨ��
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
iiXY=iiY(:,tempX1:tempX2);  %ȷ�����������������
%figure(6);imshow(iiXY);title('X��Y�������򶼴���ȷ�����ͼ��','color','b');
 
ii=(iiXY~=1);%��ɫ��������ɫ����
%figure(7);imshow(ii);title('���������ֽ�����ɫ��ͼ��','color','b');
 
ii=bwareaopen(ii,200);  %ɾ�����С��200������ͼ��
%figure(8);imshow(ii);title('ɾ�����ʸ��ŵ�ͼ��','color','b');
 
myI=charslice(ii);  %�޶���������
%figure(9);imshow(ii);title('�޶����������ͼ��','color','b');
 
y1=10;y2=0.25;flag=0;
maxnum=40;k=1;  %maxnumΪ�ַ������޶�ֵ��k����ͳ��ʵ���ַ�����
word=cell(1,maxnum);  %������Ԫ���У����ڴ����ַ�
 
figure(10)
while size(myI,2)>10  %��myI�ĳ���С����10����ȷ��û���ַ���
    [word{k},myI]=getword(myI);  %��ȡ�ַ�
    k=k+1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if k==2
        subplot(5,1,1);imshow(myI);title('��һ���и���ͼ��','color','b');
    end
    if k==3
        subplot(5,1,2);imshow(myI);title('�ڶ����и���ͼ��','color','b');
    end
    if k==5
        subplot(5,1,3);imshow(myI);title('���Ĵ��и���ͼ��','color','b');
    end
    if k==16
        subplot(5,1,4);imshow(myI);title('��ʮ����и���ͼ��','color','b');
    end
end
subplot(5,1,5);imshow(myI);title('���һ���и���ͼ��','color','b');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
cnum=k-1;  %ʵ���ַ��ܸ���
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(11);
for j=1:cnum
subplot(5,8,j),imshow(word{j}),title(int2str(j));  %��ʾ�ַ�
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
for j=1:cnum
    word{j}=imresize(word{j},[40 40]);  %�ַ���񻯳�40��40��
end
figure(12);
for j=1:cnum
subplot(5,8,j),imshow(word{j}),title(int2str(j));  %��ʾ�ַ�
end
 
for j=1:cnum
imwrite(word{j},[int2str(j),'.jpg']);  %�����ַ�
end
 
defx=40;defy=40;
code=char('��������ˮƽ���������������ȱ�����©֮�����������ָ������');%�����ַ���
codenum=size(code,2);  %��ȡ�ַ������ַ�����
for i=1:cnum
    ch=int2str(i);  %����ת��Ϊ�ַ�
    tempbw=imread([ch '.jpg']);  %��Ԥƥ���ַ�
    for k=1:codenum
        fname=strcat('C:\Users\Administrator\Desktop\����ͼ�������ҵ\�ַ�ƥ���\',code(k),'.jpg'); %�ַ�ƥ����е��ַ�
        sample=imread(fname);
        subsam=abs(tempbw-sample);  %���Ƚ�
        count=sum(sum(subsam));  %ƥ�����ͳ��
        err(k)=count;
    end
    erro=err(1:codenum);
    minerror=min(erro);  %�ҳ������С��ģ���ַ�
    findc=find(erro==minerror);  %��ȡģ���ַ����
    Code(i)=code(findc);  %���ַ�װ��Code
end
 
figure(13);
imshow(ii);
tt=title(['������Ϣ: ', Code(1:cnum)],'Color','b');  %��ʾ�ַ���Ϣ
set(tt,'fontsize',24);  %��������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%��ͼƬ����д��newtxt�ı�
new=['newtxt','.txt'];
c=fopen(new,'a+');    
fprintf(c,'%s\n',Code(1:cnum));
fclose(c);
t=toc
 
charslice  ���ַ��ָ����Դ���룺
%�ַ��ָ�Զ�����и��
