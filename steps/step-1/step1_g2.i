# start by just generating and outputting a rectangular mesh with 
# 4 levels of mesh refinement.

# to get moose to just ouptut the mesh:
# invoke the code $my_app-opt -i input_file.i --mesh-only
#
# As of this writing, I do not know how to selectively refine 
# cells along the inside boundary of the mesh.  

[Mesh]
  type = AnnularMesh
  nr = 10
  nt = 20
  rmax = 1.0
  rmin = 0.5
  growth_r = 1.05
[]
