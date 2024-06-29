//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "CAMELTestApp.h"
#include "CAMELApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
CAMELTestApp::validParams()
{
  InputParameters params = CAMELApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

CAMELTestApp::CAMELTestApp(InputParameters parameters) : MooseApp(parameters)
{
  CAMELTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

CAMELTestApp::~CAMELTestApp() {}

void
CAMELTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  CAMELApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"CAMELTestApp"});
    Registry::registerActionsTo(af, {"CAMELTestApp"});
  }
}

void
CAMELTestApp::registerApps()
{
  registerApp(CAMELApp);
  registerApp(CAMELTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
CAMELTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  CAMELTestApp::registerAll(f, af, s);
}
extern "C" void
CAMELTestApp__registerApps()
{
  CAMELTestApp::registerApps();
}
