crucible_r = 0.245 #m
rho = 2490 #kg m^-3 Reference Density
#k = 124 #W m^-1 K^-1 Heat conductivity
#cp = 1000 #J kg^-1 K^-1 Heat capacity

[Mesh]
  [ccmg]
    type = ConcentricCircleMeshGenerator
    has_outer_square = false
    num_sectors = 18
    radii = '${crucible_r}'
    rings = '8'
    preserve_volumes = true
  []
  uniform_refine = 2
[]

[Variables]
  [T]
    initial_condition = 300 #K
  []
[]

[Kernels]
  [heat_conduction]
    type = HeatConduction
    variable = T
  []

  [time_derivative]
    type = HeatConductionTimeDerivative
    variable = T
  []
[]

[BCs]
  [circumference_T]
    type = DirichletBC
    variable = T
    value = 1500 #K
    boundary = 'outer'
  []
[]

[Functions]
  [k_function]
    type = PiecewiseLinear
    format = COLUMNS
    data_file = '../Si_data/Si_solid_k.csv'
  []
[]

[Materials]
  [thermo]
    type = ShomateHeatConductionMaterial
    a = 22.81719
    b = 3.899510e-3
    c = -0.082885e-6
    d = 0.042111e-9
    e = -0.354063e6
    temp = T
    thermal_conductivity_temperature_function = k_function
  []

  [density]
    type = GenericConstantMaterial
    prop_names = 'density'
    prop_values = ${rho}
  []
[]

[Executioner]
  type = Transient
  end_time = 100
  solve_type = NEWTON
  num_steps = 100
  [Adaptivity]
    max_h_level = 4
    refine_fraction = 0.3
    coarsen_fraction = 0.7
  []
[]

[Outputs]
  exodus = true
[]
