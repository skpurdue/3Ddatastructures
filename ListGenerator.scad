List_Viz_Generator(h, w, iterations, min_len, max_len){
     \\Randomizing
     rand_len = rands(min_len, max_len, iterations)
     rand_dir = rands(1, 4, iterations)
     \\Building the list cubes
     union() {
      for(i=[0:1:iterations]){
        \\Untranslated cube first
        if (i == 0)
        {
          if (rand_dir[i] == 1) cube([rand_len[i], w, h]);
          else if (rand_dir[i] == 2) cube([w, rand_len[i], h]);
          else if (rand_dir[i] == 3) cube([-rand_len[i], w, h]);
          else (rand_dir[i] == 4) cube([w, -rand_len[i], h]);
        }
        \\Then translated cubes
        else
        {
          translate([0, (27-11), 1]) {
            if (rand_dir[i] == 1) cube([rand_len[i], w, h]);
            else if (rand_dir[i] == 2) cube([w, rand_len[i], h]);
            else if (rand_dir[i] == 3) cube([-rand_len[i], w, h]);
            else (rand_dir[i] == 4) cube([w, -rand_len[i], h]);
          }
        }
