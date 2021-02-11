[Mesh]
  [./gen_mesh]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = 0
    xmax = 2
    ymin = 0
    ymax = 4
    nx = 20
    ny = 40
  [../]
[]

[Problem]
  kernel_coverage_check = off
[]

[Variables]
  [./v]
    family = MONOMIAL
    order = CONSTANT
    fv = true
  [../]
[]

[ICs]
  [./v_ic]
    type = FunctionIC
    variable = v
    function = 'r2 := (x - 0.5)*(x - 0.5) + (y - 0.3)*(y - 0.3); exp(-r2 * 20)'
  [../]
[]

[FVKernels]
  [./advection]
    type = FVAdvection
    variable = v
    velocity = '0.25 0.5 0'
  [../]
  [./time]
    type = FVTimeKernel
    variable = v
  [../]
[]

[FVBCs]
  [./fv_outflow]
    type = FVConstantScalarOutflowBC
    velocity = '0.25 0.5 0'
    variable = v
    boundary = 'right top'
  [../]
[]

[Executioner]
  type = Transient
  petsc_options = '-snes_converged_reason'
  num_steps = 50
  dt = 0.05
  nl_rel_tol = 1e-12
[]

[Outputs]
  exodus = true
[]