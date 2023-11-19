function histos = blockFeature(block_image , block_angle , block_rotation_matrix,cell_size)
    %Split every block into 4 cells
    layer_number = 3 ; %upsample + original + downsample
    shift_size = 3 ;

    cell_1 = block_image(1:cell_size,1:cell_size);
    cell_2 = block_image(1:cell_size,(cell_size+1):2*cell_size);
    cell_3 = block_image((cell_size+1):2*cell_size,(cell_size+1):2*cell_size);
    cell_4 = block_image((cell_size+1):2*cell_size,1:cell_size);

    cell_1_angle = block_angle(1:cell_size,1:cell_size);
    cell_2_angle = block_angle(1:cell_size,(cell_size+1):2*cell_size);
    cell_3_angle = block_angle((cell_size+1):2*cell_size,(cell_size+1):2*cell_size);
    cell_4_angle = block_angle((cell_size+1):2*cell_size,1:cell_size);
    r_1 = block_rotation_matrix(1:cell_size,1:cell_size);
    r_2 = block_rotation_matrix(1:cell_size,(cell_size+1):2*cell_size);
    r_3 = block_rotation_matrix((cell_size+1):2*cell_size,(cell_size+1):2*cell_size);
    r_4 = block_rotation_matrix((cell_size+1):2*cell_size,1:cell_size);

    cells = [cell_1,cell_2,cell_3,cell_4];
    cells_r = [r_1,r_2,r_3,r_4];
    cells_angle = [cell_1_angle,cell_2_angle,cell_3_angle,cell_4_angle];
    histos = zeros(1,4*layer_number*shift_size*8);

    for i = 1:4
       this_cell = cells(: , cell_size*(i-1)+1 : cell_size*i);
       this_cell_angle = cells_angle(: , cell_size*(i-1)+1 : cell_size*i);
       this_rotation = cells_r(: , cell_size*(i-1)+1: cell_size*i) ;
       
       upsample_layers   = imageUpsample(this_cell,2);
       downsample_layers = imageDownsample(this_cell,2);
       original_layers   = this_cell ;
       h0 = zeros(1,8*shift_size);
       h1 = zeros(1,8*shift_size);
       h2 = zeros(1,8*shift_size);
       
       for shift = 1:shift_size
           new_angle_matrix = compensation(upsample_layers, this_cell_angle ,shift - 2);
           h = generateHisto(new_angle_matrix, this_rotation ,cell_size/2);
           h0(1,8*(shift-1)+1:8*shift) = h;
       end
       for shift = 1:shift_size
           new_angle_matrix = compensation(downsample_layers, this_cell_angle ,shift - 2);
           h = generateHisto(new_angle_matrix, this_rotation ,cell_size/2);
           h1(1,8*(shift-1)+1:8*shift) = h;
       end
       for shift = 1:shift_size
           new_angle_matrix = compensation(original_layers, this_cell_angle ,shift - 2);
           h = generateHisto(new_angle_matrix, this_rotation ,cell_size/2);
           h2(1,8*(shift-1)+1:8*shift) = h;
       end
       histo = [h0,h1,h2];
       histos(1,8*shift_size*layer_number*(i-1)+1:8*shift_size*layer_number*i) = histo;
    end
    
    