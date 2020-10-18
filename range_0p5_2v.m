clear;

path=input('what is the path of the folder= ','s');
title_figure=input('what is the structure of the device= ','s');


range_voltage = '0p5_2v';

files=dir(path);
files = files(~startsWith({files.name}, '.'));

% files=dir(strcat(path,'/','*.csv'));
cell_files = cell(size(files));
Legend=cell(size(files));

for index=1:length(files)
%   data=readmatrix(strcat(files(index).folder,'/',files(index).name));
    full_path = strcat(files(index).folder,'/',files(index).name,'/',range_voltage,'.csv');

    if exist( full_path,'file') == 0
  % File does not exist
  % Skip to bottom of loop and continue with the loop
       continue;
    end
    
    
    data=readmatrix(full_path);
    cell_files{index}.struct=title_figure;
    cell_files{index}.folder=files(index).folder;
    cell_files{index}.name=files(index).name;
    cell_files{index}.iter=index;
    cell_files{index}.r=data(:,1);
    cell_files{index}.v=data(:,3);
    cell_files{index}.I=data(:,4);
    cell_files{index}.t=data(:,5);
    cell_files{index}.D=GetElectrodeDiameter(strcat(files(index).folder,'/',files(index).name));
    figure(index)
    plot_IV(cell_files{index})
    saveas(gcf, strcat('/Figures_0p5_2v/',index,".png" ))
end
hold off

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

% counter1=0;
% counter2=0;


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
% I_dens=10^3*I./A ;  %changes the current to the Current density mA.cm^-2



%Creates a plot of current versus voltage and shows the scan rate
% figure(1)
% plot(v(1),I(1),'LineWidth',1.3)
% hold on
% plot(v(2),I(2),'LineWidth',1.3)
% hold on
% plot(v3,I3,'LineWidth',1.3)
% hold on
% plot(v4,I4,'LineWidth',1.3)

area=string(round(A*10^2,3));
Diameter=string(file.D);
Area=append('A=',area,'mm^2','(','D=',Diameter,'mm',')');
% text(0.5,0.1,Area,'Units','normalized','Color','red','FontSize',12)

scan_rate=string(round((file.v(1)-file.v(8))/(file.t(1)-file.t(8)),2))
scan=append('scan rate = ',scan_rate,' V/s');
% text(0.5,0.15,scan,'Units','normalized','Color','blue','FontSize',15)
text(0.6,0.05,'0.11 V/s','Units','normalized','Color','blue','FontSize',15)
% text(0.5,0.22,Area,'Units','normalized','Color','blue','FontSize',15)

% plot(v,I,'-o','LineWidth',1.2,'MarkerSize',1)
% hold on
plot(v,I,'-o','LineWidth',1.2,'MarkerSize',1,'DisplayName',Area)
lgd=legend;
lgd.FontSize=14;
lgd.Title.String='Area and Diameter of Electrode' ;
 

% xlim([v(index_min)*1.1, v(index_max)*1.1])
title(file.struct)
xlabel('Voltage(V)')
ylabel('Current(A)')

end
