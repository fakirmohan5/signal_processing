csv1 = csvread('PartSinwave1.csv');
csv2 = csvread('PartSinwave11.csv');
csv3 = csvread('PartSinwave10.csv');
allCsv = [csv1;csv2;csv3]; % Concatenate vertically
csvwrite('VaryingFreqSinWave10_8_12.csv', allCsv);
plot(allCsv)
