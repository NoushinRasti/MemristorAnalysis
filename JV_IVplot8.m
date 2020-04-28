clear;


path=input('what is the path of the folder= ','s');
files=dir(strcat(path,'\','*.csv'));
cell_files = cell(size(files));

for index=1:length(files)
data=readmatrix(strcat(files(index).folder,'\',files(index).name));
    cell_files{index}.folder=files(index).folder;
    cell_files{index}.name=files(index).name;
    cell_files{index}.iter=index;
    cell_files{index}.r=data(:,1);
    cell_files{index}.v=data(:,3);
    cell_files{index}.I=data(:,4);
    cell_files{index}.t=data(:,5);
    cell_files{index}.D=GetElectrodeDiameter(strcat(files(index).folder,'\',files(index).name));
    plot_IV(cell_files{index})
    %plot_IV(cell_files{index}.v,cell_files{index}.I,cell_files{index}.t,cell_files{index}.r,cell_files{index}.D)

end

function c = GetElectrodeDiameter(namefile)
a=extractBefore(namefile,'mm');
b=a((length(a)-3):end);
b(2)='.';
c=str2double(b);
end

function plot_IV(file)

%this function receive arrays of data including voltage, current and time and plot 8
%figures. In order to find the sequence behaviour of the device,
%this function recognise the index_max, index_zero and index_min of the
% voltage. The plots includes: current-volatage, current density_voltage,
%logarithm of current versus voltage, logarithm of current
%density_volatage, also these figures which shows the sequences of the
%behaviour of the devices. And based on the time of the measurement it
%calculates scan rates.

counter=0;
for i=1:length(file.r)
    if ( file.r(i)==1)
        counter=i;
    else
        break;
    end
end


v=file.v(1:counter);
I=file.I(1:counter);

%it finds the index at which the voltage passes zero in the first cycle.
for i=1:length(v)
    
    if ( v(i)>v(i+1)&& v(i+1)>v(i+2))
        index_max=i; 
        break;
    end
end

%it finds the index at which the voltage is maximum in the first cycle.
for i=index_max : length(v)
    if ( v(i)<0 && v(i+1)<0) 
        index_zero=i; 
        break
    end
end


%it finds the index at which the voltage is minimum in the first cycle.
for i=index_zero : length(v)
    if ( v(i)<v(i+1)&& v(i+1)<v(i+2))
        index_min=i;
        break
    end
end





% calculates the scan rate and round it to 3 decimals and change this data
% to string.
scan_rate=string(round((v(1)-v(index_max))/(file.t(1)-file.t(index_max)),3));


A= 10^-2* pi*(file.D/2)^2; 
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

 xlim([v(index_min)*1.1, v(index_max)*1.1])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')

saveas(gcf, strcat(file.folder,'\Figures\8plot\Al\IV\',extractBefore(file.name,".csv"),".png" ))


%creates a plot using a base 10 logarithmic of the current versus voltage
figure(2)
semilogy(v,abs(I),'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','g',...
    'MarkerFaceColor',[0.5,0.5,0.5])

xlim([v(index_min)*1.1, v(index_max)*1.1])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I(index_max),str,'Color','red','FontSize',12)
saveas(gcf, strcat(file.folder,'\Figures\8plot\Al\IV_semilog\',extractBefore(file.name,".csv"),".png" ))

%creates a plot using of the current density versus voltage
figure(3)
plot(v,I_dens,'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','m',...
    'MarkerFaceColor',[0.5,0.5,0.5])

xlim([v(index_min)*1.1, v(index_max)*1.1])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density(mA.cm^-3)')
saveas(gcf,'figures/0p05mm-2v-cc-3-long-1r.bmp') 
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I_dens(index_max),str,'Color','red','FontSize',12)
saveas(gcf, strcat(file.folder,'\Figures\8plot\Al\JV\',extractBefore(file.name,".csv"),".png" ))

%creates a plot using a base 10 logarithmic of the current density versus voltage
figure(4)
semilogy(v,abs(I_dens),'-o',...
    'LineWidth',3,...
    'MarkerSize',3,...
    'MarkerEdgeColor','c',...
    'MarkerFaceColor',[0.5,0.5,0.5])

xlim([v(index_min)*1.1, v(index_max)*1.1])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density(mA.cm^-3)')
saveas(gcf,'Figures\0p05mm-2v-cc-3-long-1r.bmp')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I_dens(index_max),str,'Color','red','FontSize',12)
saveas(gcf, strcat(file.folder,'\Figures\8plot\Al\JV_semilog\',extractBefore(file.name,".csv"),".png" ))

%catagorize data with the aid of the indexes
v1=v(1:index_max);
I1=I(1:index_max);
v2=v(index_max:index_zero);
I2=I(index_max:index_zero);
v3=v(index_zero:index_min);
I3=I(index_zero:index_min);
v4=v(index_min:length(v));
I4=I(index_min:length(v));

%create plot of the current-voltage of different sequences 
%plot(v1,I1,'-<','MarkerIndices',floor(length(v)/6),'LineWidth',3,...
 %'MarkerSize',5)

 figure(5)

plot(v1,I1,'LineWidth',3)
hold on

plot(v2,I2,'LineWidth',3)
hold on
plot(v3,I3,'LineWidth',3)
hold on
plot(v4,I4,'LineWidth',3)
hold off
    %pause(0.1);
    legend({'1','2','3','4'}, 'Location','north')
xlim([v(index_min)*1.1, v(index_max)*1.1])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I1(index_max),str,'Color','red','FontSize',12)
saveas(gcf, strcat(file.folder,'\Figures\8plot\Al\IV_4arrow\',extractBefore(file.name,".csv"),".png" ))


%create plot of the logarithm of the current versus voltage of different sequences
figure(6)
semilogy(v1,abs(I1),'LineWidth',3)
hold on
semilogy(v2,abs(I2),'LineWidth',3)
hold on
semilogy(v3,abs(I3),'LineWidth',3)
hold on
semilogy(v4,abs(I4),'LineWidth',3)
hold off
     legend({'1','2','3','4'}, 'Location','north')
xlim([v(index_min)*1.1, v(index_max)*1.1])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current(A)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I1(index_max),str,'Color','red','FontSize',12)
saveas(gcf, strcat(file.folder,'\Figures\8plot\Al\IV_4arrow_semilog\',extractBefore(file.name,".csv"),".png" ))


I1= 10^3* I(1:index_max)/A ;
I2= 10^3*I(index_max:index_zero)/A ;
I3=10^3* I(index_zero:index_min)/A ;
I4=10^3* I(index_min:length(v))/A ;

%create plot of the current density versus voltage of different sequences
figure(7)
plot(v1,I1,'LineWidth',3)
hold on
plot(v2,I2,'LineWidth',3)
hold on
plot(v3,I3,'LineWidth',3)
hold on
plot(v4,I4,'LineWidth',3)
hold off
 legend({'1','2','3','4'}, 'Location','north')
xlim([v(index_min)*1.1, v(index_max)*1.1])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density (mA.cm^2)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I1(index_max),str,'Color','red','FontSize',12)
saveas(gcf, strcat(file.folder,'\Figures\8plot\Al\JV_4arrow\',extractBefore(file.name,".csv"),".png" ))

%create plot of the logarithm of the current density versus voltage of different sequences
figure(8)
semilogy(v1,abs(I1),'LineWidth',3)
hold on
semilogy(v2,abs(I2),'LineWidth',3)
hold on
semilogy(v3,abs(I3),'LineWidth',3)
hold on
semilogy(v4,abs(I4),'LineWidth',3)
hold off
     legend({'1','2','3','4'}, 'Location','north')
xlim([v(index_min)*1.1, v(index_max)*1.1])
title('ITO/MAPbI(500nm)/Al')
xlabel('Voltage(V)')
ylabel('Current Density (mA.cm^2)')
str=append('scan rate = ',scan_rate,' V/s');
text(v(index_min),I1(index_max),str,'Color','red','FontSize',12)
saveas(gcf, strcat(file.folder,'\Figures\8plot\Al\JV_4arrow_semilog\',extractBefore(file.name,".csv"),".png" ))
end