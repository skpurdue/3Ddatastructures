function gen_length(max_length, height) = round(rands(height,max_length,1)[0]);

function gen_angle() = rands(-180, 180, 1)[0];

module step1(max_length=10, height=1, n=5)
    {
        length = gen_length(max_length, height);
        translate([-height/2, -height/2, 0])
            cube([length, height, height]);
            translate([length-height,0,height])
                rotate([0,0,gen_angle()])
                    if (n>1) step1(max_length, height, n-1);
    };    

step1(20,2,5);
