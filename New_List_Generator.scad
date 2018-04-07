function gen_length(max_length) = round(rands(0,max_length,1)[0]);

module step1(max_length=10, height=1, n=5)
    {
        length = gen_length(max_length);
        cube([length, height, height]);
        translate([length-height,0,height])
            if (n>1) step1(max_length, height, n-1);
    };    

step1(10,1,5);
