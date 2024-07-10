crucible_r = 0.245 #m
melt_h = 0.16 #m
rho = 2490 #kg m^-3
mu = 7.5e-4 #kg m^-1 s^-1
cp = 1000 #J kg^-1 K^-1
k = 64 #W m^-1 K^-1

velocity_interp_method = 'rc'
advected_interp_method = 'average'

[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = -${crucible_r}
    xmax = ${crucible_r}
    ymin = 0
    ymax = ${melt_h}
    nx = 10
    ny = 10
  []
[]

[GlobalParams]
  rhie_chow_user_object = 'rc'
[]

[UserObjects]
  [rc]
    type = INSFVRhieChowInterpolator
    u = vel_x
    v = vel_y
    pressure = pressure
  []
[]

[Variables]
  [vel_x]
    type = INSFVVelocityVariable
  []

  [vel_y]
    type = INSFVVelocityVariable
  []

  [pressure]
    type = INSFVPressureVariable
  []

  [T_fluid]
    type = INSFVEnergyVariable
  []

  [lambda]
    family = SCALAR
    order = FIRST
  []
[]

[AuxVariables]
  [U]
    order = CONSTANT
    family = MONOMIAL
    fv = true
  []
[]

[AuxKernels]
  [mag]
    type = VectorMagnitudeAux
    variable = U
    x = vel_x
    y = vel_y
  []
[]

[FVKernels]
  [mass]
    type = INSFVMassAdvection
    variable = pressure
    advected_interp_method = ${advected_interp_method}
    velocity_interp_method = ${velocity_interp_method}
    rho = ${rho}
  []
  [mean_zero_pressure]
    type = FVIntegralValueConstraint
    variable = pressure
    lambda = lambda
  []

  [u_advection]
    type = INSFVMomentumAdvection
    variable = vel_x
    velocity_interp_method = ${velocity_interp_method}
    advected_interp_method = ${advected_interp_method}
    rho = ${rho}
    momentum_component = 'x'
  []

  [u_viscosity]
    type = INSFVMomentumDiffusion
    variable = vel_x
    mu = ${mu}
    momentum_component = 'x'
  []

  [u_pressure]
    type = INSFVMomentumPressure
    variable = vel_x
    momentum_component = 'x'
    pressure = pressure
  []

  [v_advection]
    type = INSFVMomentumAdvection
    variable = vel_y
    velocity_interp_method = ${velocity_interp_method}
    advected_interp_method = ${advected_interp_method}
    rho = ${rho}
    momentum_component = 'y'
  []

  [v_viscosity]
    type = INSFVMomentumDiffusion
    variable = vel_y
    mu = ${mu}
    momentum_component = 'y'
  []

  [v_pressure]
    type = INSFVMomentumPressure
    variable = vel_y
    momentum_component = 'y'
    pressure = pressure
  []

  [temp_conduction]
    type = FVDiffusion
    coeff = 'k'
    variable = T_fluid
  []

  [temp_advection]
    type = INSFVEnergyAdvection
    variable = T_fluid
    velocity_interp_method = ${velocity_interp_method}
    advected_interp_method = ${advected_interp_method}
  []
[]

[FVBCs]
  [no_slip_x]
    type = INSFVNoSlipWallBC
    variable = vel_x
    boundary = 'left right bottom top'
    function = 0
  []

  [no_slip_y]
    type = INSFVNoSlipWallBC
    variable = vel_y
    boundary = 'left right top bottom'
    function = 0
  []

  [T_hot]
    type = FVDirichletBC
    variable = T_fluid
    boundary = 'left right bottom'
    value = 1800 #K
  []

  [T_cold]
    type = FVDirichletBC
    variable = T_fluid
    boundary = 'top'
    value = 300 #K
  []
[]

[FunctorMaterials]
  [functor_constants]
    type = ADGenericFunctorMaterial
    prop_names = 'cp k'
    prop_values = '${cp} ${k}'
  []
  [ins_fv]
    type = INSFVEnthalpyFunctorMaterial
    temperature = 'T_fluid'
    rho = ${rho}
  []
[]

[Preconditioning]
  [smp]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
  end_time = 10
[]

[Outputs]
  exodus = true
[]
