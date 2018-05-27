clear all
close all
clc
while true
    system('adb shell screencap -p /sdcard/screen.png');
    system('adb pull /sdcard/screen.png');
    im=imread('C:\Users\Abhijeet Biswas\screen.png');
    R=im(:,:,1);
    G=im(:,:,2);
    B=im(:,:,3);
    [M,N] = size(im(:,:,1));
    cap = ones(size(im(:,:,1)));
    box = ones(size(im(:,:,1)));
    for i = 1:M
        for j=1:N
            if R(i,j)>200
                if B(i,j)<10
                    if G(i,j)<10
                         cap(i,j)=0;
                    end
                   
                end
            end
        end
    end
    for i = 1:M
        for j = 1:N
            if R(i,j)>200
                if G(i,j)>20&&G(i,j)<30
                    if B(i,j)>20&&B(i,j)<30
                        box(i,j)=0;
                    end
                end
            end
        end
    end
 cap =~cap;
 box=~box;
   regioncap= regionprops(cap);
   regionbox= regionprops(box);
   %the area of cap and box will be maxm in reigioncap and region box
   %matrices resectively
   [Row,Col]= size(regioncap);
   [row,col]=size(regionbox);
   for i = 1:Row
       if i~=1
           if regioncap(i).Area>maxA
               if regioncap(i).Area<350
                   maxi=i;
                   maxA=regioncap(i).Area;
               end
           end
       else
           maxi=1;
           maxA=regioncap(i).Area;
       end
   end
   for i = 1:row
       if i~=1
           if regionbox(i).Area>maXA
               if regionbox(i).Area<350
                   Maxi=i;
                   maXA=regionbox(i).Area;
               end
           end
       else
           Maxi=1;
           maXA=regionbox(i).Area;
       end
   end
   len = regionbox(Maxi).Centroid(1)-regioncap(maxi).Centroid(1);
   time = round(abs(len) +6.13);
   com = ['adb shell input swipe 200 200 900 400 ' num2str(time)];
   
   system(com);
   system('adb shell rm /sdcard/screen.png');
   pause(2.3)    
end