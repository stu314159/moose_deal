# this input file is borrowed from moose/modules/navier_stokes/test/tests/ins/...
# .../velocity_channel/velocity_inletBC_no_parts.i

[GlobalParams]
  gravity = '0 0 0'
  integrate_p_by_parts = false
[]

[Mesh]
  [gen]
    type = FileMeshGenerator
    file = 'pois2D_channel.msh'
   []
[]


[Variables]
  [./vel_x]
    order = SECOND
    family = LAGRANGE
  [../]
  [./vel_y]
    order = SECOND
    family = LAGRANGE
  [../]
  [./p]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./mass]
    type = INSMass
    variable = p
    u = vel_x
    v = vel_y
    p = p
  [../]
  [./x_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_x
    u = vel_x
    v = vel_y
    p = p
    component = 0
  [../]
  [./y_momentum_space]
    type = INSMomentumLaplaceForm
    variable = vel_y
    u = vel_x
    v = vel_y
    p = p
    component = 1
  [../]
[]

[BCs]
  [./x_no_slip]
    type = DirichletBC
    variable = vel_x
    boundary = 'top_wall bottom_wall'
    value = 0.0
  [../]
  [./y_no_slip]
    type = DirichletBC
    variable = vel_y
    boundary = 'inlet top_wall bottom_wall'
    value = 0.0
  [../]
  [./x_inlet]
    type = FunctionDirichletBC
    variable = vel_x
    boundary = 'inlet'
    function = 'inlet_func'
  [../]
  [./p_corner]
    # Since the pressure is not integrated by parts in this example,
    # it is only specified up to a constant by the natural outflow BC.
    # Therefore, we need to pin its value at a single location.
    type = DirichletBC
    boundary = outlet
    value = 0
    variable = p
  [../]
[]

[Materials]
  [./const]
    type = GenericConstantMaterial
    block = 'fluid'
    prop_names = 'rho mu'
    prop_values = '1  1'
  [../]
[]

[Preconditioning]
  [./SMP_PJFNK]
    type = SMP
    full = true
    solve_type = NEWTON
  [../]
[]

[Executioner]
  type = Steady
  petsc_options_iname = '-ksp_gmres_restart -pc_type -sub_pc_type -sub_pc_factor_levels'
  petsc_options_value = '300                bjacobi  ilu          4'
  line_search = none
  nl_rel_tol = 1e-12
  nl_max_its = 12
  l_tol = 1e-6
  l_max_its = 800
[]

[Outputs]
  [./out]
    type = Exodus
  [../]
[]

[Functions]
  [./inlet_func]
    type = ParsedFunction
    value = '10*(-4 * (y - 0.5)^2 + 1)'
  [../]
[]
