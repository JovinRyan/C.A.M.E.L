crucible_d = 0.49 #m y-axis
melt_h = 0.16 #m x-axis

### Thermophysical properties from https://www.matweb.com/search/datasheet.aspx?matguid=7d1b56e9e0c54ac5bb9cd433a0991e27&n=1&ckck=1 ###
rho = 2490 #kg m^-3 Reference Density
k = 124 #W m^-1 K^-1 Heat conductivity
#cp = 1000 #J kg^-1 K^-1 Heat capacity

[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    xmax = ${melt_h}
    ymax = ${crucible_d}
    nx = 25
    ny = 100
  []
[]

[Variables]
  [T]
    initial_condition = 300 #K
  []
[]

[BCs]
  [crucible_x_high]
    type = DirichletBC
    variable = T
    value = 1500 #K
    boundary = 'right'
  []

  [crucible_x_low]
    type = DirichletBC
    variable = T
    value = 1500 #K
    boundary = 'left'
  []

  [crucible_y_high]
    type = DirichletBC
    variable = T
    value = 1500 #K
    boundary = 'top'
  []
  [crucible_y_low]
    type = DirichletBC
    variable = T
    value = 1500 #K
    boundary = 'bottom'
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

[Materials]
  [thermo]
    type = ShomateHeatConductionMaterial
    a = 22.81719
    b = 3.899510e-3
    c = -0.082885e-6
    d = 0.042111e-9
    e = -0.354063e6
    temp = T
    thermal_conductivity = ${k}
  []

  [density]
    type = GenericConstantMaterial
    prop_names = 'density'
    prop_values = ${rho}
  []
[]

[Executioner]
  type = Transient
  end_time = 10
  dt = 1e-1
  solve_type = NEWTON
[]

[Outputs]
  exodus = true
[]
