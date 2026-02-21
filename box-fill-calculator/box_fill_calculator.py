#!/usr/bin/env python3
"""
Box Fill Calculator - NEC 314.16 Compliance
============================================
"The box must have room to breathe, or the heat will consume you."
"""

from typing import Dict, List, Any


# NEC Table 314.16(B) - Volume allowance per conductor (cubic inches)
VOLUME_PER_CONDUCTOR = {
    14: 2.0,    # 14 AWG
    12: 2.25,   # 12 AWG
    10: 2.5,    # 10 AWG
    8: 3.0,     # 8 AWG
    6: 5.0,     # 6 AWG
    4: 6.0,     # 4 AWG
    3: 7.0,     # 3 AWG
    2: 8.0,     # 2 AWG
}

# NEC Table 314.16(A) - Standard box sizes (dimensions, volume)
STANDARD_BOXES = [
    ('4" × 1.25" round', 12.5),
    ('4" × 1.5" round', 15.5),
    ('4" × 2.0" round', 21.0),
    ('4" × 2.125" square', 30.3),
    ('4" × 2.5" square', 34.3),
    ('4-11/16" × 1.5"', 42.0),
    ('4-11/16" × 2.0"', 54.0),
    ('4-11/16" × 2.125"', 60.0),
]


def box_fill_calculator(
    conductors: int,
    largest_awg: int = 12,
    devices: int = 1,
    grounds: bool = True,
    clamps: bool = True,
    fittings: int = 0
) -> Dict[str, Any]:
    """
    NEC 314.16 Box Fill Calculator
    
    Args:
        conductors: Number of current-carrying conductors entering the box
        largest_awg: Largest conductor gauge (for volume calculation)
        devices: Number of devices (receptacles, switches) - each counts as 2 allowances
        grounds: True if equipment grounding conductors present (counts as 1)
        clamps: True if internal cable clamps present (counts as 1)
        fittings: Number of fixture studs or hickeys
    
    Returns:
        Dictionary with total allowances, required volume, recommended box
    """
    # Calculate total volume allowances
    allowances = conductors
    
    # All equipment grounds together = 1 allowance (largest ground size)
    if grounds:
        allowances += 1
    
    # Each device (receptacle/switch) = 2 allowances based on largest conductor
    allowances += devices * 2
    
    # Internal cable clamps = 1 allowance
    if clamps:
        allowances += 1
    
    # Each fitting (stud, hickey) = 1 allowance
    allowances += fittings
    
    # Calculate required cubic inches
    volume_per_cond = VOLUME_PER_CONDUCTOR.get(largest_awg, 2.25)
    required_cu_in = allowances * volume_per_cond
    
    # Find minimum standard box
    recommended_box = None
    for box_name, volume in STANDARD_BOXES:
        if volume >= required_cu_in:
            recommended_box = box_name
            break
    
    return {
        'total_allowances': allowances,
        'conductor_volume_per_unit': volume_per_cond,
        'required_cubic_inches': round(required_cu_in, 2),
        'recommended_box': recommended_box if recommended_box else 'CUSTOM BOX REQUIRED',
        'compliance': 'NEC 314.16 COMPLIANT' if recommended_box else 'OVERFILLED - VIOLATION'
    }


def print_box_fill_report(results: Dict[str, Any]) -> None:
    """Print formatted box fill report"""
    print()
    print("=" * 50)
    print("BOX FILL CALCULATION - NEC 314.16")
    print("=" * 50)
    print(f"Total Volume Allowances: {results['total_allowances']}")
    print(f"Volume per Conductor: {results['conductor_volume_per_unit']} cu in")
    print(f"Required Volume: {results['required_cubic_inches']} cu in")
    print(f"Recommended Box: {results['recommended_box']}")
    print(f"Status: {results['compliance']}")
    print("=" * 50)


# Example usage
if __name__ == '__main__':
    # Example: 12 AWG circuit with 3 conductors, 1 receptacle, grounds, clamps
    example = box_fill_calculator(
        conductors=3,
        largest_awg=12,
        devices=1,
        grounds=True,
        clamps=True
    )
    print_box_fill_report(example)
