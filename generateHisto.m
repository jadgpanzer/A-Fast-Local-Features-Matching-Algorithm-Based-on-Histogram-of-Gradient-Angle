function base_histo = generateHisto(cell , cell_rotation_matrix,cell_size)
    index = mod(cell,360) / (360/8) ;
    index = mod(index,8);
    index = floor(index);
    base_histo = zeros(1,8);
    number = 0 ;
    for i = 1:cell_size
        for j = 1:cell_size
            if cell_rotation_matrix(i,j) == 1 && ~isnan(index(i,j))  
                number = number + 1 ;
                base_histo(index(i,j)+1) = base_histo(index(i,j)+1) + 1 ;
            end
        end
    end
    base_histo = base_histo/number ;
    