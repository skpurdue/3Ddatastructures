function gen_length(max_length, height) = round(rands(height,max_length,1)[0]);

function gen_angle() = rands(-160, 160, 1)[0];

function matrix_identity() = 
    [ [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1] ];

function matrix_translate(length, height) =
    [ [1, 0, 0, length-height-height/2],
      [0, 1, 0, -height/2],
      [0, 0, 1, height], //to make translate when intersecting
      [0, 0, 0,  1] ];

function matrix_rotate(angle) =       
    [ [cos(angle), -sin(angle), 0, 0],
      [sin(angle),  cos(angle), 0, 0],
      [         0,           0, 1, 0],
      [         0,           0, 0,  1] ];

module step1(max_length=10, height=1, mtx, n=5)
    {
        length = gen_length(max_length, height);
        angle = gen_angle();
        mt = matrix_translate(length, height);
        mr = matrix_rotate(angle);
        mm = mt*mr; //possibly the opposite
        mtx = mtx*mm;
        translate([-height/2, -height/2, 0])
            cube([length, height, height]);
            translate([length-height,0,height])
                rotate([0,0,angle])
                    if (n>1) step1(max_length, height, mtx, n-1);
    };

step1(20,2,matrix_identity(), 10);