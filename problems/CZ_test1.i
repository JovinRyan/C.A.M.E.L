[Mesh]
  [gmg]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 25
    ny = 25
    xmax = 25 # m -> nm
    ymax = 25 # m -> nm
    elem_type = QUAD4
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
    []
  []
[]

[Materials]
  [Si]
    type = GBEvolution
    T = 300 #K
    GBenergy = ''
    wGB = ''
  []
[]

[Executioner]
  type = Transient
[]
