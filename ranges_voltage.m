clear;

path=input('what is the path of the folder= ','s');
title_figure=input('what is the structure of the device= ','s');
files=dir(strcat(path,'/','*.csv'));
cell_files = cell(size(files));

for index=1:length(files)
data=readmatrix(strcat(files(index).folder,'/',files(index).name));
    cell_files{index}.struct=title_figure;
    cell_files{index}.folder=files(index).folder;
    cell_files{index}.name=files(index).name;
    cell_files{index}.iter=index;
    cell_files{index}.r=data(:,1);
    cell_files{index}.v=data(:,3);
    cell_files{index}.I=data(:,4);
    cell_files{index}.t=data(:,5);
    cell_files{index}.D=GetElectrodeDiameter(strcat(files(index).folder,'/',files(index).name));
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

A= 10^-2* pi*(file.D/2)^2; 
% I_dens=10^3*I./A ;  %changes the current to the Current density mA.cm^-2

counter=0;
for i=1:length(file.r)
    if ( file.r(i)==1)
        counter=i;
    else
        break;
    end
end


v=file.v(1:counter);
I=file.I(1:counter)/A*10^3;



%it finds the index at which the voltage passes zero in the first cycleis.
for i=1 : length(v)
    if ( v(i)<0 && v(i+1)<0 && v(i+2)<0) 
        index_zero=i;
        break
    end
end

file.name




% it finds the index at which the voltage passes zero for second time in the first cycleis.
for i=index_zero : length(v)
    if ( v(i)>0 && v(i+1)>0 && v(i+2)>0) 
        index_zero2=i;
        break
    end
end



%it finds the index at which the voltage passes zero in the first cycleis.
for i=index_zero2 : length(v)
    if ( v(i)<0 && v(i+1)<0 && v(i+2)<0) 
        index_zero3=i;
        break
    end
end

file.name



% it finds the index at which the voltage passes zero for second time in the first cycleis.
for i=index_zero3 : length(v)
    if ( v(i)>0 && v(i+1)>0 && v(i+2)>0) 
        index_zero4=i;
        break
    end
end

for i=index_zero4 : length(v)
    if ( v(i)<0 && v(i+1)<0 && v(i+2)<0) 
        index_zero5=i;
        break
    end
end

for i=index_zero5 : length(v)
    if ( v(i)>0 && v(i+1)>0 && v(i+2)>0) 
        index_zero6=i;
        break
    end
end







% A= 10^-2* pi*(file.D/2)^2; 
% I_dens=10^3*I./A ;  %changes the current to the Current density mA.cm^-2

%catagorize data with the aid of the indexes
v1=v(1:index_zero2);
I1=I(1:index_zero2);
v2=v(index_zero2:index_zero4);
I2=I(index_zero2:index_zero4);
v3=v(index_zero4:index_zero6);
I3=I(index_zero4:index_zero6);
v4=v(index_zero6:length(v));
I4=I(index_zero6:length(v));
%Creates a plot of current versus voltage and shows the scan rate

plot(v1,I1,'-o','LineWidth',2,'MarkerSize',2)
hold on
plot(v2,I2,'-o','LineWidth',2,'MarkerSize',2)
hold on
plot(v3,I3,'-o','LineWidth',2,'MarkerSize',2)
hold on
plot(v4,I4,'-o','LineWidth',2,'MarkerSize',2)
hold off

    
    legend({'1','2','3','4'}, 'Location','southeast')
% xlim([v(index_min)*1.1, v(index_max)*1.1])
title(file.struct,'FontSize',14)
xlabel('Voltage(V)')
ylabel('Current Density (mA.cm^-^2)')
% text(0.08,0.92,Area,'Units','normalized','Color','red','FontSize',12)
% text(0.08,0.84,scan,'Units','normalized','Color','blue','FontSize',12)
% saveas(gcf, strcat(file.folder,'\Figures\8plot\IV_4arrow\',extractBefore(file.name,".csv"),".png" ))



end