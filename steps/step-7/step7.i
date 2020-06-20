[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 1
  ny = 1
  xmin = -1
  xmax = 1
  ymin = -1
  ymax = 1
  uniform_refine = 4
[]

[Adaptivity]
  marker = error_frac
  max_h_level = 0
  steps = 6
  [Indicators]
    [temperature_jump]
      type = GradientJumpIndicator
      variable = u
      scale_by_flux_faces = true
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
    type = Step7RHSFunction
  []
  [sol_fun]
    type = Step7SolutionFunction # also used for the Dirichlet BCs
  []
[]

[Kernels]
# for this step all that I require is a diffusion kernel and something for the rhs.
  [diff]
    type = ADDiffusion
    variable = u
  []
  
  [term2]  # just u
    type = ADMassSRB
    variable = u
  []
  
  [rhs]
    type = ADBodyForce
    #value = 1
    function = rhs_fun # obtained by manufactured solution technique
    variable = u
  []

[]

[BCs]
 [all]
   type = ADFunctionDirichletBC
   variable = u
   boundary = "right left top bottom"
   function = sol_fun
 []
[]

[Executioner]
  type = Steady
  #solve_type = LINEAR
  petsc_options = '-ksp_converged_reason' 
  # Moose and Deal.II both leverage PETSc for solvers but
  # Moose seems to lean more heavily on the Scalable Non-linear Equation Solvers
  # (snes) than Deal.II.
  solve_type = NEWTON
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg' 
[]

[Outputs]
  exodus = true
[]
