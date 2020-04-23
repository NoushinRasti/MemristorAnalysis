
clear
path='E:\data-1year-memristor\PHD WELCOME\28 Nov\' ;
files=dir(strcat(path,'*0p01mm*.csv')) ;


for i=1:length(files)
    data=readmatrix(strcat(files(i).folder,'\',files(i).name));
    
    r=data(:,1);
    x=data(:,3);
    y=data(:,4);
    t=data(:,5);
    
    D = GetElectrodeDiameter(strcat(files(i).folder,'\',files(i).name));
    
    
    plot_IV(x,y,r,t,D)
end  

function c = GetElectrodeDiameter(namefile)
a=extractBefore(namefile,'mm');
b=a((length(a)-3):end);
b(2)='.';
c=str2double(b);
end



function plot_IV(x,y,r,t,D) 

counter=0;
for i=1:length(r)
    if ( r(i)==1)
        counter=i;
    else
        break;
    end
end
counter

%scan rate
for i=1:counter
    if ( x(i)>x(i+1))
        index_max=i; 
        break;
    end
end

x=x(1:counter);
y=y(1:counter);

scan_rate=string(round((x(1)-x(index_max))/(t(1)-t(index_max)),3));

    %D=input("what is diameter in mm = ");
A= 10^-2* pi*(D/2)^2; 
y_dens=10^3*y./A ; %change to Current density mA.cm^-2





figure(1)
plot(x,y_dens,'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','m',...
    'MarkerFaceColor',[0.5,0.5,0.5])
str=append('scan rate = ',scan_rate,' V/s');
text(x(5),y(index_max),str,'Color','red','FontSize',12)

 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density(mA.cm^-3)')
saveas(gcf,'0p05mm-2v-cc-3-long-1r.bmp') 


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
    
