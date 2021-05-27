clear all; close all; clc;
%the directory names to the distance matrices of ifferent mutations. There are in total 12 mutations and this code preprocesses all of them with a for loop.
dir_name={'distanceMtrx-N501Y/','distanceMtrx-Q498Y/','distanceMtrx-N501V/','distanceMtrx-Q493Y/','distanceMtrx-N501T/','distanceMtrx-E484K/','distanceMtrx-N501S/','distanceMtrx-Q493N/','distanceMtrx-Q498N/','distanceMtrx-Q498K/','distanceMtrx-N501D/','distanceMtrx-G502P/'};
%the names of the 12 mutations
save_name={'N501Y','Q498Y','N501V','Q493Y','N501T','E484K','N501S','Q493N','Q498N','Q498K','N501D','G502P'};
%all figures subtract the initial crystal state distance

for n=1:12 %loop through the 12 mutations
    readFiles=dir(strcat(dir_name{n},'*.dat'));
    numfiles=8000;%length(readFiles); % 8000  molecular  snapshots (20ps each)
    file_name = {readFiles.name};
    str  = sprintf('%s#', file_name{:});
    num  = sscanf(str, ['d-Mtrx-' save_name{n} '.ts.%d.dat#']);
    [~, index] = sort(num);
    file_name = file_name(index);

    
    initial=file_name{1}; %data for t=0ps
    initial_data=table2array(readtable(strcat(dir_name{n},initial)));%load data at t=0
    
    step=20; %moving average, average over self and previous 19 frames.
    prev=zeros(size(initial_data,1),size(initial_data,2),step); %record all the data before doing the moving average
    
    for id=2:step %fill in the previous 19 instances
        %get the file name
        data_name=file_name{id};
        prev(:,:,id-1)=table2array(readtable(strcat(dir_name{n},data_name)))-initial_data;%record data that has the background (t=0) removed 
    end
    
    for id=(step+1):numfiles
        data_name=file_name{id};
        prev(:,:,end)=table2array(readtable(strcat(dir_name{n},data_name)))-initial_data;
        average_data=mean(prev,3);
        norm_data=(average_data-min(average_data(:)))/(max(average_data(:))-min(average_data(:)));
        %norm_data=average_data/up_limit;
%         maxv(n)=max(maxv(n),max(max(norm_data)));
%         minv(n)=min(minv(n),min(min(norm_data)));
        picname=[pwd '/pic_' save_name{n} '_subtract_ave/' num2str(id-1, '%05d') '.png'];
        imwrite(norm_data,picname)
        %everytime when moving one time step, the matrix moves to the left and only the last column need to be filled with new data
        prev(:,:,1:(step-1))=prev(:,:,2:step);
    end
%     disp(maxv(n));
%     disp(minv(n));
    
end


