#!/usr/bin/env python3
"""
Manual J Integration - HVAC Thermodynamic Load Calculation
===========================================================
ACCA Manual J Residential Load Calculation

"The heat must flow. The cold must yield. Balance is the Path."
"""

import math
from typing import Dict, Any


def manual_j_thermal_load(building_data: Dict[str, Any]) -> Dict[str, Any]:
    """
    ACCA Manual J Residential Load Calculation
    
    Args:
        building_data: Dictionary with:
            - square_footage: int
            - ceiling_height: int (feet)
            - insulation_r_value: int
            - window_shgc: float (Solar Heat Gain Coefficient, 0-1)
            - window_area_sqft: int
            - outdoor_design_temp: int (°F)
            - indoor_design_temp: int (°F)
            - occupants: int
            - lighting_watts: int
            - appliance_watts: int
    
    Returns:
        Dictionary with heating/cooling loads in BTU/h and tons
    """
    # Building volume
    volume = building_data['square_footage'] * building_data['ceiling_height']
    
    # Temperature differential
    delta_t = building_data['indoor_design_temp'] - building_data['outdoor_design_temp']
    
    # Envelope UA (U-factor × Area)
    # Simplified: wall area ≈ 0.3 × floor area, window U ≈ 1/3
    envelope_ua = (
        (building_data['square_footage'] * 0.3 / building_data['insulation_r_value']) +
        (building_data['window_area_sqft'] / 3.0)
    )
    
    # Heating Load (BTU/h)
    heating_load = envelope_ua * abs(delta_t) * 1.1
    
    # Cooling Load Components
    # Solar gain through windows (BTU/h)
    solar_gain = building_data['window_area_sqft'] * building_data['window_shgc'] * 150
    
    # Internal gains (people, lights, appliances)
    internal_gain = (
        building_data['occupants'] * 400 +           # 400 BTU/h per person
        building_data['lighting_watts'] * 3.41 +      # 3.41 BTU/h per watt
        building_data['appliance_watts'] * 3.41
    )
    
    # Total cooling load
    cooling_load = (envelope_ua * abs(delta_t) + solar_gain + internal_gain) * 1.1
    
    return {
        'heating_load_btu': round(heating_load, 0),
        'cooling_load_btu': round(cooling_load, 0),
        'heating_tons': round(heating_load / 12000, 2),
        'cooling_tons': round(cooling_load / 12000, 2),
        'heating_kw': round(heating_load / 3412, 2),
        'cooling_kw': round(cooling_load / 3412, 2)
    }


def print_manual_j_report(results: Dict[str, Any]) -> None:
    """Print formatted Manual J report"""
    print()
    print("=" * 50)
    print("MANUAL J THERMAL LOAD CALCULATION")
    print("=" * 50)
    print(f"Heating Load: {results['heating_load_btu']:,.0f} BTU/h ({results['heating_tons']:.2f} tons)")
    print(f"Cooling Load: {results['cooling_load_btu']:,.0f} BTU/h ({results['cooling_tons']:.2f} tons)")
    print(f"Heating: {results['heating_kw']:.2f} kW")
    print(f"Cooling: {results['cooling_kw']:.2f} kW")
    print("=" * 50)


# Example: 2,500 sq ft home
EXAMPLE_HOME = {
    'square_footage': 2500,
    'ceiling_height': 9,
    'insulation_r_value': 30,
    'window_shgc': 0.25,
    'window_area_sqft': 400,
    'outdoor_design_temp': 95,
    'indoor_design_temp': 75,
    'occupants': 4,
    'lighting_watts': 1500,
    'appliance_watts': 3000,
}


if __name__ == '__main__':
    results = manual_j_thermal_load(EXAMPLE_HOME)
    print_manual_j_report(results)
