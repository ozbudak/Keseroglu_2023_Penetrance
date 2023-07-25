clear all;
samplesize = 8;
position = 'Df_S-3';

folder = 'C:\...\Analysis\'; %Enter analysis folder path
data= importdata([folder position '\' position '_Exp.csv']);

SdPkTr=zeros(1300,252)*NaN;
PkTr=zeros(1300,252)*NaN;

    for i = 1:samplesize

[datars(:,2*i),datars(:,(2*i)-1)]=resample(smoothdata(data.data(:,2*i), "sgolay",3),data.data(:,(2*i)-1),10,1,10);
[datanrs(:,2*i),datanrs(:,(2*i)-1)]=resample(smoothdata(-data.data(:,2*i), "sgolay",3),data.data(:,(2*i)-1),10,1,10);

datarss(1:length(datars(:,2*i))-20,(2*i))=datars(11:length(datars(:,2*i))-10,2*i);
datarss(1:length(datars(:,(2*i)-1))-20,(2*i)-1)=datars(11:length(datars(:,2*i))-10,(2*i)-1);

datanrss(1:length(datanrs(:,2*i))-20,(2*i))=datanrs(11:length(datanrs(:,2*i))-10,2*i);
datanrss(1:length(datanrs(:,(2*i)-1))-20,(2*i)-1)=datanrs(11:length(datanrs(:,2*i))-10,(2*i)-1);

SdPkTr(1:length(datars(:,2*i))-20,(6*i)-4)=datars(11:length(datars(:,2*i))-10,2*i);
SdPkTr(1:length(datars(:,(2*i)-1))-20,(6*i)-5)=datars(11:length(datars(:,2*i))-10,(2*i)-1);

    end

peaks=zeros(40,168)*NaN;

    for i = 1:samplesize
    dist=3.15;

[a,b]=findpeaks(datanrss(:,2*i),datanrss(:,(2*i)-1),"MinPeakDistance",dist);
peaks(1:length(a),(4*i)-2)=-1*a;
peaks(1:length(b),(4*i)-3)=b;
SdPkTr(1:length(a),(6*i)-2)=-1*a;
SdPkTr(1:length(b),(6*i)-3)=b;
PkTr(1:length(a),(4*i)-2)=-1*a;
PkTr(1:length(b),(4*i)-3)=b;
 findpeaks(datanrss(:,2*i),datanrss(:,(2*i)-1),"MinPeakDistance",dist);

[c,d]=findpeaks(datarss(:,2*i),datarss(:,(2*i)-1),"MinPeakDistance",dist);
peaks(1:length(c),4*i)=c;
peaks(1:length(d),(4*i)-1)=d;
SdPkTr(1:length(c),(6*i))=c;
SdPkTr(1:length(d),(6*i)-1)=d;
PkTr(1:length(c),(4*i))=c;
PkTr(1:length(d),(4*i)-1)=d;
 findpeaks(datarss(:,2*i),datarss(:,(2*i)-1),"MinPeakDistance",dist);

plot(SdPkTr(:,(6*i)-5),SdPkTr(:,(6*i)-4),'-b',SdPkTr(:,(6*i)-3),SdPkTr(:,(6*i)-2),'or',SdPkTr(:,(6*i)-1),SdPkTr(:,(6*i)),'og');
grid 'on';
xticks(0:6.3:107.1);
Tlabels=cellstr(num2str(SdPkTr(:,(6*i)-3)));
Plabels=cellstr(num2str(SdPkTr(:,(6*i)-1)));
text(SdPkTr(:,(6*i)-3),SdPkTr(:,(6*i)-2),Tlabels,'VerticalAlignment','top','HorizontalAlignment','center',FontSize=6);
text(SdPkTr(:,(6*i)-1),SdPkTr(:,(6*i)),Plabels,'VerticalAlignment','bottom','HorizontalAlignment','center',FontSize=6);
fm = fullfile(folder,position,"\Figures\",position+"_"+i+"_Figure"+".jpg");
saveas(gcf,fm,'jpg');

    end

pk = fullfile(folder,position,"\",position+"_SmoothenedData_Peaks_Troughs"+".xls");
writematrix(SdPkTr, pk);
pktr = fullfile(folder,position,"\",position+"_Peaks_Troughs"+".xls");
writematrix(PkTr, pktr);
clear all;