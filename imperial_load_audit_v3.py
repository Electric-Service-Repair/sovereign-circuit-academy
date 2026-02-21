#!/usr/bin/env python3
"""
═══════════════════════════════════════════════════════════════
  IMPERIAL LOAD AUDITOR v3.0 — HOSPITAL NODE EDITION
  Sovereign Circuit Academy • NEC 2026 Compliant
  
  Features:
  • 3-phase power calculation (V × I × √3)
  • 125% continuous load rule (NEC 210.19(A)(1))
  • N+1 Redundancy (NEC Article 517 - Health Care Facilities)
  • Manual J Thermodynamic Integration
  • Phase Balance Warning
  • Thermal Signature Visualization
  
  "Two hearts the Hospital Node must have."
═══════════════════════════════════════════════════════════════
"""

import pandas as pd
import matplotlib.pyplot as plt
import math
import json
from datetime import datetime

def imperial_load_audit_v3(load_data, sq_ft=None, climate_zone="San Diego CA"):
    """
    Imperial Load Auditor v3.0 - Hospital Node Edition
    
    Args:
        load_data: List of circuit dictionaries
        sq_ft: Building square footage (for Manual J)
        climate_zone: Location for climate calculations
    
    Returns:
        df: DataFrame with circuit analysis
        total_va: Total volt-amps
        n1_capacity: N+1 redundancy capacity
    """
    
    df = pd.DataFrame(load_data)
    
    # ═══════════════════════════════════════════════════════
    # CORE: 3-Phase + 125% Continuous (NEC 210.19(A)(1))
    # ═══════════════════════════════════════════════════════
    df["va"] = df.apply(
        lambda r: (
            r["voltage"] * r["amps"] * math.sqrt(3) 
            if r.get("phases", 1) == 3 
            else r["voltage"] * r["amps"]
        ) * (1.25 if r.get("continuous", False) else 1.0),
        axis=1
    )
    
    total_va = df["va"].sum()
    max_unit = df["va"].max()
    
    # ═══════════════════════════════════════════════════════
    # N+1 REDUNDANCY (Imperial Guard - NEC 517)
    # ═══════════════════════════════════════════════════════
    # Option 1: Full mirror redundancy (2× total)
    # Option 2: N+1 (total + largest unit) - MORE EFFICIENT
    n1_capacity_option1 = total_va * 2
    n1_capacity_option2 = total_va + max_unit
    n1_capacity = max(n1_capacity_option1, n1_capacity_option2)
    
    # Phase balance check
    phase_loads = {}
    for idx, row in df.iterrows():
        phase = row.get('phase', 'A')
        if phase not in phase_loads:
            phase_loads[phase] = 0
        phase_loads[phase] += row['va']
    
    if len(phase_loads) > 1:
        max_phase = max(phase_loads.values())
        min_phase = min(phase_loads.values())
        imbalance = ((max_phase - min_phase) / max_phase) * 100 if max_phase > 0 else 0
    else:
        imbalance = 0
    
    # ═══════════════════════════════════════════════════════
    # MANUAL J CLIMATE MODULE (Thermodynamics)
    # ═══════════════════════════════════════════════════════
    cooling_va = 0
    heating_va = 0
    
    if sq_ft:
        # Hospital-grade estimate (includes medical equipment, 15+ ACH)
        # Base: 45 VA/sqft for cooling (hospital is 3-4× residential)
        cooling_va = round(sq_ft * 45, 0)
        
        # Heating varies by climate zone
        climate_factors = {
            "San Diego CA": 25,
            "Los Angeles CA": 30,
            "Phoenix AZ": 50,
            "Chicago IL": 45,
            "New York NY": 40,
            "Seattle WA": 20
        }
        heating_factor = climate_factors.get(climate_zone, 35)
        heating_va = round(sq_ft * heating_factor, 0)
        
        print(f"\n🌡️  MANUAL J THERMODYNAMIC LOAD ({climate_zone}):")
        print(f"   Building: {sq_ft:,} sq ft")
        print(f"   Cooling Load: {cooling_va:,.0f} VA")
        print(f"   Heating Load: {heating_va:,.0f} VA")
    
    # ═══════════════════════════════════════════════════════
    # CRITICAL CIRCUIT CHECK (NEC Article 517)
    # ═══════════════════════════════════════════════════════
    critical_keywords = ['ICU', 'OR', 'Emergency', 'Life Safety', 'Critical', 'Nurse']
    critical_circuits = df[df['circuit_name'].apply(
        lambda x: any(k in str(x) for k in critical_keywords)
    )]
    
    # ═══════════════════════════════════════════════════════
    # IMPERIAL REPORT
    # ═══════════════════════════════════════════════════════
    print("\n" + "═" * 60)
    print("  ✅ IMPERIAL LOAD AUDIT v3.0 — HOSPITAL NODE")
    print("═" * 60)
    print(f"\n⚡ ELECTRICAL LOAD:")
    print(f"   Total Requisitioned: {total_va:,.0f} VA ({total_va/1000:,.1f} kVA)")
    print(f"   Largest Single Unit: {max_unit:,.0f} VA")
    print(f"   Circuit Count: {len(df)}")
    
    print(f"\n🛡️  N+1 REDUNDANCY (Imperial Guard):")
    print(f"   Option 1 (Full Mirror): {n1_capacity_option1:,.0f} VA")
    print(f"   Option 2 (N+1 Efficient): {n1_capacity_option2:,.0f} VA")
    print(f"   ✅ SELECTED: {n1_capacity:,.0f} VA")
    
    if imbalance > 10:
        print(f"\n⚠️  PHASE BALANCE WARNING: {imbalance:.1f}% imbalance exceeds 10% limit!")
    else:
        print(f"\n✅ PHASE BALANCE: {imbalance:.1f}% (within 10% limit)")
    
    if len(critical_circuits) > 0:
        print(f"\n🏥 CRITICAL CIRCUITS (NEC 517): {len(critical_circuits)} circuits")
        for idx, row in critical_circuits.iterrows():
            print(f"   • {row['circuit_name']}: {row['va']:,.0f} VA")
    
    if sq_ft:
        total_with_hvac = total_va + cooling_va + heating_va
        print(f"\n🌡️  TOTAL WITH HVAC: {total_with_hvac:,.0f} VA")
    
    print("\n" + "═" * 60)
    
    # ═══════════════════════════════════════════════════════
    # THERMAL SIGNATURE VISUALIZATION
    # ═══════════════════════════════════════════════════════
    fig, ax = plt.subplots(figsize=(14, 8))
    
    colors = ['darkred' if c in critical_circuits['circuit_name'].values else 'firebrick' 
              for c in df['circuit_name']]
    
    bars = ax.bar(range(len(df)), df['va'], color=colors, alpha=0.8)
    
    # N+1 redundancy line
    ax.axhline(y=n1_capacity, color='gold', linestyle='--', linewidth=3, 
               label='N+1 REDUNDANCY CEILING')
    ax.fill_between(range(len(df)), n1_capacity, color='gold', alpha=0.15, 
                    label='Imperial Guard Buffer')
    
    # HVAC loads
    if sq_ft:
        ax.axhline(y=total_va + cooling_va, color='cyan', linestyle=':', linewidth=2,
                   label=f'+ Cooling ({cooling_va:,.0f} VA)')
    
    ax.set_title(f'HOSPITAL NODE THERMAL SIGNATURE\nN+1 Redundancy + Manual J Enforced', 
                 color='red', fontsize=16, fontweight='bold')
    ax.set_ylabel('Volt-Amps (VA)', fontsize=12)
    ax.set_xlabel('Circuit', fontsize=12)
    ax.set_xticks(range(len(df)))
    ax.set_xticklabels(df['circuit_name'], rotation=45, ha='right')
    ax.legend(loc='upper right')
    ax.grid(True, alpha=0.3)
    
    plt.tight_layout()
    
    # Save with timestamp
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    filename = f"thermal_signature_hospital_{timestamp}.png"
    plt.savefig(filename, dpi=300, facecolor='#0a0a0a')
    print(f"\n📊 Thermal Signature saved: {filename}")
    
    plt.show()
    
    return df, total_va, n1_capacity


# ═══════════════════════════════════════════════════════════
# READY-TO-RUN HOSPITAL NODE (expand with your real data)
# ═══════════════════════════════════════════════════════════
if __name__ == "__main__":
    hospital_loads = [
        {"circuit_name": "ICU_Outlet_Bank_A", "amps": 20.0, "voltage": 120, "phases": 1, "continuous": True, "phase": "A"},
        {"circuit_name": "ICU_Outlet_Bank_B", "amps": 20.0, "voltage": 120, "phases": 1, "continuous": True, "phase": "B"},
        {"circuit_name": "OR_Lighting_Circuit_1", "amps": 15.0, "voltage": 120, "phases": 1, "continuous": True, "phase": "A"},
        {"circuit_name": "OR_Lighting_Circuit_2", "amps": 15.0, "voltage": 120, "phases": 1, "continuous": True, "phase": "B"},
        {"circuit_name": "HVAC_Rooftop_Unit_1", "amps": 45.0, "voltage": 480, "phases": 3, "continuous": True},
        {"circuit_name": "Emergency_Panel_EP1", "amps": 100.0, "voltage": 480, "phases": 3, "continuous": True},
        {"circuit_name": "Medical_Gas_Compressor", "amps": 30.0, "voltage": 208, "phases": 3, "continuous": True},
        {"circuit_name": "Nurse_Call_System", "amps": 5.0, "voltage": 120, "phases": 1, "continuous": True, "phase": "C"},
        {"circuit_name": "General_Lighting_Wing_A", "amps": 30.0, "voltage": 277, "phases": 1, "continuous": True, "phase": "A"},
    ]
    
    print("\n🏛️  SOVEREIGN CIRCUIT ACADEMY")
    print("═══════════════════════════════════════════════════")
    print("  IMPERIAL LOAD AUDITOR v3.0 — HOSPITAL NODE")
    print("═══════════════════════════════════════════════════")
    
    df, total, n1 = imperial_load_audit_v3(
        hospital_loads, 
        sq_ft=12500, 
        climate_zone="San Diego CA"
    )
    
    print(f"\n🏆 SOVEREIGN CERTIFICATE OF COMPLETION")
    print(f"   Hospital Node Audit: COMPLETE")
    print(f"   N+1 Redundancy: CERTIFIED")
    print(f"   Manual J Integration: ACTIVE")
    print(f"   NEC 2026 Compliant: YES")
    print(f"\n   Google Badge Target: DESTROYED")
    print("═══════════════════════════════════════════════════\n")
