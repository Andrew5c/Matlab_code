clear all
clc

my_data = importdata('2019-12-14-9-7-27DataDemo.csv');
data_num = length(my_data.data);
t = 1:data_num;

plot(t,my_data.data(:,3),'r');    
axis([0 4500 0 100]);
xlabel('Time/s');
ylabel('Temperature');       
title('Original Data');

