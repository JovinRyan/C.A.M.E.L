#include "ShomateHeatConductionMaterial.h"

registerMooseObject("CAMELApp", ShomateHeatConductionMaterial);

InputParameters
ShomateHeatConductionMaterial::validParams()
{
  InputParameters params = Material::validParams();
  params.addCoupledVar("temp", "Coupled Temperature");
  params.addRequiredParam<Real>("a", "Shomate equation constant A");
  params.addRequiredParam<Real>("b", "Shomate equation constant B");
  params.addRequiredParam<Real>("c", "Shomate equation constant C");
  params.addRequiredParam<Real>("d", "Shomate equation constant D");
  params.addRequiredParam<Real>("e", "Shomate equation constant E");
  params.addRequiredParam<Real>("thermal_conductivity", "The thermal conductivity value");

  params.addClassDescription("Material model for variable heat capacity using Shomate equation.");
  return params;
}

ShomateHeatConductionMaterial::ShomateHeatConductionMaterial(const InputParameters & parameters)
  : Material(parameters),
    _has_temp(isCoupled("temp")),
    _T(coupledValue("temp")),
    _a(getParam<Real>("a")),
    _b(getParam<Real>("b")),
    _c(getParam<Real>("c")),
    _d(getParam<Real>("d")),
    _e(getParam<Real>("e")),

    _my_thermal_conductivity(getParam<Real>("thermal_conductivity")),

    _specific_heat(declareProperty<Real>("specific_heat")),

    _thermal_conductivity_dT(declareProperty<Real>("thermal_conductivity_dT")),
    _thermal_conductivity(declareProperty<Real>("thermal_conductivity"))
{
}

void
ShomateHeatConductionMaterial::computeQpProperties()
{
  _specific_heat[_qp] = _a + _b * _T[_qp] + _c * _T[_qp] * _T[_qp] + _d * _T[_qp] * _T[_qp] +
                        _e * 1 / (_T[_qp] * _T[_qp]);
  _thermal_conductivity[_qp] = _my_thermal_conductivity;
  _thermal_conductivity_dT[_qp] = 0.0;
}
