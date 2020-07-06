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

[Variables]
  [./v]
    family = MONOMIAL
    order = FIRST
  [../]
[]

[ICs]
  [./v_ic]
    type = FunctionIC
    variable = v
    function = 'r2 := (x - 0.5)*(x - 0.5) + (y - 0.3)*(y - 0.3); exp(-r2 * 20)'
  [../]
[]

[Kernels]
  [./advection]
    type = ConservativeAdvection
    implicit = false
    variable = v
    velocity = '0.25 0.5 0'
  [../]
  [./time]
    type = TimeDerivative
    variable = v
  [../]
[]

[DGKernels]
  [./dg_advection_u]
    implicit = false
    type = DGConvection
    variable = u
    velocity = '0.25 0.5 0'
  [../]
[]

[Executioner]
  type = Transient
  [./TimeIntegrator]
    type = ExplicitMidpoint
  [../]
  solve_type = 'LINEAR'
  num_steps = 4
  dt = 2e-4
[]



[Outputs]
  exodus = true
[]
