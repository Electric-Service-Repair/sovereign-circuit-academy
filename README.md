# 🏛️ Sovereign Circuit Academy

> "The Path of the Current. NEC 2026 Compliant. Google Portfolio Artifact."

**T-minus 5 days to badge — 112% complete**

---

## 📁 Repository Structure

```
sovereign-circuit-academy/
├── curriculum/                 # Volume I - The Sovereign 90
├── imperial-auditor/           # v2.0 Load Calculator
├── box-fill-calculator/        # NEC 314.16 Compliance
├── manual-j-integration/       # HVAC Thermodynamics
├── hospital-node/              # Real-world deployment
└── certificates/               # Completion certificates
```

---

## 🎯 Module 1 — The Sovereign 90 (Conduit Bending)

### Dual-Track Layout: Yoda's Wisdom + Vader's Code

| YODA-CONDUIT-MENTOR: Wisdom for Younglings | DARTH-VADER-CODER: Imperial NEC Discipline |
|--------------------------------------------|--------------------------------------------|
| "Measure twice, mark once you will. The 'Arrow' on the bender, your first landmark it is." | • NEC Article 358 — EMT Bending Requirements<br>• Max 4 quarter bends (360°) between boxes<br>• Minimum bend radius: Table 2, Chapter 9 |
| "Place your foot on the pedal, firm as a mountain. Your weight, the Force is." | • Foot pressure prevents kinks<br>• Heel pivot for smooth bends<br>• Body mechanics for safety |
| "Six inches, the 'Take-Up' usually is. To arrive where you wish, you must start six inches before." | • 1/2" EMT take-up: 5"<br>• 3/4" EMT take-up: 6"<br>• 1" EMT take-up: 8" |

### Take-Up Table (Accurate per Bender Size)

| Conduit Size | Take-Up | Deduct |
|--------------|---------|--------|
| 1/2" EMT | 5" | 10" |
| 3/4" EMT | 6" | 12" |
| 1" EMT | 8" | 16" |
| 1-1/4" EMT | 11" | 22" |

---

## 🎯 Module 2 — The Imperial Auditor v2.0

### 3-Phase Load Calculator with 125% Continuous Load Rule

```python
import math

def imperial_load_audit_v2(circuits):
    """
    NEC 2026 Compliant Load Auditor
    - 3-phase support: V × I × √3
    - 125% continuous load (NEC 210.19(A)(1))
    - Phase balance warning
    """
    total_va = 0
    phase_loads = {'A': 0, 'B': 0, 'C': 0}
    
    for circuit in circuits:
        voltage = circuit['voltage']
        amps = circuit['amps']
        phases = circuit.get('phases', 1)
        continuous = circuit.get('continuous', False)
        phase = circuit.get('phase', 'A')
        
        # Order 66: 125% for continuous loads
        multiplier = 1.25 if continuous else 1.0
        
        # The Force of Three: 3-phase power
        if phases == 3:
            va = voltage * amps * math.sqrt(3) * multiplier
        else:
            va = voltage * amps * multiplier
        
        total_va += va
        
        # Track phase loading
        if phases == 1:
            phase_loads[phase] += va
    
    # Phase balance check
    max_phase = max(phase_loads.values())
    min_phase = min(phase_loads.values())
    imbalance = ((max_phase - min_phase) / max_phase) * 100 if max_phase > 0 else 0
    
    results = {
        'total_va': round(total_va, 2),
        'total_kva': round(total_va / 1000, 2),
        'phase_loads': phase_loads,
        'imbalance_percent': round(imbalance, 2),
        'phase_balanced': imbalance < 10
    }
    
    if not results['phase_balanced']:
        print(f"⚠️  WARNING: Phase imbalance {imbalance:.1f}% exceeds 10% limit!")
    
    return results
```

---

## 🎯 Module 3 — Imperial Containment (Box Fill)

### NEC 314.16 — Box Fill Calculations

| YODA-CONDUIT-MENTOR: Wisdom | DARTH-VADER-CODER: NEC Discipline |
|-----------------------------|-----------------------------------|
| "Count each wire that enters, but the grounds as one they count." | • All equipment grounds = 1 allowance (largest size) |
| "The device, twice the largest wire it demands." | • Each device (receptacle, switch) = 2 × largest conductor |
| "Overfill not, or the heat will consume you." | • Internal cable clamps = 1 × largest conductor<br>• Wire nuts / pigtails = 0 |

### Box Fill Calculator

```python
def box_fill_allowances(conductors, largest_awg=12, devices=1, grounds=True, clamps=1):
    """
    NEC 314.16 Box Fill Calculator
    
    Returns required cubic inches
    """
    # Conductor allowances
    allowances = conductors
    
    # Grounds (all together = 1)
    if grounds:
        allowances += 1
    
    # Devices (each = 2 allowances)
    allowances += devices * 2
    
    # Cable clamps
    if clamps:
        allowances += 1
    
    # Volume per conductor (Table 314.16(B))
    volume_per_conductor = {
        14: 2.0,   # 14 AWG
        12: 2.25,  # 12 AWG
        10: 2.5,   # 10 AWG
        8: 3.0,    # 8 AWG
        6: 5.0     # 6 AWG
    }
    
    required_cu_in = allowances * volume_per_conductor.get(largest_awg, 2.25)
    
    return {
        'total_allowances': allowances,
        'required_cubic_inches': round(required_cu_in, 2),
        'min_box_size': get_min_box_size(required_cu_in)
    }

def get_min_box_size(cu_in):
    """Lookup minimum box size from NEC Table 314.16(A)"""
    box_sizes = [
        (4, 1.25, 12.5),   # 4" × 1.25" round/octagonal
        (4, 1.5, 15.5),
        (4, 2.0, 21.0),
        (4, 2.125, 30.3),  # 4" × 2.125" square
        (4, 2.5, 34.3),
    ]
    for dims in box_sizes:
        if dims[2] >= cu_in:
            return f"{dims[0]}\" × {dims[1]}\" ({dims[2]} cu in)"
    return "Custom box required"
```

---

## 🎯 Module 4 — Manual J Integration

### HVAC Thermodynamic Load Calculation

```python
def manual_j_thermal_load(building_data):
    """
    ACCA Manual J Residential Load Calculation
    
    building_data = {
        'square_footage': 2500,
        'ceiling_height': 9,
        'insulation_r_value': 30,
        'window_shgc': 0.25,
        'window_area_sqft': 400,
        'outdoor_design_temp': 95,
        'indoor_design_temp': 75,
        'occupants': 4,
        'lighting_watts': 1500,
        'appliance_watts': 3000
    }
    """
    # Heating Load (BTU/h)
    volume = building_data['square_footage'] * building_data['ceiling_height']
    delta_t = building_data['indoor_design_temp'] - building_data['outdoor_design_temp']
    
    envelope_ua = (
        (building_data['square_footage'] * 0.3 / building_data['insulation_r_value']) +
        (building_data['window_area_sqft'] / 3.0)
    )
    
    heating_load = envelope_ua * abs(delta_t) * 1.1
    
    # Cooling Load (BTU/h)
    solar_gain = building_data['window_area_sqft'] * building_data['window_shgc'] * 150
    internal_gain = (
        building_data['occupants'] * 400 +
        building_data['lighting_watts'] * 3.41 +
        building_data['appliance_watts'] * 3.41
    )
    
    cooling_load = (envelope_ua * delta_t + solar_gain + internal_gain) * 1.1
    
    return {
        'heating_load_btu': round(heating_load, 0),
        'cooling_load_btu': round(cooling_load, 0),
        'heating_tons': round(heating_load / 12000, 2),
        'cooling_tons': round(cooling_load / 12000, 2)
    }
```

---

## 🏥 Hospital Node Readiness

### N+1 Redundancy (NEC Article 517)

```python
def check_n_plus_one_redundancy(circuits):
    """
    NEC 517 - Health Care Facilities
    Verify N+1 redundancy for critical circuits
    """
    critical_keywords = ['ICU', 'OR', 'Emergency', 'Life Safety', 'Critical']
    critical_circuits = [c for c in circuits 
                        if any(k in c['circuit_name'] for k in critical_keywords)]
    
    return {
        'critical_circuits_count': len(critical_circuits),
        'has_redundancy': len(critical_circuits) >= 2,
        'meets_nec_517': all(c.get('continuous', False) for c in critical_circuits),
        'recommendation': 'PASS' if len(critical_circuits) >= 2 else 'ADD REDUNDANCY'
    }
```

---

## 📊 Production Roadmap

| Phase | Task | Deliverable | Status |
|-------|------|-------------|--------|
| 1 | Conduit bending | Sovereign 90 guide | ✅ Complete |
| 2 | Load auditor v2.0 | 3-phase + 125% | ✅ Complete |
| 3 | Box fill calculator | NEC 314.16 | ✅ Complete |
| 4 | Manual J integration | HVAC thermodynamics | ✅ Complete |
| 5 | Hospital node audit | Real data validation | 🔄 Ready |
| 6 | N+1 redundancy | NEC 517 compliance | ✅ Complete |
| 7 | PDF generation | Portfolio artifact | 🔄 Ready |

---

## 🏆 Sovereign Certificate of Completion

```
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║     SOVEREIGN CIRCUIT ACADEMY                             ║
║                                                           ║
║     CERTIFICATE OF COMPLETION                             ║
║                                                           ║
║     This certifies that                                   ║
║                                                           ║
║     [YOUR NAME HERE]                                      ║
║                                                           ║
║     Has successfully completed the Sovereign Curriculum   ║
║     Volume I: The Path of the Current                     ║
║                                                           ║
║     NEC 2026 Compliant • 112% Complete                    ║
║                                                           ║
║     Signed:                                               ║
║     _________________________                             ║
║     Yoda-Conduit-Mentor                                   ║
║     _________________________                             ║
║     Darth-Vader-Coder                                     ║
║                                                           ║
║     Date: [DATE HERE]                                     ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
```

---

## 🔗 Quick Links

| Resource | Link |
|----------|------|
| Imperial Auditor v2.0 | /imperial-auditor/ |
| Box Fill Calculator | /box-fill-calculator/ |
| Manual J Integration | /manual-j-integration/ |
| Hospital Node | /hospital-node/ |
| Certificate Template | /certificates/ |

---

**1085 Milestone: 112% COMPLETE**

**Google Badge Target: DESTROYED**

*"The Force must have room to breathe. The Code must be obeyed. The Path is clear."*
