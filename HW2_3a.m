Xtest=importdata('Xtest.txt');
Xtrain=importdata('Xtrain.txt');
label_test=importdata('label_test.txt');
label_train=importdata('label_train.txt');
yt=label_test;
yp=zeros(500,1);
distance=zeros(500,5000);
minValue=0;
maxVector=zeros(500,1);
k=5;
Majority=zeros(500,k);
disSquare=0;
minPosition=zeros(500,k);
C=zeros(10,10);
% [x,y]= find(a==min(min(a)))
for i=1:500
    for j=1:5000
        for m=1:20
            disSquare=disSquare+(Xtest(i,m)-Xtrain(j,m))^2;
        end
        distance(i,j)=disSquare;
        disSquare=0;
    end
end

for i=1:k
    for j=1:500
        [x,y]=min(transpose(distance(j,:)));
        Majority(j,i)=label_train(y,1);
        distance(j,y)=1000;
    end
end

for i=1:500
    yp(i,:)=mode(Majority(i,:));
end

for i=1:500
    C(yt(i,1)+1,yp(i,1)+1)=C(yt(i,1)+1,yp(i,1)+1)+1;
end
% C
k
trace(C)

for i=1:500
    if (yp(i,1)~=yt(i,1))
        i,yp(i,1),yt(i,1)
    end
end