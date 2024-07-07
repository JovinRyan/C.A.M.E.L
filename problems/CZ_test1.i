[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 30
    ny = 30
    xmax = 40
    ymax = 40
    elem_type = QUAD
  []
[]

[GlobalParams]
  op_num = 2
  var_name_base = gr
[]

[Modules]
  [PhaseField]
    [GrainGrowth]
      variable_mobility = true
      coupled_variables = T
    []
  []
[]

[AuxVariables]
  [T]
  []
[]

[AuxKernels]
  [T]
    type = FunctionAux
    variable = T
    function = 1683-10e10*t
  []
[]

[Materials]
  [Temp_func]
    type = GenericFunctionMaterial
    prop_names = 'T'
    prop_values = '1683-10*t'
  []
  [Si_GB] #All parameters are for crystal orientation [100]
    type = GBEvolution
    GBenergy = 4.1977 #J m^-2
    wGB = 1.235 #nm
    GBmob0 = 3.9349e-1 #m^3 (Js)^-1
    T = T
  []
[]

[BCs]
  [Periodic] #Periodic BCs is usually used for phase field models
    [c_bc]
      auto_direction = 'x y'
    []
  []
[]

[ICs]
  [PolycrystalICs]
    [BicrystalCircleGrainIC]
      radius = 5
      x = 12.5
      y = 12.5
      int_width = 1.235
    []
  []
[]

[Preconditioning]
  [SMP]
    type = SMP
  []
[]

[Postprocessors]
  [gr1area]
    type = ElementIntegralVariablePostprocessor
    variable = gr1
  []
  [Temp]
    type = AverageNodalVariableValue
    variable = T
  []
[]

[Executioner]
  type = Transient
  scheme = BDF2
  solve_type = NEWTON
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  l_tol = 1e-04
  l_max_its = 30
  nl_max_its = 20
  nl_rel_tol = 1e-09
  num_steps = 100
  dt = 1e-10
  end_time = 1e-8
[]

[Outputs]
  exodus = true
[]
