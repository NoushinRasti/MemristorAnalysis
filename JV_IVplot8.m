clear;
%give path to the directory of the current-voltage data, it reads from the
%second row (first row is strings) and the third column which is voltage.
data=csvread('E:\Flash-firstyear-PhD\PHD WELCOME\28 Nov\0p01mm-2v-cc-3-long-1r-.csv',1,2);
v=data(:,1);
I=data(:,2);
t=data(:,3);
plot_IV(v,I,t)



function plot_IV(v,I,t)
%this function receive arrays of data including voltage, current and time and plot 8
%figures. In order to find the sequence behaviour of the device,
%this function recognise the index_max, index_zero and index_min of the
% voltage. The plots includes: current-volatage, current density_voltage,
%logarithm of current versus voltage, logarithm of current
%density_volatage, also these figures which shows the sequences of the
%behaviour of the devices. And based on the time of the measurement it
%calculates scan rates.

%it finds the index at which the voltage passes zero in the first cycle.
for i=1:length(v)
    if ( v(i)>v(i+1))
        index_max=i; 
        break;
    end
end

%it finds the index at which the voltage is maximum in the first cycle.
for i=index_max : length(v)
    if ( v(i)==0 ) 
        index_zero=i; 
        break
    end
end


%it finds the index at which the voltage is minimum in the first cycle.
for i=index_zero : length(v)
    if ( v(i)<v(i+1))
        index_min=i;
        break
    end
end

%it finds the index at which the voltage passes zero for the second time.
for i=index_min : length(v)
    if (v(i)==0)
        index_zero2=i;
        break
    end
end



% calculates the scan rate and round it to 3 decimals and change this data
% to string.
scan_rate=string(round((v(1)-v(index_max))/(t(1)-t(index_max)),3));

D=input("what is diameter in mm = ");
A= 10^-2* pi*(D/2)^2; 
I_dens=10^3*I./A ;  %changes the current to the Current density mA.cm^-2



%Creates a plot of current versus voltage and shows the scan rate
figure(1)
plot(v,I,'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor',[0.5,0.5,0.5])

str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I(index_max),str,'Color','red','FontSize',12)

 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
saveas(gcf,'Figures\0p05mm-2v-cc-3-long-1r.bmp') 


%creates a plot using a base 10 logarithmic of the current versus voltage
figure(2)
semilogy(v,abs(I),'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.5,0.5,0.5])

 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I(index_max),str,'Color','red','FontSize',12)


%creates a plot using of the current density versus voltage
figure(3)
plot(v,I_dens,'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','m',...
    'MarkerFaceColor',[0.5,0.5,0.5])

 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density(mA.cm^-3)')
saveas(gcf,'figures/0p05mm-2v-cc-3-long-1r.bmp') 
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I_dens(index_max),str,'Color','red','FontSize',12)


%creates a plot using a base 10 logarithmic of the current density versus voltage
figure(4)
semilogy(v,abs(I_dens),'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','c',...
    'MarkerFaceColor',[0.5,0.5,0.5])

 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density(mA.cm^-3)')
saveas(gcf,'Figures\0p05mm-2v-cc-3-long-1r.bmp')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I_dens(index_max),str,'Color','red','FontSize',12)

%catagorize data with the aid of the indexes
v1= v(1:index_max);
I1= I(1:index_max);
v2= v(index_max:index_zero);
I2= I(index_max:index_zero);
v3=v(index_zero:index_min);
I3=I(index_zero:index_min);
v4=v(index_min:index_zero2);
I4=I(index_min:index_zero2);

%create plot of the current-voltage of different sequences 
figure(5)
plot(v1,I1,'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(v2,I2,'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(v3,I3,'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(v4,I4,'->','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)

    %pause(0.1);
    legend({'1','2','3','4'}, 'Location','north')
 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I1(index_max),str,'Color','red','FontSize',12)


%create plot of the logarithm of the current versus voltage of different sequences
figure(6)
semilogy(v1,abs(I1),'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(v2,abs(I2),'->','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(v3,abs(I3),'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(v4,abs(I4),'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)

     legend({'1','2','3','4'}, 'Location','north')
 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I1(index_max),str,'Color','red','FontSize',12)


I1= 10^3* I(1:index_max)/A ;
I2= 10^3*I(index_max:index_zero)/A ;
I3=10^3* I(index_zero:index_min)/A ;
I4=10^3* I(index_min:length(v))/A ;

%create plot of the current density versus voltage of different sequences
figure(7)
plot(v1,I1,'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(v2,I2,'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(v3,I3,'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
plot(v4,I4,'->','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)

 legend({'1','2','3','4'}, 'Location','north')
 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density (mA.cm^2)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I1(index_max),str,'Color','red','FontSize',12)


%create plot of the logarithm of the current density versus voltage of different sequences
figure(8)
semilogy(v1,abs(I1),'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(v2,abs(I2),'->','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(v3,abs(I3),'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)
hold on
semilogy(v4,abs(I4),'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
    'MarkerSize',5)

     legend({'1','2','3','4'}, 'Location','north')
 xlim([-2.2 2.2])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density (mA.cm^2)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I1(index_max),str,'Color','red','FontSize',12)

end