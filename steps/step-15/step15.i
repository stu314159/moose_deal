[Mesh]
  type = FileMesh
  file = step15.msh
  uniform_refine = 1
[]

[Adaptivity]
  marker = error_frac
  steps = 3
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
      coarsen = 0.3
      refine = 0.6
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
    value = '0' # doesn't need to be this way but making minimal modifications
  []
  [bc_fun]
    type = ParsedFunction
    value = 'sin(2*pi*(x+y))' 
  []
[]

[Kernels]
# for this step all that I require is a diffusion kernel and something for the rhs.
  [diff]
    type = LaplaceYoungDiffusion # re-use this from the LaplaceYoung exercise.
    variable = u    
  []
  [rhs]
    type = ADBodyForce  # don't really need this for step-15 but, it's here anyway.
    function = rhs_fun 
    variable = u
  []

[]

[BCs]
 [all]
   type = ADFunctionDirichletBC
   variable = u
   boundary = 'boundary'
   function = bc_fun
 []
[]

[Executioner]
  type = Steady  
  solve_type = NEWTON
  petsc_options = '-ksp_converged_reason'
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg' 
[]

[Outputs]
  #execute_on = 'timestep_end'
  #exodus = true
  vtk = true
  file_base = 'step15'
  
[]
