function gen_length(max_length) = rands(0,max_length,1)[0];

module step1(max_length=10, height=1)
    {
        length = gen_length(max_length);
        cube([length, height, height]);
    };
    
step1(10, 1);