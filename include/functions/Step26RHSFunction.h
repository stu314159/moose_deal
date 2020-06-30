#pragma once
#include "Function.h"

class Step26RHSFunction : public Function
{
  public:
    static InputParameters validParams();
    Step26RHSFunction(const InputParameters & parameters);
    
    virtual Real value(Real t, const Point & p) const override;
    
  protected:
  
  Real _period;

};
