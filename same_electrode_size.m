
clear
path='E:\data-1year-memristor\PHD WELCOME\28 Nov\' ;
files=dir(strcat(path,'*0p01mm*.csv')) ;


for i=1:length(files)
    data=readmatrix(strcat(files(i).folder,'\',files(i).name));
    
    r=data(:,1);
    v=data(:,3);
    I=data(:,4);
    t=data(:,5);
    
    D = GetElectrodeDiameter(strcat(files(i).folder,'\',files(i).name));
    
    
    plot_IV(v,I,r,t,D)
end  

function c = GetElectrodeDiameter(namefile)
a=extractBefore(namefile,'mm');
b=a((length(a)-3):end);
b(2)='.';
c=str2double(b);
end



function plot_IV(v,I,r,t,D) 

counter=0;
for i=1:length(r)
    if ( r(i)==1)
        counter=i;
    else
        break;
    end
end


%scan rate
for i=1:counter
    if ( v(i)>v(i+1))
        index_max=i; 
        break;
    end
end

v=v(1:counter);
I=I(1:counter);

scan_rate=string(round((v(1)-v(index_max))/(t(1)-t(index_max)),3));

    %D=input("what is diameter in mm = ");
A= 10^-2* pi*(D/2)^2; 
I_dens=10^3*I./A ; %change to Current density mA.cm^-2





figure(1)
plot(v,I_dens,'LineWidth',3)
str=append('scan rate = ',scan_rate,' V/s');
text(v(5),I(index_max),str,'Color','red','FontSize',12)

 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density(mA.cm^-3)')
legend({'1','2','3','4'}, 'Location','north')
saveas(gcf,'Figures\0p05mm-2v-cc-3-long-1r.bmp') 


% figure(2)
% semilogy(x,abs(y),'-o',...
%     'LineWidth',3,...
%     'MarkerSize',3,...
%     'MarkerEdgeColor','c',...
%     'MarkerFaceColor',[0.5,0.5,0.5])
% 
%  xlim([-2.2 2.2])
% title('ITO/MAPbI(500nm)/Al')
% xlabel('Voltage(V)')
% ylabel('Current Density(mA.cm^-3)')
% saveas(gcf,'0p05mm-2v-cc-3-long-1r.bmp')
    
    hold on
end
    
