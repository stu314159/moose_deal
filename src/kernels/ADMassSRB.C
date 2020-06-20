//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADMassSRB.h"

registerMooseObject("MooseDealApp", ADMassSRB);

InputParameters
ADMassSRB::validParams()
{
  auto params = ADKernelValue::validParams();
  params.addClassDescription("Mass term for general PDE - add coefficient in future");
  return params;
}

ADMassSRB::ADMassSRB(const InputParameters & parameters) : ADKernelValue(parameters) {}

ADReal
ADMassSRB::precomputeQpResidual()
{
 
  return _u[_qp]; // implicitly multiplies by _test[_qp]
}
