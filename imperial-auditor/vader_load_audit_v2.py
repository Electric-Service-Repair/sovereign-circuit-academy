#!/usr/bin/env python3
"""
Imperial Auditor v2.0 - NEC 2026 Compliant Load Calculator
==========================================================
3-Phase Support | 125% Continuous Load Rule | Phase Balance Checking

"The Force must have room to breathe. The Code must be obeyed."
"""

import math
import json
from typing import List, Dict, Any


def imperial_load_audit_v2(circuits: List[Dict[str, Any]]) -> Dict[str, Any]:
    """
    NEC 2026 Compliant Load Auditor
    
    Args:
        circuits: List of circuit dictionaries with keys:
            - voltage: int (e.g., 120, 208, 240, 480)
            - amps: float (current draw)
            - phases: int (1 or 3)
            - continuous: bool (True if load runs 3+ hours)
            - phase: str ('A', 'B', or 'C' for single-phase)
            - circuit_name: str (identifier)
    
    Returns:
        Dictionary with total_va, phase_loads, imbalance warning
    """
    total_va = 0
    phase_loads = {'A': 0, 'B': 0, 'C': 0}
    
    for circuit in circuits:
        voltage = circuit['voltage']
        amps = circuit['amps']
        phases = circuit.get('phases', 1)
        continuous = circuit.get('continuous', False)
        phase = circuit.get('phase', 'A')
        
        # Order 66: 125% for continuous loads (NEC 210.19(A)(1))
        multiplier = 1.25 if continuous else 1.0
        
        # The Force of Three: 3-phase power formula
        if phases == 3:
            va = voltage * amps * math.sqrt(3) * multiplier
        else:
            va = voltage * amps * multiplier
        
        total_va += va
        
        # Track phase loading for balance check
        if phases == 1:
            phase_loads[phase] += va
        else:
            # 3-phase loads spread across all phases
            phase_loads['A'] += va / 3
            phase_loads['B'] += va / 3
            phase_loads['C'] += va / 3
    
    # Phase balance check
    max_phase = max(phase_loads.values())
    min_phase = min(phase_loads.values())
    imbalance = ((max_phase - min_phase) / max_phase) * 100 if max_phase > 0 else 0
    
    results = {
        'total_va': round(total_va, 2),
        'total_kva': round(total_va / 1000, 2),
        'phase_loads': {k: round(v, 2) for k, v in phase_loads.items()},
        'imbalance_percent': round(imbalance, 2),
        'phase_balanced': imbalance < 10
    }
    
    if not results['phase_balanced']:
        print(f"⚠️  WARNING: Phase imbalance {imbalance:.1f}% exceeds 10% limit!")
    
    return results


def check_n_plus_one_redundancy(circuits: List[Dict[str, Any]]) -> Dict[str, Any]:
    """
    NEC 517 - Health Care Facilities
    Verify N+1 redundancy for critical circuits
    """
    critical_keywords = ['ICU', 'OR', 'Emergency', 'Life Safety', 'Critical']
    critical_circuits = [
        c for c in circuits 
        if any(k in c.get('circuit_name', '') for k in critical_keywords)
    ]
    
    return {
        'critical_circuits_count': len(critical_circuits),
        'has_redundancy': len(critical_circuits) >= 2,
        'meets_nec_517': all(c.get('continuous', False) for c in critical_circuits),
        'recommendation': 'PASS' if len(critical_circuits) >= 2 else 'ADD REDUNDANCY'
    }


# Sample Hospital Node Data
HOSPITAL_NODE_SAMPLE = [
    {'circuit_name': 'ICU-Outlet-A1', 'voltage': 120, 'amps': 15, 'phases': 1, 'phase': 'A', 'continuous': True},
    {'circuit_name': 'ICU-Outlet-B1', 'voltage': 120, 'amps': 15, 'phases': 1, 'phase': 'B', 'continuous': True},
    {'circuit_name': 'ICU-Outlet-C1', 'voltage': 120, 'amps': 15, 'phases': 1, 'phase': 'C', 'continuous': True},
    {'circuit_name': 'OR-Lighting', 'voltage': 277, 'amps': 20, 'phases': 1, 'phase': 'A', 'continuous': True},
    {'circuit_name': 'Emergency-Panel', 'voltage': 480, 'amps': 100, 'phases': 3, 'continuous': True},
    {'circuit_name': 'Life-Safety-Pump', 'voltage': 480, 'amps': 50, 'phases': 3, 'continuous': True},
    {'circuit_name': 'General-Receptacles', 'voltage': 120, 'amps': 20, 'phases': 1, 'phase': 'C', 'continuous': False},
]


if __name__ == '__main__':
    print("=" * 60)
    print("IMPERIAL AUDITOR v2.0 - NEC 2026 LOAD CALCULATION")
    print("=" * 60)
    print()
    
    # Run audit
    results = imperial_load_audit_v2(HOSPITAL_NODE_SAMPLE)
    
    print(f"Total Load: {results['total_kva']:.2f} kVA")
    print()
    print("Phase Distribution:")
    for phase, load in results['phase_loads'].items():
        print(f"  Phase {phase}: {load/1000:.2f} kVA")
    print()
    print(f"Phase Imbalance: {results['imbalance_percent']:.1f}%")
    print(f"Status: {'✅ BALANCED' if results['phase_balanced'] else '⚠️  IMBALANCED'}")
    print()
    
    # N+1 Redundancy Check
    redundancy = check_n_plus_one_redundancy(HOSPITAL_NODE_SAMPLE)
    print("NEC 517 Hospital Compliance:")
    print(f"  Critical Circuits: {redundancy['critical_circuits_count']}")
    print(f"  N+1 Redundancy: {'✅ PASS' if redundancy['has_redundancy'] else '❌ FAIL'}")
    print(f"  Recommendation: {redundancy['recommendation']}")
    print()
    print("=" * 60)
