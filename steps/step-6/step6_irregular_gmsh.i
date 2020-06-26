
[Mesh]
  type = FileMesh
  file = step6.msh
  uniform_refine = 1
[]

[Adaptivity]
  marker = error_frac
  max_h_level = 0
  steps = 10
  [Indicators]
    [temperature_jump]
      type = GradientJumpIndicator
      variable = u
      scale_by_flux_faces = false
    []
  []
  [Markers]
    [error_frac]
      type = ErrorFractionMarker
      indicator = temperature_jump      
      coarsen = 0.2
      refine = 0.8
    []
  []
[]


[Variables]
 [u]
   # by default MooseVariable objects are represented as 1st order Lagrange
  family = LAGRANGE
  order = FIRST # make these defaults explicit 
 []
[]

[Functions]
  [rhs_fun]
    type = ParsedFunction
    value = '1' # doesn't need to be this way but making minimal modifications
  []
  [bc_fun]
    type = ParsedFunction
    value = '0' # doesn't need to be this way but making minimal modifications
  []
[]

[Kernels]
# for this step all that I require is a diffusion kernel and something for the rhs.
  [diff]
    # need (a(x)*grad_u,grad_phi)
    type = ADStep6Diffusion # need a kernel to give this parameter
    variable = u
  []
  [rhs]
    type = ADBodyForce
    function = rhs_fun 
    variable = u
  []

[]

[BCs]
 [all]
   type = ADDirichletBC
   variable = u
   boundary = r_max
   value = 0
 []
[]

[Executioner]
  type = Steady
  #solve_type = LINEAR
  #petsc_options = '-ksp_converged_reason' 
  # Moose and Deal.II both leverage PETSc for solvers but
  # Moose seems to lean more heavily on the Scalable Non-linear Equation Solvers
  # (snes) than Deal.II.
  solve_type = NEWTON
  petsc_options = '-ksp_converged_reason'
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg' 
[]

[Outputs]
  execute_on = 'timestep_end'
  exodus = true
[]
