[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = -1
  xmax = 1
  ymin = -1
  ymax = 1
  nx = 1
  ny = 1
  uniform_refine = 5
[]


[Variables]
  [u]
    family = LAGRANGE
    order = FIRST
    initial_condition = 0.
  []
[]

[Kernels]

  [conduction]
    type = ADHeatConduction
    variable = u
    thermal_conductivity = thermal_conductivity    
  []
  
  [heatsource]
    type = ADMatHeatSource
    material_property = volumetric_heat
    variable = u
    scalar = 1.0
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
    boundary = 'right left top bottom'
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
