#pragma once

#include "Material.h"

/**
 * Material with specific heat capacity defined by Shomate equation.
 * Cp = A + B*t + C*t2 + D*t3 + E/t2
 */
class ShomateHeatConductionMaterial : public Material
{
public:
  static InputParameters validParams();

  ShomateHeatConductionMaterial(const InputParameters & parameters);

protected:
  virtual void computeQpProperties() override;

private:
  const bool _has_temp;
  const Real _a;
  const Real _b;
  const Real _c;
  const Real _d;
  const Real _e;
  const VariableValue & _T;
  const Real _my_thermal_conductivity;

  MaterialProperty<Real> & _thermal_conductivity;
  MaterialProperty<Real> & _thermal_conductivity_dT;

  MaterialProperty<Real> & _specific_heat;
};
