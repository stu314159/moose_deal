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
    family = LAGRANGE
    order = FIRST
  []
[]

[Functions]
  [bc_fun]
    type = ParsedFunction
    #value = 'sin(x*pi)'  
    value = '1'
  []
[]

[Kernels]
  [diff]
    type = ADDiffusion
    variable = u
  []
  
  [mass]
    type = ADMassSRB
    variable = u
  []
  
  #[rhs]
  #  type = ADBodyForce
  #  value = 1
  #  variable = u
  #[]

[]

[BCs]
  [dirch1]
    type = ADDirichletBC
    variable = u
    boundary = 'right left top'
    value = 0
  []
  
  [dirch2]
    type = ADFunctionDirichletBC
    variable = u
    boundary = 'bottom'
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
  execute_on = 'timestep_end'
  exodus = true
[]
