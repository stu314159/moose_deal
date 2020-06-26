// Gmsh project created on Thu Jun 25 17:22:04 2020
//+
Point(1) = {0, 0, 0, 1.0};
//+
Point(2) = {30, 0, 0, 1.0};
//+
Point(3) = {30, 1, 0, 1.0};
//+
Point(4) = {0, 1, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Line(3) = {3, 4};
//+
Line(4) = {4, 1};
//+
Line Loop(1) = {3, 4, 1, 2};
//+
Plane Surface(1) = {1};
//+
Physical Line("inlet") = {4};
//+
Physical Line("outlet") = {2};
//+
Physical Line("top_wall") = {3};
//+
Physical Line("bottom_wall") = {1};
//+
Physical Point("top_right") = {3};

//+
Physical Surface("fluid") = {1};
