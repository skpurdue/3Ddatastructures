module List_Viz_Generator (h, w, iterations, min_len, max_len) {
    // Randomizing
    rand_len = rands(min_len, max_len, iterations);

    rand_dir = rands(1, 4, iterations);
    // Stored values
    num_height = 1;
    trans_x = 0;
    trans_y = 0;
    // Building the list cubes
    union() {
        for(i=[0:1:iterations]){
            translate([trans_x, trans_y, num_height*h]) {
                if (rand_dir[i] == 1)
                    {
                    if (rand_dir[i-1] == 1 || rand_dir[i-1] == 3) {num_height = num_height + 1;}
                    trans_x = trans_x + rand_len[i];
                    cube([rand_len[i], w, h]);
                    }
                else if (rand_dir[i] == 2)
                    {
                    if (rand_dir[i-1] == 2 || rand_dir[i-1] == 4) {num_height = num_height + 1;}
                    trans_y = trans_y + rand_len[i];
                    cube([w, rand_len[i], h]);
                    }
                else if (rand_dir[i] == 3)
                    {
                    if (rand_dir[i-1] == 1 || rand_dir[i-1] == 3) {num_height = num_height + 1;}
                    trans_x = trans_x - rand_len[i];
                    cube([-rand_len[i], w, h]);
                    }
                else
                    {
                    if (rand_dir[i-1] == 2 || rand_dir[i-1] == 4) {num_height = num_height + 1;}
                    trans_y = trans_y - rand_len[i];
                    cube([w, -rand_len[i], h]);
                    }
            }
        }
    }
}

List_Viz_Generator(1, 1, 10, 1, 30);
