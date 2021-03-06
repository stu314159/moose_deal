
[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 1
  ny = 1
  xmin = -1
  xmax = 1
  ymin = -1
  ymax = 1
  uniform_refine = 5
[]

[Variables]
 [u]
   # by default MooseVariable objects are represented as 1st order Lagrange
  family = LAGRANGE
  order = FIRST # make these defaults explicit 
 []
[]

[Kernels]
# for this step all that I require is a diffusion kernel and something for the rhs.
  [diff]
    type = ADDiffusion
    variable = u
  []
  [rhs]
    type = ADBodyForce
    value = 1
    variable = u
  []

[]

[BCs]
 [all]
   type = ADDirichletBC
   variable = u
   boundary = "right left top bottom"
   value = 0
 []
[]

[Executioner]
  type = Steady
  solve_type = LINEAR
  petsc_options = '-ksp_converged_reason' 
  # Moose and Deal.II both leverage PETSc for solvers but
  # Moose seems to lean more heavily on the Scalable Non-linear Equation Solvers
  # (snes) than Deal.II.
  #solve_type = NEWTON
  #petsc_options_iname = '-pc_type -pc_hypre_type'
  #petsc_options_value = 'hypre boomeramg' 
[]

[Outputs]
  execute_on = 'timestep_end'
  exodus = true
[]
