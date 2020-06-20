#include "Step7SolutionFunction.h"

registerMooseObject("MooseDealApp",Step7SolutionFunction);

InputParameters
Step7SolutionFunction::validParams()
{
  auto params = Function::validParams(); // get from parent
  params.addClassDescription("Function object to represent the solution"
                             "for Deal.II step-7 PDE");
  return params;
}

Step7SolutionFunction::Step7SolutionFunction(const InputParameters & parameters) : Function(parameters), 
_center1(-0.5,0.5,0.),
_center2(-0.5,-0.5,0.),
_center3(0.5,-0.5,0.),
_sigma(1./8.)
{}

Real Step7SolutionFunction::value(Real t, const Point &p) const
{
  Real val = 0.;
  Real x_minus_xi_sqr;
  // a really bone-headed way to do this...
  
  std::vector<Point> centers(3);
  centers[0] = _center1; centers[1] = _center2; centers[2] = _center3;
  for(std::vector<Point>::iterator it = centers.begin(); it != centers.end(); ++it)
  {
    x_minus_xi_sqr = (p - *it) * (p - *it);
               
    // + u
    val+= std::exp(-x_minus_xi_sqr/(_sigma * _sigma));
  }
  
 
  return val;
}
