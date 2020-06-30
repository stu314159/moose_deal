#include "Step26RHSFunction.h"

registerMooseObject("MooseDealApp",Step26RHSFunction);

InputParameters
Step26RHSFunction::validParams()
{
  auto params = Function::validParams();
  params.addClassDescription("Function object to represent the RHS for Deal.II"
                             "step-26 PDE");
  params.addParam<Real>("period",0.2,"Period of Transient Source Term");
                             
  return params;
}

Step26RHSFunction::Step26RHSFunction(const InputParameters & parameters) : Function(parameters),
_period(getParam<Real>("period"))
{}

Real Step26RHSFunction::value(Real t, const Point &p) const
{
    
  Real point_within_period = (t/_period - std::floor(t/_period));
  if ((point_within_period >= 0.0) && (point_within_period <= 0.2))
  {
    if((p(0)>0.5) && (p(1) > -0.5))
      return 1;
    else
      return 0;
  }
  else if((point_within_period >= 0.5) && (point_within_period <= 0.7))
  {
    if ((p(0) > -0.5) && (p(1) > 0.5))
      return 1;
    else
      return 0;
  }
  else
    return 0; 
   
}
