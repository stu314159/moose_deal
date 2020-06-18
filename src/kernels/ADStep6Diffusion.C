//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADStep6Diffusion.h"

registerMooseObject("MooseDealApp", ADStep6Diffusion);

InputParameters
ADStep6Diffusion::validParams()
{
  auto params = ADKernelGrad::validParams();
  params.addClassDescription("Same as `Diffusion` in terms of physics/residual, but the Jacobian "
                             "is computed using forward automatic differentiation"
                             "and there is a very discontinuous non-constant coefficient to the"
                             "laplace operator; see Step-6 deal.II");
  return params;
}

ADStep6Diffusion::ADStep6Diffusion(const InputParameters & parameters) : ADKernelGrad(parameters) {}

ADRealVectorValue
ADStep6Diffusion::precomputeQpResidual()
{
  // start simple; hard-code in the function for a
  ADReal x = _q_point[_qp](0);
  ADReal y = _q_point[_qp](1);
 
  ADReal r = std::sqrt(x*x+y*y);
  ADReal a = 1.;
  if (r <= 0.5)
  {
    a = 20.;
  };
  
  if ((x < 0) && (y < 0))
   a = 1;
  else if ((x >=0) && (y < 0))
   a = 10;
  else if ((x < 0) && (y >= 0))
   a = 100;
  else if ((x >= 0) && (y >= 0))
   a = 1000;
  
  return _grad_u[_qp]*a;
}
