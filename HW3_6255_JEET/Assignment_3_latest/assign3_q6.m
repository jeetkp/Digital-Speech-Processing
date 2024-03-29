clc;clear all; close all;
[wave2,F2]=audioread('2.wav');
[wave6,F6]=audioread('6.wav');
A=importdata('2_phn.txt');
A1=importdata('2_wrd.txt');
check=wave2;
vowels={'iy','ih','eh','ae','ah','aa','ao','uh','uw','er','ow','ax','w','r','l','y'};
% 1412500 - 6050000
% 2260 - 9680
[m,n]=size(A);
e=zeros(1,m);
fprintf('Wave 2');
for i=1:m
    c=split(A(i),' ');
    if(strcmp(c(3),'sil'))
        continue;
    end
    c1=str2double(c(1))/625;
    c2=str2double(c(2))/625;
    value= wave2(c1:c2);
    p(i)=c(3);
    for j=1:size(value,1)
        e(i)= e(i)+ value(j)^2;
    end
     fprintf(' Element  = %s --Energy  %f \n', string(c(3)) , e(i))
end

for i=1:m
    c=split(A(i),' ');
    if(strcmp(c(3),'sil'))
        continue;
    end
    c1=str2double(c(1))/625;
    c2=str2double(c(2))/625;
%     value= wave2(c1:c2);
%     if(contains(string(p(i)),'e') || contains(string(p(i)),'a') ||contains(string(p(i)),'i') ||contains(string(p(i)),'o') ||contains(string(p(i)),'u'))
      if any(strcmp(vowels,string(c(3))))
        for ii=c1:c2
            check(ii)=0;
        end
    end
    for j=1:size(value,1)
        e(i)= e(i)+ value(j)^2;
    end
%     fprintf(' Element  = %s --Energy  %f \n', string(c(3)) , e(i))
end
audiowrite('novowel.wav', check, F2); 
check=wave2;
for i=1:m
    c=split(A(i),' ');
    if(strcmp(c(3),'sil'))
        continue;
    end
    c1=str2double(c(1))/625;
    c2=str2double(c(2))/625;
%     value= wave2(c1:c2);
%     if(~(contains(string(p(i)),'e') || contains(string(p(i)),'a') ||contains(string(p(i)),'i') ||contains(string(p(i)),'o') ||contains(string(p(i)),'u')||contains(string(p(i)),'l') || contains(string(p(i)),'r') ||contains(string(p(i)),'w') ||contains(string(p(i)),'y')))
     if(~any(strcmp(vowels,string(c(3)))))
        for ii=c1:c2
            check(ii)=0;
        end
    end
    for j=1:size(value,1)
        e(i)= e(i)+ value(j)^2;
    end
end
audiowrite('noconsonant.wav', check, F2); 


fprintf('Wave 6');
A=importdata('6_phn.txt');
check=wave6;
[m,n]=size(A);
e=zeros(1,m);
for i=1:m
    c=split(A(i),' ');
    if(strcmp(c(3),'sil'))
        continue;
    end
    c1=str2double(c(1))/625;
    c2=str2double(c(2))/625;
    value= wave2(c1:c2);
    p(i)=c(3);
    for j=1:size(value,1)
        e(i)= e(i)+ value(j)^2;
    end
     fprintf(' Element  = %s --Energy  %f \n', string(c(3)) , e(i))
end

for i=1:m
    c=split(A(i),' ');
    if(strcmp(c(3),'sil'))
        continue;
    end
    c1=str2double(c(1))/625;
    c2=str2double(c(2))/625;
%     value= wave2(c1:c2);
%     if(contains(string(p(i)),'e') || contains(string(p(i)),'a') ||contains(string(p(i)),'i') ||contains(string(p(i)),'o') ||contains(string(p(i)),'u'))
    if any(strcmp(vowels,string(c(3))))
        for ii=c1:c2
            check(ii)=0;
        end
    end
    for j=1:size(value,1)
        e(i)= e(i)+ value(j)^2;
    end
end
audiowrite('novowel_6.wav', check, F6); 
check=wave6;
for i=1:m
    c=split(A(i),' ');
    if(strcmp(c(3),'sil'))
        continue;
    end
    c1=str2double(c(1))/625;
    c2=str2double(c(2))/625;
%     value= wave2(c1:c2);
%     if(~(contains(string(p(i)),'e') || contains(string(p(i)),'a') ||contains(string(p(i)),'i') ||contains(string(p(i)),'o') ||contains(string(p(i)),'u')))
    if (~any(strcmp(vowels,string(c(3)))))
        for ii=c1:c2
            check(ii)=0;
        end
    end
    for j=1:size(value,1)
        e(i)= e(i)+ value(j)^2;
    end
end
audiowrite('noconsonant_6.wav', check, F6); 