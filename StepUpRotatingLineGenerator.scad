function gen_length(max_length, height) = round(rands(height,max_length,1)[0]);

function gen_angle() = rands(-160, 160, 1)[0];

function matrix_identity() = 
    [ [1, 0, 0, 0],
      [0, 1, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1] ];

function matrix_translate1(length, height, must_jump) =
    [ [1, 0, 0, length-height],
      [0, 1, 0, 0],
      [0, 0, 1, must_jump ? height:0],
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

function bar_vertices(length, height, mtx) = cube_vertices(-height/2, length-height/2, height/2, height, mtx);

function cube_vertices(dx1,dx2, dy, dz, mtx) = 
    [
        mtx*[  dx1,  -dy,  0, 1 ],  //0
        mtx*[ dx2,  -dy,  0, 1 ],  //1
        mtx*[ dx2,  dy,  0, 1 ],  //2
        mtx*[  dx1,  dy,  0, 1 ],  //3
        mtx*[  dx1,  -dy,  dz, 1 ],  //4
        mtx*[ dx2,  -dy,  dz, 1 ],  //5
        mtx*[ dx2,  dy,  dz, 1 ],  //6
        mtx*[  dx1,  dy,  dz, 1 ]]; //7

CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
counter = [];  

function plane_side(p0, p1, p2, q) = (q-p1)*cross((p0-p1),(p2-p1));

function inside(p0, p1, p2, r0, r1, r2, q) = plane_side(p0, p1, p2, q)*plane_side(r0, r1, r2, q) <= 0;

function inside_face(bar_vtx, inx, q) = inside(bar_vtx[inx[0]], bar_vtx[inx[1]], bar_vtx[inx[2]], bar_vtx[inx[3]], bar_vtx[inx[4]], bar_vtx[inx[5]], q);
    
function inside_bar(bar_vtx, q) = inside_face(bar_vtx, [0,1,2,7,6,5],q) && 
                                  inside_face(bar_vtx, [4,5,1,6,7,3],q) &&
                                  inside_face(bar_vtx, [5,6,2,7,4,0],q);

function intersect_bars(bar_vtx1, bar_vtx2) = len([for (i = [0:7]) if (inside_bar(bar_vtx1, bar_vtx2[i])) 1]); 

module step1(max_length=10, height=1, mtx, n=5, counter)
    {
        length = gen_length(max_length, height);
        angle = gen_angle();
        mtxr = [ for (i = [ 0 : 2 ]) [ for (j = [ 0 : 3 ]) mtx[i][j] ] ];
        bar_vtx = bar_vertices(length,height,mtxr);
        //intersect_array = [for (i = [0:len(counter)-2]) 1];
        intersect_array = [for (i = [0:max(0,len(counter)-2)]) if (intersect_bars(counter[i], bar_vtx)) i];
        must_jump = (len(intersect_array) > 0);
        echo("ARRAY:", intersect_array, "Jump?:", must_jump);
        mt1 = matrix_translate1(length, height, must_jump);
        mt2 = matrix_translate2(height);
        mr = matrix_rotate(angle);
        mm = mt1*mr; //possibly the opposite
        echo(mm);
        mtx = mtx*mm;
        counter = concat(counter, [bar_vtx]);
        translate([-height/2, -height/2, 0])
            color("blue", 0.5)
                cube([length, height, height]);
                translate([length-height,0,must_jump ? height:0])
                    rotate([0,0,angle])
                        if (n>1) step1(max_length, height, mtx, n-1, counter);
    };




step1(10,2,matrix_identity(), 10, counter);    
   
   

 
bar1= bar_vertices(2, 2, matrix_identity());
echo("BAR1", bar1);
echo(len(bar1));
    
echo("INSIDE",inside_bar(bar1, [0,0,1]));
bar2= bar_vertices(2, 2, matrix_translate2(0.5));
echo("BAR2", bar2);
echo(intersect_bars(bar1, bar2));
echo([3,5,7]*[1,1,1]);
    
echo(inside_face(bar1, [0,1,2,7,6,5],[0,0,1]));
echo(inside_face(bar1, [4,5,1,6,7,3],[0,0,1]));
echo(inside_face(bar1, [5,6,2,7,4,0],[0,0,1]));

echo(inside([-1, -1, 0], [1,-1,0],[-1,1,0], [-1, -1, 2], [1,-1,2],[-1,1,2], [0,0,1]));
echo(plane_side([-1, -1, 0], [1,-1,0],[-1,1,0], [0,0,1]));
echo(plane_side([-1, -1, 2], [1,-1,2],[-1,1,2], [0,0,1]));
