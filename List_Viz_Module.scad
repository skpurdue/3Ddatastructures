module List_Viz_Generator (h, w, iterations, min_len, max_len) {
    // Randomizing
    rand_len = rands(min_len, max_len, iterations);
    rand_dir = rands(1, 4, iterations);
    // Stored values
    num_height = 1;
    trans_x = 0;
    trans_y = 0;
    // Building the list cubes
        for(i=[0:1:iterations]){
            echo(round(rand_len[i]));
            echo(round(rand_dir[i]));
            translate([trans_x, trans_y, num_height*h]) {
                if (round(rand_dir[i]) == 1)
                    {
                    if (round(rand_dir[i-1]) == 1 || round(rand_dir[i-1]) == 3) {num_height = num_height + 1;}
                    trans_x = trans_x + round(rand_len[i]);
                    cube([round(rand_len[i]), w, h]);
                    }
                else if (round(rand_dir[i]) == 2) 
                    {
                    if (round(rand_dir[i-1]) == 2 || round(rand_dir[i-1]) == 4) {num_height = num_height + 1;}
                    trans_y = trans_y + round(rand_len[i]);
                    cube([w, round(rand_len[i]), h]);
                    }
                else if (round(rand_dir[i]) == 3)
                    {
                    if (round(rand_dir[i-1]) == 1 || round(rand_dir[i-1]) == 3) {num_height = num_height + 1;}
                    trans_x = trans_x - round(rand_len[i]);
                    cube([-round(rand_len[i]), w, h]);
                    }
                else
                    {
                    if (round(rand_dir[i-1]) == 2 || round(rand_dir[i-1]) == 4) {num_height = num_height + 1;}
                    trans_y = trans_y - round(rand_len[i]);
                    cube([w, -round(rand_len[i]), h]);
                    }
            }
        }
}
      
List_Viz_Generator(1, 1, 10, 1, 30);