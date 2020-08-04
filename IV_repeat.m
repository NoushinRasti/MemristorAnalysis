clear;

path=input('what is the path of the folder= ','s');
title_figure=input('what is the structure of the device= ','s');
files=dir(strcat(path,'\','*.csv'));
cell_files = cell(size(files));

for index=1:length(files)
data=readmatrix(strcat(files(index).folder,'\',files(index).name));
    cell_files{index}.struct=title_figure;
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



A= 10^-2* pi*(file.D/2)^2; 
I_dens=10^3*(file.I)./A ;  %changes the current to the Current density mA.cm^-2



%Creates a plot of current versus voltage and shows the scan rate
figure(1)
plot(file.v,file.I,...
    'LineWidth',1.2)

area=string(round(A*10^2,3));
Area=append('area of elecrtode = ',area,'mm^2');
text(0.1,0.9,Area,'Units','normalized','Color','red','FontSize',12)

scan_rate=string(round((file.v(1)-file.v(8))/(file.t(1)-file.t(8)),2));
scan=append('scan rate = ',scan_rate,' V/s');
text(0.1,0.82,scan,'Units','normalized','Color','blue','FontSize',12)

% xlim([file.v(index_min)*1.1, file.v(index_max)*1.1])
title(file.struct)
xlabel('Voltage(V)')
ylabel('Current(A)')
%exportgraphics(gcf, strcat(file.folder,'\Figures\8plot\IV\',extractBefore(file.name,".csv"),".png" ),'Resolution',300)
saveas(gcf, strcat(file.folder,'\Figures_repeat\8plot\IV\',extractBefore(file.name,".csv"),".png" ))



% %creates a plot using a base 10 logarithmic of the current versus voltage
% figure(2)
% semilogy(v,abs(I),'-o',...
%     'LineWidth',3,...
%     'MarkerSize',3,...
%     'MarkerEdgeColor','g',...
%     'MarkerFaceColor',[0.5,0.5,0.5])
% 
% xlim([v(index_min)*1.1, v(index_max)*1.1])
% title(file.struct)
% xlabel('Voltage(V)')
% ylabel('Current(A)')
% text(0.03,0.1,Area,'Units','normalized','Color','red','FontSize',12)
% text(0.03,0.18,scan,'Units','normalized','Color','blue','FontSize',12)
% saveas(gcf, strcat(file.folder,'\Figures\8plot\IV_semilog\',extractBefore(file.name,".csv"),".png" ))
% 
% %creates a plot using of the current density versus voltage
% figure(3)
% plot(v,I_dens,'-o',...
%     'LineWidth',3,...
%     'MarkerSize',3,...
%     'MarkerEdgeColor','m',...
%     'MarkerFaceColor',[0.5,0.5,0.5])
% 
% xlim([v(index_min)*1.1, v(index_max)*1.1])
% title(file.struct)
% xlabel('Voltage(V)')
% ylabel('Current Density(mA.cm^-3)')
% text(0.08,0.92,Area,'Units','normalized','Color','red','FontSize',12)
% text(0.08,0.84,scan,'Units','normalized','Color','blue','FontSize',12)
% saveas(gcf, strcat(file.folder,'\Figures\8plot\JV\',extractBefore(file.name,".csv"),".png" ))
% 
% 
% %creates a plot using a base 10 logarithmic of the current density versus voltage
% figure(4)
% semilogy(v,abs(I_dens),'-o',...
%     'LineWidth',3,...
%     'MarkerSize',3,...
%     'MarkerEdgeColor','c',...
%     'MarkerFaceColor',[0.5,0.5,0.5])
% 
% xlim([v(index_min)*1.1, v(index_max)*1.1])
% title(file.struct)
% xlabel('Voltage(V)')
% ylabel('Current Density(mA.cm^-3)')
% text(0.03,0.1,Area,'Units','normalized','Color','red','FontSize',12)
% text(0.03,0.18,scan,'Units','normalized','Color','blue','FontSize',12)
% saveas(gcf, strcat(file.folder,'\Figures\8plot\JV_semilog\',extractBefore(file.name,".csv"),".png" ))


end