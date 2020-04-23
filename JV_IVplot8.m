clear;
data=csvread('E:\Flash-firstyear-PhD\PHD WELCOME\28 Nov\0p01mm-2v-cc-3-long-1r-.csv',1,2);
x=data(:,1);
y=data(:,2);
t=data(:,3);
plot_IV(x,y,t)











function plot_IV(x,y,t)


for i=1:length(x)
    if ( x(i)>x(i+1))
        index_max=i; 
        break;
    end
end

for i=index_max : length(x)
    if ( x(i)==0 ) 
        index_zero=i; 
        break
    end
end

for i=index_zero : length(x)
    if ( x(i)<x(i+1))
        index_min=i;
        break
    end
end

scan_rate=string(round((x(1)-x(index_max))/(t(1)-t(index_max)),3));

D=input("what is diameter in mm = ");
A= 10^-2* pi*(D/2)^2; 
y_dens=10^3*y./A ; %change to Current density mA.cm^-2




figure(1)
plot(x,y,'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor',[0.5,0.5,0.5])

str=append('scan rate = ',scan_rate,' V/s');
text(x(index_min),y(index_max),str,'Color','red','FontSize',12)


 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
saveas(gcf,'0p05mm-2v-cc-3-long-1r.bmp') 

figure(2)
semilogy(x,abs(y),'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.5,0.5,0.5])

 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(x(index_min),y(index_max),str,'Color','red','FontSize',12)



figure(3)
plot(x,y_dens,'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','m',...
    'MarkerFaceColor',[0.5,0.5,0.5])

 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density(mA.cm^-3)')
saveas(gcf,'0p05mm-2v-cc-3-long-1r.bmp') 
str=append('scan rate = ',scan_rate,' V/s');
text(x(index_min),y_dens(index_max),str,'Color','red','FontSize',12)

figure(4)
semilogy(x,abs(y),'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','c',...
    'MarkerFaceColor',[0.5,0.5,0.5])


 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density(mA.cm^-3)')
saveas(gcf,'0p05mm-2v-cc-3-long-1r.bmp')
str=append('scan rate = ',scan_rate,' V/s');
text(x(index_min),y(index_max),str,'Color','red','FontSize',12)

x1= x(1:index_max);
y1= y(1:index_max);
x2= x(index_max:index_zero);
y2= y(index_max:index_zero);
x3=x(index_zero:index_min);
y3=y(index_zero:index_min);
x4=x(index_min:length(x));
y4=y(index_min:length(x));


figure(5)
plot(x1,y1,'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(x2,y2,'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(x3,y3,'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(x4,y4,'->','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)

    pause(0.1);
    legend({'1','2','3','4'}, 'Location','north')
 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(x(index_min),y1(index_max),str,'Color','red','FontSize',12)



figure(6)
semilogy(x1,abs(y1),'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(x2,abs(y2),'->','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(x3,abs(y3),'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(x4,abs(y4),'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)

     legend({'1','2','3','4'}, 'Location','north')
 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(x(index_min),y1(index_max),str,'Color','red','FontSize',12)


y1= 10^3* y(1:index_max)/A ;
y2= 10^3*y(index_max:index_zero)/A ;
y3=10^3* y(index_zero:index_min)/A ;
y4=10^3* y(index_min:length(x))/A ;

figure(7)
plot(x1,y1,'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(x2,y2,'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(x3,y3,'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(x4,y4,'->','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)

 legend({'1','2','3','4'}, 'Location','north')
 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density (mA.cm^2)')
str=append('scan rate = ',scan_rate,' V/s');
text(x(index_min),y1(index_max),str,'Color','red','FontSize',12)


figure(8)
semilogy(x1,abs(y1),'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(x2,abs(y2),'->','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(x3,abs(y3),'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(x4,abs(y4),'-<','MarkerIndices',floor(length(x)/6),'LineWidth',3,...
    'MarkerSize',5)

     legend({'1','2','3','4'}, 'Location','north')
 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density (mA.cm^2)')
str=append('scan rate = ',scan_rate,' V/s');
text(x(index_min),y1(index_max),str,'Color','red','FontSize',12)

end