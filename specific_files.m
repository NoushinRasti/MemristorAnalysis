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

A= 10^-2* pi*(file.D/2)^2; 


area=string(round(A*10^2,3));
Area=append(area,' mm^2');
% text(0.1,0.9,Area,'Units','normalized','Color','red','FontSize',12)

plot(v,I,'-o','LineWidth',1.2,'MarkerSize',1,'DisplayName',Area)
lgd=legend;
lgd.FontSize=14;
lgd.Title.String='Area of electrode' ;
hold on



scan_rate=string(round((v(1)-v(5))/(file.t(1)-file.t(5)),2))
scan=append('scan rate = ',scan_rate,' V/s');
text(0.7,0.2,scan,'Units','normalized','Color','blue','FontSize',12)


title(file.struct)
xlabel('Voltage(V)')
ylabel('Current(A)')

% saveas(gcf, strcat(file.folder,'/Figures/8plot/IV/',extractBefore(file.name,".csv"),".png" ))
end
