#include "MooseDealApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
MooseDealApp::validParams()
{
  InputParameters params = MooseApp::validParams();

  // Do not use legacy DirichletBC, that is, set DirichletBC default for preset = true
  params.set<bool>("use_legacy_dirichlet_bc") = false;

  return params;
}

MooseDealApp::MooseDealApp(InputParameters parameters) : MooseApp(parameters)
{
  MooseDealApp::registerAll(_factory, _action_factory, _syntax);
}

MooseDealApp::~MooseDealApp() {}

void
MooseDealApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAll(f, af, s);
  Registry::registerObjectsTo(f, {"MooseDealApp"});
  Registry::registerActionsTo(af, {"MooseDealApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
MooseDealApp::registerApps()
{
  registerApp(MooseDealApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
MooseDealApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  MooseDealApp::registerAll(f, af, s);
}
extern "C" void
MooseDealApp__registerApps()
{
  MooseDealApp::registerApps();
}
