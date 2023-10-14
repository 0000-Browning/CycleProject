close all;
clear
clc

fptrIn = fopen('signCNNlogs.txt','r');
fptrInDense = fopen('signDenselogs.txt','r');
fptrOut = fopen('signCNNdata.txt','w');
fptrOutDense = fopen('signDensedata.txt','w');

accuracy = [];
loss = [];

accuracyDense = [];
lossDense = [];

data = fscanf(fptrIn,'%c');
dataDense = fscanf(fptrInDense,'%c');

aText = ['a','c','c','u','r','a','c','y'];
lText = ['l','o','s','s'];

count =  1;
offset = 10;
readValue = 1;


%Read accuracy - CNN
for  i = 1:37214-7
     if(data(i:i+7) == aText)
         if(readValue == 1)
             x = str2double(data(i+offset:i+offset+5));
             accuracy(count) = x;
             count = count + 1;
             readValue = 0;
         else
             readValue = 1;
         end
     end
end

count2 = 1;
readValue = 1;
%Read accuracy - Dense
for  i = 1:153745-7
     if(dataDense(i:i+7) == aText)
         if(readValue == 9)
             x = str2double(dataDense(i+offset:i+offset+5));
             accuracyDense(count2) = x;
             count2 = count2 + 1;
             readValue = 1;
         else
             readValue = readValue +1;
         end
     end
end

offset2 = 7;
readValue = 1;
%Read loss - CNN
for  i = 1:37214-7
     if(data(i:i+3) == lText)
         if(readValue == 1)
             x = str2double(data(i+offset2:i+offset2+5));
             loss(count) = x;
             count = count + 1;
             readValue = 0;
         else
             readValue = 1;
         end
     end
end

count2 = 1;
readValue = 1;
%Read accuracy - Dense
for  i = 1:153745-7
     if(dataDense(i:i+3) == lText)
         if(readValue == 9)
             x = str2double(dataDense(i+offset2:i+offset2+5));
             lossDense(count2) = x;
             count2 = count2 + 1;
             readValue = 1;
         else
             readValue = readValue +1;
         end
     end
end

figure
accuracy = accuracy*100;
accuracyDense = accuracyDense*100;

plot(1:150, accuracy, 'r');
hold on
plot(1:155, accuracyDense, 'b');
axis([0 150 0 103])

title("Network Training Accuracy Over time", FontSize=18)
legend('Convolutional','Dense','Location','southwest',FontSize=12);
xlabel('Checkpoint Number',FontSize=12)
ylabel('% of Signs Correctly Identified',FontSize=12)
hold off



% figure
% plot(1:150, loss, 'r');
% hold on
% plot(1:155, lossDense, 'b');
% axis([0 155 0 1])
% hold off
% 
% accuracy
% accuracyDense



fclose(fptrIn);
fclose(fptrOut);