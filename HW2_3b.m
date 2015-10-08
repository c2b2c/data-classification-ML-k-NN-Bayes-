Xtest=importdata('Xtest.txt');
Xtrain=importdata('Xtrain.txt');
label_test=importdata('label_test.txt');
label_train=importdata('label_train.txt');
Q=importdata('Q.txt');
yt=label_test;
yp=zeros(500,1);
classifier=zeros(500,10);
miu=zeros(20,10);
sigma=zeros(20,20,10);
y=zeros(784,10);
index=1;
C=zeros(10,10);

for class=1:10
    for i=1:500
        miu(:,class)=miu(:,class)+transpose(Xtrain((class-1)*500+i,:));
    end
    miu(:,class)=miu(:,class)/500;
    for i=1:500
%         transpose(Xtrain((class-1)*500+i,:))-miu(:,class)
%         Xtrain((class-1)*500+i,:)-transpose(miu(:,class))
        sigma(:,:,class)=sigma(:,:,class)+(transpose(Xtrain((class-1)*500+i,:))-miu(:,class))*(Xtrain((class-1)*500+i,:)-transpose(miu(:,class)));
    end
    sigma(:,:,class)=sigma(:,:,class)/500;
end

% miu
% sigma(:,:,1)

for i=1:500
        for class=1:10
%         disp('1');
%         transpose(Xtrain((class-1)*50+i,:))-miu(:,class)
%         disp('2');
%         inv(sigma(:,:,class))
%         disp('3');
%         Xtrain((class-1)*50+i,:)-transpose(miu(:,class))
        classifier(i,class)=1/10*(det(sigma(:,:,class)))^(-1/2)*exp(-1/2*(Xtest(i,:)-transpose(miu(:,class)))*inv(sigma(:,:,class))*(transpose(Xtest(i,:))-miu(:,class)));
        end
end

classifier(474,:)
% [x,y]=max(transpose(classifier(474,:)));
% [x,y]=max(classifier(474,:));
% data=max(transpose(classifier(474,:)));
% data

 for i=1:500
%     transpose(classifier(i,:))
%     [x,y]=find(z==max(max(classifier(i,:))))
%     [x,y]=max(classifier(i,:));
    for j=1:10
%         [x,y]=max(transpose(classifier(i,:)));
        if (classifier(i,j)>classifier(i,index))
            index=j;
        end
    end
    yp(i,1)=index-1;
    index=1;
 end

for i=1:500
    C(yt(i,1)+1,yp(i,1)+1)=C(yt(i,1)+1,yp(i,1)+1)+1;
end

 C
 trace(C)/500

for class=1:10
    figure(class)
    y(:,class)=Q*miu(:,class);
    imagesc(reshape(y(:,class),28,28))
end

for i=1:500
    if (yp(i,1)~=yt(i,1))
        i,yp(i,1),yt(i,1)
    end
end
