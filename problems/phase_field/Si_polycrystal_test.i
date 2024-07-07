[Mesh]
  type = GeneratedMesh
  dim = 2
  elem_type = QUAD4
  nx = 25
  ny = 25
  xmax = 25
  ymax = 25
  uniform_refine = 2
[]

[GlobalParams]
  op_num = 5
  var_name_base = 'gr'
[]

[UserObjects]
  [voronoi]
    type = PolycrystalVoronoi
    grain_num = 5
    rand_seed = 11
    coloring_algorithm = BT
  []
[]

[ICs]
  [PolycrystalICs]
    [PolycrystalColoringIC]
      polycrystal_ic_uo = voronoi
    []
  []
[]

[Variables]
  [PolycrystalVariables]
  []
[]

[AuxVariables]
  [bnds]
  []
[]

[Kernels]
  [PolycrystalKernel]
  []
[]

[AuxKernels]
  [bnds_aux]
    type = BndsCalcAux
    variable = bnds
    execute_on = 'TIMESTEP_END'
  []
[]

[BCs]
  [Periodic]
    [top_bottom]
      auto_direction = 'x y'
    []
  []
[]

[Materials]
  [SiGrGr]
    type = GBEvolution
    T = 1000 #K
    GBenergy = 4.1977 #J m^-2
    wGB = 1.235 #nm
    GBmob0 = 3.9349e-1
  []
[]

[Executioner]
  type = Transient # Type of executioner, here it is transient with an adaptive time step
  scheme = bdf2 # Type of time integration (2nd order backward euler), defaults to 1st order backward euler

  #Preconditioned JFNK (default)
  solve_type = 'NEWTON'

  petsc_options_iname = '-pc_type -pc_hypre_type -ksp_gmres_restart -mat_mffd_type'
  petsc_options_value = 'hypre    boomeramg      101                ds'

  l_max_its = 30 # Max number of linear iterations
  l_tol = 1e-4 # Relative tolerance for linear solves
  nl_max_its = 40 # Max number of nonlinear iterations
  nl_abs_tol = 1e-11 # Relative tolerance for nonlienar solves
  nl_rel_tol = 1e-10 # Absolute tolerance for nonlienar solves

  [TimeStepper]
    type = SolutionTimeAdaptiveDT
    dt = 1 # Initial time step.  In this simulation it changes.
  []

  start_time = 0.0
  end_time = 100
[]

[Adaptivity]
  marker = errorfrac
  max_h_level = 4
  [Indicators]
    [error]
      type = GradientJumpIndicator
      variable = bnds
    []
  []
  [Markers]
    [bound_adapt]
      type = ValueThresholdMarker
      third_state = DO_NOTHING
      coarsen = 1.0
      refine = 0.99
      variable = bnds
      invert = true
    []
    [errorfrac]
      type = ErrorFractionMarker
      coarsen = 0.1
      indicator = error
      refine = 0.7
    []
  []
[]

[Outputs]
  exodus = true
  csv = true
  [console]
    type = Console
    max_rows = 20
  []
[]
