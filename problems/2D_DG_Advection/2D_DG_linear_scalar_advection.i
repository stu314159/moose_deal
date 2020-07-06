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
    uniform_refine = 2
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
    variable = v
    velocity = '0.25 0.5 0'
  [../]
[]

#[BCs]
#  [./allow_mass_out]
#    type = OutflowBC
#    boundary = 'top right'
#    variable = v
#   velocity = '0.25 0.5 0'
#  []
#[]

[Executioner]
  type = Transient
  [./TimeIntegrator]
    type = ExplicitSSPRungeKutta
    order = 2
  [../]
  solve_type = 'LINEAR'
  num_steps = 1000
  dt = 2.5e-3
[]

[Outputs]
  interval = 20
  exodus = true
[]
