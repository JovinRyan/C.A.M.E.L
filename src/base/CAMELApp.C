#include "CAMELApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
CAMELApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

CAMELApp::CAMELApp(InputParameters parameters) : MooseApp(parameters)
{
  CAMELApp::registerAll(_factory, _action_factory, _syntax);
}

CAMELApp::~CAMELApp() {}

void
CAMELApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<CAMELApp>(f, af, s);
  Registry::registerObjectsTo(f, {"CAMELApp"});
  Registry::registerActionsTo(af, {"CAMELApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
CAMELApp::registerApps()
{
  registerApp(CAMELApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
CAMELApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  CAMELApp::registerAll(f, af, s);
}
extern "C" void
CAMELApp__registerApps()
{
  CAMELApp::registerApps();
}
