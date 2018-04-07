function gen_length(max_length, height) = round(rands(height,max_length,1)[0]);

function gen_angle() = rands(-160, 160, 1)[0];

function matrix_identity() = 
    [ [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1] ];

function matrix_translate1(length, height) =
    [ [1, 0, 0, length-height],
      [0, 1, 0, 0],
      [0, 0, 1, height], //to make translate when intersecting
      [0, 0, 0,  1] ];

function matrix_translate2(height) =
    [ [1, 0, 0, -height/2],
      [0, 1, 0, -height/2],
      [0, 0, 1, 0], //to make translate when intersecting
      [0, 0, 0,  1] ];

function matrix_rotate(angle) =       
    [ [cos(angle), -sin(angle), 0, 0],
      [sin(angle),  cos(angle), 0, 0],
      [         0,           0, 1, 0],
      [         0,           0, 0,  1] ];



function cube_vertices(dx, dy, dz, mtx) = 
    [
        mtx*[  -dx,  -dy,  0, 1 ],  //0
        mtx*[ dx,  -dy,  0, 1 ],  //1
        mtx*[ dx,  dy,  0, 1 ],  //2
        mtx*[  -dx,  dy,  0, 1 ],  //3
        mtx*[  -dx,  -dy,  dz, 1 ],  //4
        mtx*[ dx,  -dy,  dz, 1 ],  //5
        mtx*[ dx,  dy,  dz, 1 ],  //6
        mtx*[  -dx,  dy,  dz, 1 ]]; //7

CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
module step1(max_length=10, height=1, mtx, n=5)
    {
        length = gen_length(max_length, height);
        angle = gen_angle();
        mt1 = matrix_translate1(length, height);
        mt2 = matrix_translate2(height);
        mr = matrix_rotate(angle);
        mm = mt1*mr; //possibly the opposite
        mtx = mtx*mm;
        echo(length, angle);
        echo(mtx);
        mtxr = [ for (i = [ 0 : 2 ]) [ for (j = [ 0 : 3 ]) mtx[i][j] ] ];
        color("red", 1)
            if (n>1) polyhedron(cube_vertices(height/2,height/2,height,mtxr), CubeFaces);
        translate([-height/2, -height/2, 0])
            color("blue", 0.5)
                cube([length, height, height]);
                translate([length-height,0,height])
                    rotate([0,0,angle])
                        if (n>1) step1(max_length, height, mtx, n-1);
    };




step1(20,2,matrix_identity(), 5);
    
    