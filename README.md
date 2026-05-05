# Flight Trajectory Simulator – Cessna Citation C560 XLS

## Overview

This project presents a MATLAB and Simulink-based workflow for **flight performance analysis, trim computation, and validation** of a business jet aircraft, specifically the **Cessna Citation C560 XLS**.

The objective is to simulate and analyze aircraft behavior under different flight conditions by varying key parameters such as:
- Altitude
- Mach number
- Oswald efficiency factor
- Bank angle (φ)

The project combines **aerodynamic modeling, atmospheric physics, and numerical iteration methods** to compute lift, drag, thrust, and dynamic flight variables.

---

## Project Structure
flight-trajectory-simulator-c560-xls/
├── matlab/
│ ├── cl_alpha.m
│ ├── verifica_validazione.m
│ ├── cambio_performance.m
│ ├── simulazione_trimmaggio.m
├── simulink/
│ └── simulatore.slx
├── data/
│ ├── DatiSim/
│ └── ext_nl_CLalfa_XLS.dat
├── docs/
│ └── FLIGHT_TEST_CARD.pdf
├── figures/
│ ├── cl_alpha.png
│ ├── validation_results.png
│ └── trim_conditions.png
├── README.md
└── .gitignore

---

## Workflow

To correctly run the project, follow this sequence:

### 1. Lift Curve Analysis
Run:
cl_alpha.m

- Loads experimental aerodynamic data
- Generates the **Cl vs α (angle of attack)** curve
- Defines valid interpolation range for later computations

---

### 2. Validation & Verification
Run:
verifica_validazione.m

- Evaluates aircraft performance across:
  - Multiple altitudes
  - Different Mach numbers
  - Various Oswald efficiency factors
- Computes:
  - Lift (L)
  - Drag (D)
  - Thrust (T)
  - Velocity rate (v̇)
  - Flight path angle rate (γ̇)
- Outputs:
  - Tables of results
  - Performance plots

---

### 3. Performance Variation (Bank Angle Effect)
Run:
cambio_performance.m

- Same analysis as validation step
- Introduces a **non-zero bank angle (φ ≠ 0)**
- Highlights how asymmetric flight conditions affect:
  - Aerodynamic forces
  - Stability
  - Required thrust

---

### 4. Trim Condition Simulation
Run:
simulazione_trimmaggio.m

- Computes **trim conditions** for steady flight
- Includes:
  - Standard atmosphere model
  - Speed calculation via Mach number
  - Aircraft aerodynamic model
- Outputs:
  - Trim angle of attack
  - Required thrust
  - Control parameters

---

### 5. Simulink Model
Open and run:
simulatore.slx

- Uses trim data as input
- Simulates aircraft dynamic response
- Provides time evolution of flight variables

---

## Flight Test Card

The project includes a **Flight Test Card (FTC-001)** used to define and document the validation process.

### Test Objectives
- Evaluate aircraft performance as a function of:
  - Altitude
  - Mach number
  - Oswald efficiency factor
  - Bank angle (φ)

### Measured Parameters
- Lift (L)
- Drag (D)
- Thrust (T)
- Velocity rate (v̇)
- Flight path angle rate (γ̇)
- Angle of attack (α)

This structured approach mirrors real-world **flight testing procedures** used in aerospace engineering.

---

## Results

The simulations show that:

- The **Oswald efficiency factor (e)** strongly influences aerodynamic efficiency:
  - Higher e → lower induced drag → improved performance
- Increasing Mach number:
  - Slightly increases lift
  - Significantly increases drag
- At higher altitudes:
  - Lift decreases due to reduced air density
- When **φ ≠ 0 (banked flight)**:
  - Aerodynamic forces increase
  - Additional thrust is required
- Under trim conditions:
  - Velocity and flight path angle rates approach zero (steady flight)

---

## Assumptions and Limitations

This model is based on several simplifying assumptions:

- Ideal jet propulsion system
- Constant fuel consumption
- Linear temperature gradient (ISA approximation)
- Two-dimensional aerodynamic model
- Rigid aircraft structure
- No unsteady aerodynamic effects

These assumptions make the model suitable for **educational and preliminary analysis**, but not for high-fidelity flight simulation.

---

## Technologies Used

- MATLAB
- Simulink
- Numerical methods (iterative solvers)
- Aerodynamic interpolation
- Standard atmosphere modeling

---

## How to Run

1. Open MATLAB
2. Set the project root as working directory
3. Run scripts in order:
   - `cl_alpha.m`
   - `verifica_validazione.m`
   - `cambio_performance.m`
   - `simulazione_trimmaggio.m`
4. Open and run the Simulink model

---

## Author

Simone Muscolino  
Aerospace Engineering Student  

---

## Notes

This project was developed as part of an aerospace simulation and flight dynamics study.  
It aims to demonstrate a structured approach to **flight performance analysis and validation using MATLAB and Simulink**.
