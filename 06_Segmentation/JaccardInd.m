function out = JaccardInd(seg1,seg2)
JI=zeros(max(max(seg1)),max(max(seg2)));
    for i=1:max(max(seg1))
    cmp1=double(seg1);
    cmp1=cmp1==i;
        for j=1:double(max(max(seg2)))        
            cmp2=double(seg2);
            cmp2=cmp2==j;
            inter=and(cmp1,cmp2);
            uni=or(cmp1,cmp2);
            JI(i,j)=length(find(inter==1))/length(find(uni==1));        
        end 
    end
mn=0;
if max(max(seg1))>max(max(seg2))
    mn=max(max(seg2));
else
    mn=max(max(seg1));
end
res=zeros(1,mn);
for k=1:mn
    res(k)=(max(max(JI)));
    [m n]=find(JI==res(k));
    JI(m,:)=[];
    JI(:,n)=[];
end
out=mean(res);
end