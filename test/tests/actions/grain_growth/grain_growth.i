[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 30
  ny = 30
  xmax = 400
  ymax = 400
  elem_type = QUAD
[]

[GlobalParams]
  op_num = 2
  var_name_base = gr
[]

[Modules]
  [PhaseField]
    [GrainGrowth]
      variable_mobility = false
    []
  []
[]

[Materials]
  [Copper]
    type = GBEvolution
    T = 500 #K
    wGB = 60 #nm
    GBmob0 = 2.5e-6 #m^2/(Js)
    Q = 0.23 #Migration energy (eV)
    GBenergy = 0.708 #J/m^2
  []
[]

[ICs]
  [PolycrystalICs]
    [BicrystalCircleGrainIC]
      radius = 300
      x = 400
      y = 0
      int_width = 60
    []
  []
[]

[Preconditioning]
  [SMP]
    type = SMP
    full = true
  []
[]

[Postprocessors]
  [gr1area]
    type = ElementIntegralVariablePostprocessor
    variable = gr1
  []
[]

[Executioner]
  type = Transient
  scheme = BDF2
  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'
  solve_type = NEWTON
  l_tol = 1e-04
  l_max_its = 30
  nl_max_its = 20
  nl_rel_tol = 1e-09
  num_steps = 5
  dt = 80
[]

[Outputs]
  exodus = true
[]
