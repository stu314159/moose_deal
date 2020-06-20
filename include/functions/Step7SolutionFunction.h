#pragma once

#include "Function.h"

class Step7SolutionFunction : public Function
{
  public:
    static InputParameters validParams();
    Step7SolutionFunction(const InputParameters & parameters);
    
    virtual Real value(Real t, const Point & p) const override;
    
  protected:
    Point _center1, _center2, _center3;
    Real _sigma;
  
};
    
