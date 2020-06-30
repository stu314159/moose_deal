[Mesh]
  type = FileMesh
  file = hyperL_2D.msh
[]

[Adaptivity]
  marker = error_frac
  max_h_level = 7
  steps = 2
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
      coarsen = 0.4
      refine = 0.6
    []
  []
[]


[Variables]
  [u]
    family = LAGRANGE
    order = FIRST
    initial_condition = 0.
  []
[]

[Functions]
  [myRHS]
    type = Step26RHSFunction
  []
[]

[Kernels]

  [conduction]
    type = ADHeatConduction
    variable = u
    thermal_conductivity = thermal_conductivity    
  []
  
  [heatsource]
    type = ADBodyForce
    variable = u
    function = myRHS
  []
  
  [timederivative]
    type = ADHeatConductionTimeDerivative
    variable = u
    density_name = density
    specific_heat = specific_heat
  []
  
[]

[BCs]
  [all]
    type = ADDirichletBC
    variable = u
    boundary = 'all_boundaries'
    value = 0
  []
[]

[Materials]
  [my_material]
    type = ADGenericConstantMaterial
    prop_names = 'thermal_conductivity specific_heat density volumetric_heat'
    prop_values = '1.0 1.0 1.0 10.0'
  []
[]


[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
  scheme = crank-nicolson
  start_time = 0.0
  end_time = 0.5
  [TimeStepper]
    type = ConstantDT
    dt = 0.002
  []    
[]

[Outputs]
  exodus = true
[]
