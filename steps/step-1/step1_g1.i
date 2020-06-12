# start by just generating and outputting a rectangular mesh with 
# 4 levels of mesh refinement.

# to get moose to just ouptut the mesh:
# invoke the code $my_app-opt -i input_file.i --mesh-only

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 1
  ny = 1
  xmax = 1
  ymax = 1
  uniform_refine = 4
[]
