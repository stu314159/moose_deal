//+
Point(1) = {-1, -1, 0, 1.0};
//+
Point(2) = {1, -1, 0, 1.0};
//+
Point(3) = {1, 0, 0, 1.0};
//+
Point(4) = {0, 0, 0, 1.0};
//+
Point(5) = {0, 1, 0, 1.0};
//+
Point(6) = {-1, 1, 0, 1.0};
//+
Line(1) = {1, 2};
//+
Line(2) = {2, 3};
//+
Line(3) = {3, 4};
//+
Line(4) = {4, 5};
//+
Line(5) = {5, 6};
//+
Line(6) = {6, 1};
//+
Curve Loop(1) = {6, 1, 2, 3, 4, 5};
//+
Plane Surface(1) = {1};
//+
Physical Curve("all_boundaries") = {6, 1, 2, 3, 4, 5};
//+
Physical Surface("domain") = {1};
