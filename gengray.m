function gengray(width, height)
[P,offset] = graycode(width,height);
fprintf('Column offset: %d\nRow offset: %d\n',offset(1),offset(2));
k=1;
for j=1:2
    for i=1:size(P{1},3);
        if(j==1)
            file_name1=['column_pattern_',num2str(k,'%0.02d'),'.bmp'];
            imwrite(double(P{j}(:,:,i)),file_name1);
            k=k+1;
            file_name2=['column_pattern_',num2str(k,'%0.02d'),'.bmp'];
            imwrite(double(1-P{j}(:,:,i)),file_name2);
            k=k+1;
            disp([file_name1,' and ',file_name2,'..written']);
        else
            file_name1=['row_pattern_',num2str(k,'%0.02d'),'.bmp'];
            imwrite(double(P{j}(:,:,i)),file_name1);
            k=k+1;
            file_name2=['row_pattern_',num2str(k,'%0.02d'),'.bmp'];
            imwrite(double(1-P{j}(:,:,i)),file_name2);
            k=k+1;
            disp([file_name1,' and ',file_name2,'..written']);
        end
    end
end
clear P 