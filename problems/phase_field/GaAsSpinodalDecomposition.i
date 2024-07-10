[Mesh]
  [gmg] #25 nm x 25 nm mesh with 100 x 100 elements
    type = GeneratedMeshGenerator
    dim = 2
    xmax = 25
    ymax = 25
    nx = 100
    ny = 100
  []
[]

[Variables]
  [c] #mol fraction of Ga
    family = LAGRANGE
    order = FIRST
  []

  [w] #chemical potential (ev/mol)
    order = FIRST
    family = LAGRANGE
  []
[]

[ICs]
  [testIC]
    type = BoundingBoxIC
    variable = c
    x1 = 5
    x2 = 20
    y1 = 5
    y2 = 20
    inside = 0
    outside = 0
  []
[]

[BCs]
  [Periodic]
    [c_bcs]
      auto_direction = 'x y'
    []
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
  petsc_options_iname = '-pc_type -ksp_grmres_restart -sub_ksp_type
                         -sub_pc_type -pc_asm_overlap'
  petsc_options_value = 'asm      31                  preonly
                         ilu          1'
  dt = 100
  end_time = 86400
[]
