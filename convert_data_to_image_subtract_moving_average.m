clear all; close all; clc;

dir_name={'distanceMtrx-N501Y/','distanceMtrx-Q498Y/','distanceMtrx-N501V/','distanceMtrx-Q493Y/','distanceMtrx-N501T/','distanceMtrx-E484K/','distanceMtrx-N501S/','distanceMtrx-Q493N/','distanceMtrx-Q498N/','distanceMtrx-Q498K/','distanceMtrx-N501D/','distanceMtrx-G502P/'};
save_name={'N501Y','Q498Y','N501V','Q493Y','N501T','E484K','N501S','Q493N','Q498N','Q498K','N501D','G502P'};
%all figures subtract the initial crystal state distance

for n=1:12
    readFiles=dir(strcat(dir_name{n},'*.dat'));
    numfiles=8000;%length(readFiles);
    file_name = {readFiles.name};
    str  = sprintf('%s#', file_name{:});
    num  = sscanf(str, ['d-Mtrx-' save_name{n} '.ts.%d.dat#']);
    [~, index] = sort(num);
    file_name = file_name(index);

    
    initial=file_name{1}; %data for t=0ns
    initial_data=table2array(readtable(strcat(dir_name{n},initial)));
    
    step=20; %moving average, average over self and previous 19 frames.
    prev=zeros(size(initial_data,1),size(initial_data,2),step);
    
    for id=2:step %fill in the previous 9 instances
        %get the file name
        data_name=file_name{id};
        prev(:,:,id-1)=table2array(readtable(strcat(dir_name{n},data_name)))-initial_data;
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
        prev(:,:,1:(step-1))=prev(:,:,2:step);
    end
%     disp(maxv(n));
%     disp(minv(n));
    
end


