clear all
clc

my_data = importdata('2019-12-14-11-33-26DataDemo_Sequence_Identy.csv');
data_num = length(my_data.data);
t = 1:data_num;

figure
plot(t,my_data.data(:,3),'r');    
hold on
plot(t,my_data.data(:,1),'b-')
axis([0 800 0 100]);
xlabel('Time/s');
ylabel('Data');   
legend('Temperature','M-sequence')
title('Data with M-sequence');


