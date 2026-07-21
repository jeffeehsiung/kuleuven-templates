
---

# EUSIPCO 2026 Poster Design

Based on your accepted paper, I'll create a comprehensive poster design. Here's the structure and content organized for a clear, visually appealing academic poster.

---

## POSTER DESIGN - EUSIPCO 2026

### LAYOUT STRUCTURE (Landscape A0: 1189mm × 841mm)

```
┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                                             │
│    ██████████████████████████████████████████████████████████████████████████████████████████████████████    │
│    ██  Few-Shot Radar Person Identification via Tracking-Integrated InISAR and Pre-Trained Meta-Learning ██    │
│    ██████████████████████████████████████████████████████████████████████████████████████████████████████    │
│    ██  Jeffee Hsiung* (KU Leuven) | Rengin Torun* (KU Leuven) | S. Hamed Javadi† (imec) | Hichem Sahli†     ██    │
│    ██  *Equal contribution (first authors)  †Equal contribution (supervisors)                                ██    │
│    ██████████████████████████████████████████████████████████████████████████████████████████████████████    │
│                                                                                                             │
│  ┌─────────────────────┐  ┌─────────────────────────────────────┐  ┌──────────────────────────────────────┐  │
│  │   INTRODUCTION      │  │   3D POINT CLOUD GENERATION        │  │   FEW-SHOT PERSON IDENTIFICATION     │  │
│  │                     │  │   (InISAR Pipeline)                 │  │   (PCTtrans + MAML)                  │  │
│  │  • Privacy-preserving│  │                                     │  │                                     │  │
│  │    alternative to    │  │  ┌─────────────────────────┐      │  │  ┌───────────────────────────────┐  │  │
│  │    vision systems   │  │  │ Range-Doppler Processing │      │  │  │ Input: Radar Sequence S = {P_t}│  │  │
│  │  • Challenges:       │  │  │ (2D FFT on FMCW signal) │      │  │  │ T=10 frames, P_t ∈ R^{1000×5}  │  │  │
│  │    - Sparse/noisy    │  │  └────────────┬────────────┘      │  │  └───────────────┬───────────────┘  │  │
│  │      point clouds    │  │               ▼                    │  │                  ▼                   │  │
│  │    - Data scarcity   │  │  ┌─────────────────────────┐      │  │  ┌───────────────────────────────┐  │  │
│  │                     │  │  │ Motion Compensation      │      │  │  │     DBSCAN + Filtering         │  │  │
│  │  • Our Solution:     │  │  │ (ICBA Autofocusing)     │      │  │  │  Remove ghosts & near-field    │  │  │
│  │    InISAR +          │  │  │ [β,γ]=argmax contrast   │      │  │  └───────────────┬───────────────┘  │  │
│  │    Pre-trained MAML  │  │  └────────────┬────────────┘      │  │                  ▼                   │  │
│  └─────────────────────┘  │               ▼                    │  │  ┌───────────────────────────────┐  │  │
│                           │  ┌─────────────────────────┐      │  │  │   Frame-wise PCT Encoder       │  │  │
│  ┌─────────────────────┐  │  │ CFAR Segmentation       │      │  │  │   (Neighbor Embedding +        │  │  │
│  │   KEY RESULTS       │  │  │ (SOCA-CFAR, P_FA=1e-10)│      │  │  │    Offset-Attention)           │  │  │
│  │                     │  │  └────────────┬────────────┘      │  │  │   f_t ∈ R^{192}                │  │  │
│  │  • 98.99% accuracy  │  │               ▼                    │  │  └───────────────┬───────────────┘  │  │
│  │    (supervised)     │  │  ┌─────────────────────────┐      │  │                  ▼                   │  │
│  │  • 70.0% cross-     │  │  │ Interferometry (3D)     │      │  │  ┌───────────────────────────────┐  │  │
│  │    session few-shot │  │  │ h = λφR / (2πL)         │      │  │  │   Temporal Transformer         │  │  │
│  │  • +15.6pp from     │  │  │ x = R cosθ_el sinθ_az   │      │  │  │   (Multi-head Self-Attention)  │  │  │
│  │    pre-trained init │  │  │ y = R cosθ_el cosθ_az   │      │  │  │   g = Pool([h_1,...,h_T])      │  │  │
│  │  • 73.78% IoU       │  │  │ z = R sinθ_el           │      │  │  └───────────────┬───────────────┘  │  │
│  │  • <5.5 cm height   │  │  └────────────┬────────────┘      │  │                  ▼                   │  │
│  │    error            │  │               ▼                    │  │  ┌───────────────────────────────┐  │  │
│  └─────────────────────┘  │  ┌─────────────────────────┐      │  │  │   Classification FC Layers    │  │  │
│                           │  │ EKF-JPDA Tracking       │      │  │  │   p(y|S)=Softmax(W_2·ReLU(...))│  │  │
│  ┌─────────────────────┐  │  │ (3D spatial domain)     │      │  │  └───────────────────────────────┘  │  │
│  │   PRE-TRAINED MAML  │  │  └─────────────────────────┘      │  │                                     │  │
│  │                     │  │                                     │  │  ┌───────────────────────────────┐  │  │
│  │  Phase 1:           │  │  ┌─────────────────────────┐      │  │  │   MAML Framework               │  │  │
│  │  Supervised training│  │  │ Validation: 73.78% IoU  │      │  │  │   Inner Loop: θ_i' = θ - α∇L   │  │  │
│  │  on representative  │  │  │ <5.5 cm height error    │      │  │  │   Outer Loop: θ ← θ - β∇L     │  │  │
│  │  task (3 subjects)  │  │  └─────────────────────────┘      │  │  └───────────────────────────────┘  │  │
│  │                     │  │                                     │  │                                     │  │
│  │  Phase 2:           │  │  Figure: Tracking Comparison       │  │  Figure: PCTtrans Architecture      │  │
│  │  Meta-train MAML    │  │  [DBSCAN vs. EKF-JPDA]             │  │  [Spatial + Temporal Processing]    │  │
│  │  with θ_0^PT        │  │                                     │  │                                     │  │
│  └─────────────────────┘  └─────────────────────────────────────┘  └──────────────────────────────────────┘  │
│                                                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────────────────────────────────────┐  │
│  │  RESULTS TABLE                  │  FIGURES:                                                          │  │
│  │  ┌─────────────────────────────┐│  ┌─────────────┐  ┌─────────────────┐                            │  │
│  │  │ Query  │ Supervised │ MAML  ││  │ InISAR vs   │  │ Accuracy vs     │                            │  │
│  │  │ Q1     │ 98.99%     │ 90.0% ││  │ MoCap       │  │ Episodes        │                            │  │
│  │  │ Q2     │ 32.05%     │ 70.0% ││  │ (IoU 73.78%)│  │ (Pre-trained vs │                            │  │
│  │  │ Q3     │ 31.67%     │ 47.78%││  └─────────────┘  │  Random Init)   │                            │  │
│  │  └─────────────────────────────┘│                    └─────────────────┘                            │  │
│  └───────────────────────────────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                                             │
│  ┌───────────────────────────────────────────────────────────────────────────────────────────────────────┐  │
│  │  CONCLUSION: Practical few-shot radar PID with minimal training data (3 subjects, 10 shots each)     │  │
│  │  Next Steps: Larger populations, adaptive tracking for high-acceleration scenarios                   │  │
│  └───────────────────────────────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                                             │
└─────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
```

---

## DETAILED CONTENT FOR EACH SECTION

### 1. INTRODUCTION

**Header:** INTRODUCTION

**Key Points:**
- **Challenge:** Radar-based person identification (PID) faces two critical hurdles:
  - Poor point cloud quality (sparse, noisy, multipath ghosts)
  - Data scarcity (requires >100 sequences per person)

- **Our Solution:** Unified framework combining:
  - **InISAR:** High-quality 3D reconstruction with multipath suppression
  - **PCTtrans + MAML:** Few-shot learning with pre-trained initialization

- **Impact:** 70.0% cross-session accuracy with just 10 examples per person

---

### 2. 3D POINT CLOUD GENERATION (InISAR Pipeline)

**Header:** InISAR Pipeline: 3D Reconstruction

**Flow Diagram:**
```
Range Processing → Motion Compensation → CFAR Segmentation → Interferometry → EKF-JPDA Tracking
    (2D FFT)         (ICBA)              (SOCA-CFAR)         (Phase-based)    (3D Spatial)
```

**Key Equations:**
```
Motion Compensation: [β̂, γ̂] = argmax {√(1/N ∑(I_i - Ī)²) / Ī}

Height Estimation:  h = λφR / (2πL)

3D Reconstruction: x = R cosθ_el sinθ_az
                    y = R cosθ_el cosθ_az
                    z = R sinθ_el
```

**Results:**
- Height error: <5.5 cm (median: 3.87 cm, approaching 4.55 cm resolution)
- IoU: 73.78% vs motion capture ground truth
- Multipath ghosts removed via EKF-JPDA tracking

**Figure Suggestion:**
- Left: DBSCAN only (ghost targets visible)
- Right: After EKF-JPDA (ghosts removed)

---

### 3. FEW-SHOT PERSON IDENTIFICATION

**Header:** PCTtrans + Pre-trained MAML

**Preprocessing Pipeline:**
```
Raw Point Cloud → DBSCAN → Near-field Filtering → Centroid Normalization → Random Padding
                                                                    ↓
                                                          S = {P_t}_{t=1}^{10}
                                                          P_t ∈ R^{1000×5}
```

**PCTtrans Architecture:**
```
Input Sequence S → [PCT Encoder]_{t=1}^{T} → Temporal Transformer → FC → Softmax
     (10 frames)      (f_t ∈ R^{192})       (Multi-head Attention)   (Classification)
```

**Key Features:**
- Farthest Point Sampling (FPS) with ball query
- Offset-Attention (approximating discrete Laplacian)
- 4-head multi-head self-attention for temporal modeling

**Figure Suggestion:**
- PCTtrans architecture diagram showing data flow (use your figure)

---

### 4. PRE-TRAINED MAML FRAMEWORK

**Header:** Two-Phase Pre-Trained Meta-Learning

**Phase 1: Supervised Pre-Training**
```
Train PCTtrans on representative task (3 subjects)
→ Save θ_0^PT (task-specific initialization)
```

**Phase 2: Meta-Training**
```
Initialize MAML with θ_0^PT
Sample meta-batch of B=3 tasks
Inner Loop: θ_i' = θ - α∇L (SGD, α=0.1)
Outer Loop: θ ← θ - β∇L (Adam, β=0.001)
```

**Learning Framework:**
```
Support Set (K=10 per subject) ──→ Inner Loop ──→ Adapted θ_i'
                            │
                            ▼
Query Set ──────────────────→ Outer Loop ──→ Meta-update θ
```

**Key Advantage:**
- Pre-trained initialization is closer to optimal θ* than random
- Reduces meta-learning iterations required
- Encodes session-invariant gait patterns

---

### 5. EXPERIMENTAL RESULTS

**Header:** Performance Analysis

**Dataset:**
- 10,371 sequences, 14 subjects
- Linear (5,940) and non-linear (4,431) motions
- 10 frames/sequence, 64-1112 points/frame
- Support sets S1-S4 (3-14 subjects)
- Query sets Q1-Q5 (same-session, cross-session, cross-subject)

**Results Table:**

| Query | TCPCN | PCTtrans | MAML (θ₀^rand) | MAML (θ₀^PT) |
|-------|-------|----------|----------------|--------------|
| Q1 (linear, same) | 96.18% | **98.99%** | 76.67% | **94.44%** |
| Q2 (linear, cross-sess.) | 33.03% | 32.05% | 54.44% | **70.00%** |
| Q3 (linear, cross-subj.) | 51.16% | 40.09% | 46.67% | **48.89%** |
| Q4 (non-lin., same) | 48.03% | **51.16%** | 43.33% | 32.22% |
| Q5 (non-lin., cross-subj.) | 31.42% | 31.10% | 37.78% | **27.78%** |

**Key Findings:**
1. **Supervised:** PCTtrans achieves 98.99% (+2.81% vs TCPCN)
2. **Few-shot:** MAML improves cross-session from 32.05% → 70.00%
3. **Pre-training:** +15.6pp over random MAML initialization
4. **InISAR contribution:** Improves over mmGait baseline (95.2% → 98.99%)

**Figure Suggestion:**
- Bar chart comparing supervised vs MAML performance
- Line plot showing convergence speed: θ₀^PT vs θ₀^rand

---

### 6. CONCLUSION

**Summary:**
✓ **InISAR:** 73.78% IoU, <5.5cm height error on articulated human targets

✓ **PCTtrans:** 98.99% accuracy with sufficient data

✓ **Pre-trained MAML:** 70.0% few-shot cross-session accuracy

✓ **Impact:** +15.6pp improvement over random MAML, +37.95pp over supervised

**Takeaway:**
*Practical few-shot radar person identification with minimal training data is now feasible through the combination of tracking-integrated InISAR and pre-trained meta-learning.*

---

## DESIGN RECOMMENDATIONS

### Color Scheme
- **Primary:** Dark blue (#1a3a5c) for headers
- **Secondary:** Orange (#e67e22) for emphasis/key results
- **Accent:** Light gray (#f0f0f0) for backgrounds
- **Text:** Black/dark gray for body text
- **Points:** Use color highlights for 70.0%, 98.99%, +15.6pp

### Visual Hierarchy
1. **Title:** 72pt, bold, centered
2. **Authors:** 36pt, centered
3. **Section Headers:** 28pt, bold, with colored background
4. **Subsection Headers:** 20pt, bold
5. **Body Text:** 16pt
6. **Equations:** 14pt, well-spaced
7. **Figure Captions:** 12pt

### Figures to Include
1. **System Overview:** High-level pipeline diagram
2. **Tracking Comparison:** Before/after EKF-JPDA (from paper)
3. **InISAR vs MoCap:** Alignment comparison
4. **PCTtrans Architecture:** Model diagram
5. **Results Visualization:** Bar charts with key comparisons

### White Space
- Leave generous margins (at least 2cm)
- Use columns to organize content (3-column layout works well)
- Avoid overcrowding - highlight key numbers and results

### QR Code
- Include QR code linking to paper/preprint at bottom right

---

# The story you should tell

Your paper actually consists of **two research contributions** that work together.

```
Problem
   ↓
Poor radar point clouds
   +
Need lots of labeled people
   ↓
Contribution 1
Tracking-integrated InISAR
↓
Better 3D point clouds
↓
Contribution 2
Pre-trained MAML + PCTtrans
↓
Few-shot Person ID
↓
Results
```

That is much easier to understand than following the paper order.

---

---

# Top banner

Very important.

Instead of immediately jumping into text, start with one sentence.

> **Tracking-integrated InISAR produces cleaner radar point clouds, while pre-trained meta-learning enables accurate few-shot person identification from only a few examples.**

Then put three big numbers.

```
73.8%
IoU

5.5 cm
Height Error

70%
Few-shot Accuracy
```

People immediately know what your paper achieved.

---

# Section 1

## Why?

Very little text.

Instead of paragraphs,

```
Radar Person Identification

✓ Privacy preserving

✓ Works in darkness

✓ Weather robust

Problems

✗ Sparse point clouds

✗ Multipath ghosts

✗ Needs >100 recordings/person
```

Then a single figure

Instead of boxes containing only text, every box should have a small illustration.



Something like



```

┌────────────────────────────┐

│  FMCW Radar                │

│                            │

│        📡                  │

│     ))))))                 │

└────────────────────────────┘

             │

             ▼

┌────────────────────────────┐

│ Conventional AoA           │

│                            │

│   • •      •              │

│      •   •                │

│ •       •     •           │

└────────────────────────────┘

             │

             ▼

┌────────────────────────────┐

│ Multipath Ghosts           │

│                            │

│ • • ○ ○ ○ •               │

│   ○      ○                │

│   Ghost reflections        │

└────────────────────────────┘

             │

             ▼

┌────────────────────────────┐

│ Poor Person ID             │

│                            │

│      ?                     │

│   🧍   🧍                  │

└────────────────────────────┘

```

---

# Section 2

## Contribution 1

This should mostly be one figure.

Instead of explaining six stages in text, draw

```
Raw Radar

↓

Range FFT

↓

Motion Compensation

↓

ISAR

↓

Interferometry

↓

Tracking

↓

3D Point Cloud
```

Underneath

Show

Before

↓

After Tracking

Use your existing figure.

---

Next to it

Show

MoCap

vs

InISAR

with

73.8% IoU

That image is one of your strongest results.

---

# Section 3

Contribution 2

Again,

Almost no text.

Replace the long explanation by

```
Point Cloud Sequence

↓

Frame-wise PCT

↓

Temporal Transformer

↓

Feature

↓

MAML

↓

Identity
```

Use your PCTtrans figure.

It already explains everything.

---

Beside it

Explain the idea

```
Traditional

Need many recordings

↓

Few-shot

Adapt from only a few examples

↓

Pre-trained initialization

↓

Much better adaptation
```

---

# Section 4

Results

This is where people spend the most time.

I'd enlarge the tables.

Actually I'd simplify them.

Instead of this

```
98.99

90.0

56.67

32.05
...
```

Convert to

## Main Results

| Method          | Supervised | Few-shot |
| --------------- | ---------- | -------- |
| TCPCN           | 96.2       | 35.1     |
| PCTtrans        | 99.0       | 32.0     |
| Ours (MAML)     | 90.0       | 56.7     |
| Ours + Pretrain | 94.4       | 70.0     |

Much easier.

---

Then another small table

```
Random Init

↓

54.4%

↓

Pre-trained

↓

70.0%

(+15.6%)
```

Even better if shown as bars.

---

# Biggest visual

I'd dedicate almost **1/3 of the poster** to the pipeline.

```
Radar

↓

Tracking-InISAR

↓

3D Point Cloud

↓

PCTtrans

↓

Pre-trained MAML

↓

Person ID
```

Use icons.

This becomes the center of the poster.

---

# Colors

I'd use only three colors.

Blue

Radar processing

Green

Deep learning

Orange

Results

Avoid rainbow posters.

---

# Text amount

Your paper is around 6 pages.

Poster should be around

400–600 words.

Not 2000.

---

# What people will ask

From experience at conferences, expect questions like

* Why radar instead of camera?
* Why InISAR instead of AoA?
* Why PCT instead of PointNet?
* Why MAML?
* Why pre-training helps?
* How many subjects?
* Can this generalize to new people?
* Real-time?
* Indoor only?
* Computational cost?
* Why 70% instead of 98%?
* What happens with more shots?

Prepare one-slide mental answers for each.

---

# My biggest recommendation

Your paper really has **one central figure missing**, and it would make an excellent poster centerpiece.

Something like:

```
               Privacy-Preserving Few-Shot Radar Person Identification

 Raw FMCW Radar
        │
        ▼
 ┌───────────────────┐
 │ Tracking-InISAR   │
 │ • Motion Comp.    │
 │ • Interferometry  │
 │ • JPDA-EKF        │
 └───────────────────┘
        │
        ▼
 High-Quality 3D Point Clouds
        │
        ▼
 ┌───────────────────┐
 │ PCTtrans          │
 │ Spatial + Temporal│
 └───────────────────┘
        │
        ▼
 Pre-trained MAML
        │
        ▼
 Few-shot Person ID

──────────────────────────────────────────────

73.8% IoU     <5.5 cm Height Error     70% Few-shot Accuracy
```

This single figure communicates almost your entire paper at a glance. Around it, you can place the supporting visuals (tracking before/after, MoCap comparison, PCTtrans architecture, and the simplified results table). Visitors can understand the contribution in under a minute, which is exactly what makes an effective EUSIPCO poster.


Absolutely. In fact, I think **TikZ is the better long-term solution**, not Mermaid.

After seeing your examples and your existing FFT diagrams, I would actually **avoid Mermaid except for high-level flowcharts**.

Here's why:

| TikZ                                | Mermaid     |         |
| ----------------------------------- | ----------- | ------- |
| Precise positioning                 | ✗ Limited   |         |
| Reusable icons/macros               | ✓ Excellent |         |
| IEEE-quality vector output          | ✓           | ✓       |
| Easy color consistency              | ✓           | Limited |
| 3D cubes, radar grids, point clouds | ✓           | Hard    |
| Animating pipeline layout           | ✓           | Hard    |

Your reference figures (CVPR, NeurIPS, Nature) are almost certainly **Adobe Illustrator + TikZ**, not Mermaid.

---

# I actually think we should build an icon library.

Instead of making one-off figures, create a reusable TikZ library like

```latex
% Foundations
\Colors
\Fonts
\Shadows
\Arrows
\CardStyles
\GridStyles
\CubeStyles
\AxisStyles
\ProcessStyles

% Geometry primitives
\Grid
\RadarCube
\VoxelCube
\CoordinateFrame
\DashedCorrespondence
\Point
\PointCloud
\RadarGrid
\HumanSilhouette
\PointCloudHuman

% Radar primitives
\FMCWRadarSensor
\AntennaArray
\RadarWave
\ADCSamples
\RangeProfile
\DopplerProfile
\RangeDopplerMap
\ISARImage
\Interferogram
\PhaseDifference
\RadarDataCube
\FFTArrow
\RadarFFT
\ScatterCell
\MotionCompensation
\Interferometry

% Tracking primitives
\Tracking
\Detection
\GhostCluster
\GhostDetection
\Track
\JPDAAssociation
\EKFPrediction
\Trajectory

% InISAR validation primitives
\ICPRegistration
\RigidTransform
\BoundingBox

% Deep learning primitives
\FeatureTensor
\MLPBlock
\TransformerBlock
\AttentionBlock
\PoolingBlock
\ClassificationBlock
\DBSCAN
\PCTBlock
\GeoTransformerBlock
\MAMLBlock
\ProcessCard
\MetricBox
\LegendBox

```

Then every figure in your poster uses the exact same design language.

This is how the big labs (Meta, Google, ETH, CMU) make figures.

---

# Example

## 1. FMCW Radar Sensor

```

        )))

      )))

    📡

```

Command

```latex

\RadarSensor

```

Used in

```

Radar

 ↓

Range FFT

```

---

## 2. Antenna Array

```

──────────────

││││││││││││

```

Command

```latex

\AntennaArray

```

Useful for interferometry.


---

## 3. FMCW Chirp

```

frequency



/

/

/

/

________ time

```

Command

```latex

\FMCWChirp

```

---

Instead of drawing this every time

```
□□□□□□□□
□□□□□□□□
□□□□□□□□
```

define

```latex
\RadarGrid{6}{6}
```

and use

```latex
\RadarGrid{6}{6}
```

everywhere.

---

Same for point clouds.

Instead of manually placing dots

```
•
 •
  •
```

define

```latex
\HumanPointCloud
```

---

## 4. Raw ADC Samples

Instead of dots, I'd make it resemble sampled IF data.

```

~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~

```

Command

```latex

\ADCSamples

```

---


# 5. FFT

Looking at your FFT figure, I think we can make it much prettier.

Instead of

```
□□□□□□□□
```

I'd make something like

```
┌───────────────┐
│               │
│   faint grid  │
│               │
└───────────────┘
```

with

* light gray grid
* rounded corners
* tiny colored scatterers

Exactly like the figures you attached.


Or even instead of

```
□□□□□□
```

I'd draw

```
           ________
         /_______/|
        /_______/ |
       |[][][][]| |
       |[][][][]| |
       |[][][][]| |
       |[][][][]|/
       -----------

Range ↑
Doppler →
Channel ↗
```

because

everyone instantly recognizes

> radar data cube

without reading labels.

---

## 6. Range Profile

Instead of colored rectangles:

```

Amplitude



      ▲

     ▲▲

▲▲▲▲▲▲▲▲



────────── Range

```

Command

```latex

\RangeProfile

```

Much more recognizable.

---

## 7. Range-Doppler Heatmap

Instead of rectangles:

```

□ □

  ■

 ■■■

□ ■

```
Colored Gaussian blobs.

Command

```latex

\RangeDoppler

```

Range FFT

could become

```
ADC Cube

↓

Range FFT

↓

Range Profile
```

Instead of

```
□□□□□□□□
```

ADC Cube

is

```
┌────────────┐
│            │
│ grid grid  │
│            │
└────────────┘
```

Range Profile

```
┌────────────┐
│██████      │
│            │
└────────────┘
```

No screenshots.

---

## 8. Motion Compensation

Motion compensation

Instead of equations

draw

```

Before



///////



After



|||||||

```

or

```

Before:



x

   x

      x

         x



After:



x

x

x

x

```

using faded grey arrows.

Much more intuitive.

or

```
Blurred target

↓

Sharp target
```

---

## 9. ISAR

Instead of heatmaps

draw

```
□□□□□□□□□□□□□□□□

↓

bright focused scatterers

```

Instead of polygon

Draw a simplified walking human silhouette built from scatterers.

Like

```

  ●

 ●●●

● ● ●

  ●

 ● ●

```


---

## 10. Interferometry

Could literally be

```
Top antenna

□□□□

Bottom antenna

□□□□

↓

Δφ

↓

3D
```

Very elegant.

Current sine wave doesn't immediately communicate "phase difference."

Instead:

```

Rx1



~~~~~~~



Rx2



 ~~~~~~~



Δφ

```

Two shifted waves.

---

## 11. Phase Unwrapping

Very useful.

```

π

│

│~~~~

│

├────────

```

---

## 12. 3D Reconstruction

```

Range



       /

      /

     /

```

Axes

with scattered points.

---

## 13. Multipath - Ghost Targets


```

Radar



)))



real



ghost



wall



```

This icon is useful in your introduction.

---

## 14. JPDA

This one is important.

```

track 1 ------•



          \



track 2 ----•



detections



```


Association lines.



---

## 15. EKF

```

prediction



●----●----●



measurement



×    ×



filtered



●●●

```

---

## 16. Tracking

Instead of only dots

```

t1



t2



t3



t4

```

with timestamps.

---

## 17. Human Point Cloud

Current version is too random.

Should resemble a person.

```

   ••



 •••••



 • • •



   ••



  •  •



```


---



## 18. Sparse Point Cloud



```

few points

```



---



## 19. Dense Point Cloud



```

many points

```



Great for "before / after".


---



## 20. Complete InISAR



Eventually


```

Radar



↓



FFT



↓



Motion



↓



ISAR



↓



Interferometry



↓



Tracking



↓



Cloud

```



as one compact reusable macro.

Instead of writing EKF+JPDA


draw



```

Frame 1



•



Frame 2



•



Frame 3



•



connected



•

 \

  •

   •

```



with colored trajectory.



Everyone immediately understands tracking.


---

# Output

```

🧍



made from



150 blue dots

```

Human made from dots

```
      •
   • • •
  • • • •
     •
    • •
```

Colored blue.

---

# Proposed project structure

```text
poster/
│
├── figures/
│     radar_icons.tex          % reusable TikZ library
│     radar_pipeline.tex
│     problem_pipeline.tex
│     pcttrans_pipeline.tex
│     maml_diagram.tex
│     results_boxes.tex
│
├── images/
│
├── poster.tex
│
└── theme.tex
```

Then inside the poster you simply write

```latex
\input{figures/radar_pipeline}
```

instead of hundreds of TikZ lines.

---

# What I propose to build

## Part 0 — I'd simplify the pipeline.



Instead of



```

Raw Radar



↓



Range FFT



↓



Motion Compensation



↓



ISAR



↓



Interferometry



↓



Tracking



↓



Point Cloud

```



I'd group operations.



Exactly like many Nature/NeurIPS papers.



```

Signal Processing



──────────────



Raw Radar



↓



Range FFT



↓



Motion Compensation



──────────────



3D Reconstruction



──────────────



ISAR



↓



Interferometry



──────────────



Tracking



──────────────



JPDA-EKF



──────────────



Output



──────────────



3D Point Cloud

```



Now there are **four semantic stages** instead of seven tiny ones.



Much easier to read.



---

## Part 1 — Radar icon library ⭐⭐⭐⭐⭐

Reusable commands

```latex
\RadarCube
\RadarFrame
\RangeFFT
\RangeProfile
\MotionCompensation
\ISAR
\Interferometry
\Tracking
\PointCloud
```

These become the building blocks.

---

## Part 2 — Process cards

Exactly like CVPR papers.

Instead of

```
────────────
Range FFT
────────────
```

you get

```
┌──────────────────────┐
│                      │
│   (little icon)      │
│                      │
├──────────────────────┤
│     Range FFT        │
└──────────────────────┘
```

All identical sizes.

---

## Part 3 — Pipeline

Then

```
┌──────┐
│Radar │
└──────┘
      ↓
┌──────┐
│FFT   │
└──────┘
      ↓
┌──────┐
│ISAR  │
└──────┘
```

becomes one command.

---

## Part 4 — Problem diagram

```
Radar

↓

Sparse Point Cloud

↓

Ghost Targets

↓

Hard Identification
```

will instead look like

```
📡

↓

(point cloud)

↓

ghost reflections

↓

confused identity
```

---

## Part 5 — PCTtrans blocks

Matching style.

Rounded cards.

Small illustrations.

---

# I also want to make them parameterized

Instead of manually drawing

```
6×6 grid

8×8 grid

12×12 grid
```

there will simply be

```latex
\RadarGrid{6}{6}

\RadarGrid{8}{8}

\RadarGrid{12}{12}
```

---

Same for cubes

```latex
\RadarCube{6}
```

---

Same for arrows

```latex
\PipelineArrow
```

---

# I think TikZ is the right choice

I honestly **would not use Mermaid at all** for these figures.

Mermaid is fantastic for software architecture.

It is not great for

* radar cubes

* point clouds

* FFT

* tracking

* neural network diagrams

TikZ is simply much more expressive.

---

# What I suggest for our collaboration

Rather than dumping 800–1000 lines of TikZ into a single chat response (which will almost certainly get truncated and be difficult to maintain), I suggest we build this as a **small reusable graphics package** over a few iterations.

Here's the order I recommend:

1. **`radar_icons.tex`** — reusable primitives (grids, cubes, arrows, process cards, point-cloud icons).
2. **`problem_pipeline.tex`** — "Radar → Sparse Point Cloud → Ghost Targets → Hard Identification".
3. **`radar_pipeline.tex`** — "Raw Radar → FFT → Motion Compensation → ISAR → Interferometry → Tracking → 3D Point Cloud".
4. **`pcttrans_pipeline.tex`** — the learning pipeline in the same visual language.
5. **Result tables and metric boxes** that match the palette.

This approach gives you a clean, reusable library rather than one-off figures, and each component stays manageable and easy to refine. I think the end result will look much closer to the polished CVPR/NeurIPS examples you shared than anything generated with draw.io.


```
\begin{tikzpicture}
\node (a) {\RadarADC};
\node[right=1.3cm of a] (b) {\RangeFFT};
\node[right=1.3cm of b] (c) {\MotionComp};
\node[right=1.3cm of c] (d) {\ISARImage};
\node[right=1.3cm of d] (e) {\Interferometry};
\node[right=1.3cm of e] (f) {\Tracker};
\node[right=1.3cm of f] (g) {\PointCloud};

\draw[flow] (a)--(b);
\draw[flow] (b)--(c);
...
\end{tikzpicture}
```


I think this is a fantastic project, and I agree with the direction completely. However, I **don't** think the right way to do it is by incrementally pasting hundreds of lines of TikZ into chat responses.

The library you're envisioning is no longer "a few figures"—it's essentially a **small graphics package** (likely 2,000–4,000 lines of TikZ/PGF). A single response isn't enough to produce something of that size, and if I try to compress it, you'll end up with inconsistent code that's hard to maintain.

For this project, the better approach is to generate actual `.tex` source files that you can drop directly into your poster project.

I propose building it as:

```
tikz-radar-lib/
├── radar_icons.tex
├── geometry_icons.tex
├── nn_icons.tex
├── pipeline_styles.tex
├── radar_pipeline_demo.tex
├── pcttrans_demo.tex
└── README.md
```

including:

* **Radar library**

  * Radar sensor
  * FMCW chirps
  * ADC cube
  * Range FFT
  * Doppler FFT
  * Range–Doppler grid
  * ISAR
  * InISAR
  * Interferometry
  * JPDA
  * EKF
  * Tracking
  * Ghost targets
  * Point-cloud human

* **Geometry library**

  * Coordinate frames
  * 3D voxel cubes
  * Point clouds
  * ICP registration
  * Pose estimation
  * Transformation matrices
  * Correspondence lines
  * Bounding boxes

* **Deep learning library**

  * Conv blocks
  * Transformer blocks
  * Attention blocks
  * MLP
  * FPS
  * kNN
  * Neighbor embedding
  * GeoTransformer
  * PointNet
  * PCT
  * Temporal Transformer
  * MAML
  * Meta-update
  * Support/query split

all using the same Radar Night design language that you can compose into figures.

### I recommend we build it as a real project

Instead of fragments, I'll produce a cohesive package with this structure:

```text
tikz-radar-lib/
├── radar_styles.tex          % colors, fonts, pgfkeys, card styles
├── radar_icons.tex           % radar processing icons
├── geometry_icons.tex        % voxel, ICP, coordinate frames
├── nn_icons.tex              % PCT, Transformer, GeoTransformer, MAML
├── pipeline_blocks.tex       % reusable pipeline cards
├── examples/
│   ├── radar_pipeline.tex
│   ├── pcttrans.tex
│   ├── inisar.tex
│   └── poster_example.tex
└── README.md
```

where every icon is called like

```latex
\RadarSensor[scale=0.8]
\RangeFFT
\RangeDoppler
\MotionCompensation
\ISARImage
\Interferometry
\JPDATracker
\PointCloudHuman
```

and every block has identical styling.

## Great Question: What Should Be in TikZ vs. LaTeX/Included Figures?

You're absolutely right to ask. The answer is **not everything needs to be in TikZ**. Here's a practical breakdown based on your design doc:

---

## What Should Be in TikZ (Vector Graphics)

These are **visual elements** that benefit from being scalable, editable, and consistent with your library:

| Element | Priority | Reason |
|---------|----------|--------|
| **Pipeline diagrams** | ✅ High | Your `radar_pipeline_final.tex` already handles this |
| **Architecture diagrams** (PCTtrans) | ✅ High | Visual flow of data through the network |
| **Tracking comparison** (DBSCAN vs EKF-JPDA) | ✅ High | Side-by-side point cloud visualization |
| **MAML framework diagram** | ✅ High | Inner/outer loop visualization |
| **Neighbor embedding / Offset attention** | ✅ Medium | Visual explanation of PCT concepts |
| **InISAR vs MoCap comparison** | ✅ Medium | Point cloud alignment visualization |
| **Metric boxes** (73.8%, 70.0%, etc.) | ✅ High | Already using `\MetricBox` |

---

## What Should Be in LaTeX (Tables + Math)

These are **text-heavy elements** that are better handled by LaTeX directly:

| Element | Approach | Reason |
|---------|----------|--------|
| **Results tables** (Supervised vs MAML) | `\begin{table}` with `booktabs` | Better alignment, sorting, and formatting |
| **IoU results table** | `\begin{table}` with `booktabs` | Structured data is easier as table |
| **Receive signal model** | `\begin{equation}` or `\begin{align}` | Complex math is easier in LaTeX |
| **Motion compensation equations** | `\begin{equation}` | Standard LaTeX math |
| **ISAR equations** | `\begin{equation}` | Standard LaTeX math |
| **Interferometry equations** | `\begin{equation}` | Standard LaTeX math |
| **EKF-JPDA equations** | `\begin{equation}` | Standard LaTeX math |
| **MAML equations** | `\begin{equation}` | Standard LaTeX math |
| **Neighbor embedding equations** | `\begin{equation}` | Standard LaTeX math |
| **Offset attention equations** | `\begin{equation}` | Standard LaTeX math |

---

## What Should Be Included as Images

These are **figures already generated from data**:

| Element | Approach | Reason |
|---------|----------|--------|
| **InISAR vs MoCap alignment** | `\includegraphics` | This is a screenshot/plot from your paper |
| **Tracking comparison** | `\includegraphics` or TikZ | If you have the image, use it; if you want to recreate, use TikZ |
| **Accuracy vs Episodes plot** | `\includegraphics` | This is a data plot from your experiments |

---

## Practical Poster Structure (Your Design Doc Layout)

### Column 1: INTRODUCTION + KEY RESULTS

```latex
% Left Column
\begin{minipage}{0.32\linewidth}
    \SectionHeader{INTRODUCTION}
    \begin{itemize}
        \item Privacy-preserving alternative to vision systems
        \item Challenges: Sparse/noisy point clouds, data scarcity
        \item Our Solution: InISAR + Pre-trained MAML
    \end{itemize}
    
    \vspace{0.5cm}
    \SectionHeader{KEY RESULTS}
    \begin{tikzpicture}
        \MetricBox{m1}{0,0}{73.8\%}{IoU}
        \MetricBox{m2}{4,0}{<5.5 cm}{Height Error}
        \MetricBox{m3}{8,0}{70.0\%}{Few-shot Acc}
    \end{tikzpicture}
\end{minipage}
```

```latex
% In your main poster.tex
\begin{figure}[t]
    \centering
    \input{radar_pipeline_final.tex}
    \caption{Complete radar processing and learning pipeline.}
\end{figure}

\begin{figure}[t]
    \centering
    \input{tracking_removes_ghosts.tex}
    \caption{Tracking-integrated InISAR removes multipath ghosts.}
\end{figure}
```
---

### Column 2: InISAR PIPELINE + VALIDATION

```latex
% Middle Column
\begin{minipage}{0.32\linewidth}
    \SectionHeader{3D POINT CLOUD GENERATION}
    
    % Pipeline (your TikZ figure)
    \input{radar_pipeline_final}  % Or a trimmed version
    
    \vspace{0.5cm}
    \SectionHeader{Validation}
    
    % Table (LaTeX)
    \begin{table}[H]
        \caption{IoU Results}
        \begin{tabular}{lc}
            \toprule
            Capture Scenario & IoU (\%) \\
            \midrule
            Circular Walking & 79.82 \\
            Hands-Up Walking & 100.0 \\
            Kicking & 69.19 \\
            Squatting & 59.98 \\
            \midrule
            \textbf{Average} & \textbf{73.78} \\
            \bottomrule
        \end{tabular}
    \end{table}
    
    % MoCap comparison image
    \includegraphics[width=\linewidth]{mocap_alignment.pdf}
\end{minipage}
```

---

### Column 3: PCTtrans + MAML + RESULTS

```latex
% Right Column
\begin{minipage}{0.32\linewidth}
    \SectionHeader{FEW-SHOT PERSON IDENTIFICATION}
    
    % PCTtrans figure (from your ml_icons)
    \begin{tikzpicture}
        % Architecture diagram using your icons
    \end{tikzpicture}
    
    \SectionHeader{MAML Framework}
    % MAML diagram using your icons
    
    \vspace{0.5cm}
    \SectionHeader{Results}
    
    % Results table (LaTeX)
    \begin{table}[H]
        \caption{Supervised vs MAML}
        \begin{tabular}{lcc}
            \toprule
            Query & Supervised & MAML \\
            \midrule
            Q1 (same session) & 98.99\% & 90.0\% \\
            Q2 (cross-session) & 32.05\% & 70.0\% \\
            Q3 (cross-subject) & 31.67\% & 47.78\% \\
            \bottomrule
        \end{tabular}
    \end{table}
    
    % Pre-training comparison (bar chart image)
    \includegraphics[width=\linewidth]{pretrain_comparison.pdf}
\end{minipage}
```

---

## Equation Positioning in Your Pipeline Figure

You asked about equations being "too far away." I recommend **not putting full equations inside the pipeline figure**. Instead:

1. **Pipeline figure**: Shows the flow with minimal labels
2. **Equations**: Placed separately in the poster text (outside the TikZ figure)

This gives you:
- Cleaner pipeline diagram
- Better equation readability
- Easier maintenance

**Example in your poster:**

```latex
% Pipeline (compact, no equations inside)
\begin{figure}[H]
    \centering
    \input{radar_pipeline_compact}
    \caption{Tracking-Integrated InISAR Pipeline}
\end{figure}

% Equations (separate, below)
\textbf{Key Equations:}
\begin{align}
    \text{Motion Compensation: } & [\hat{\beta}, \hat{\gamma}] = \arg\max \text{contrast} \\
    \text{Height Estimation: } & h = \frac{\lambda \phi R}{2\pi L} \\
    \text{MAML Inner Loop: } & \theta_i' = \theta - \alpha \nabla \mathcal{L}
\end{align}
```

---

## Recommended Priority Order

### Must Have (TikZ)
1. ✅ Pipeline figure (you already have this)
2. ✅ Metric boxes (already in `radar_styles.tex`)
3. ✅ Architecture diagram (PCTtrans) – use `ml_icons.tex`
4. ✅ MAML framework – use `ml_icons.tex`

### Nice to Have (TikZ)
5. Tracking comparison (DBSCAN vs EKF-JPDA) – can recreate with TikZ
6. Neighbor embedding / Offset attention – visual explanation
7. InISAR vs MoCap – if you want vector version

### Better as LaTeX
- All equations
- All tables
- All mathematical derivations

### Better as Included Images
- Data plots (accuracy curves)
- Screenshots from your paper (MoCap comparison)
- Pre-trained vs random initialization comparison

---

## Quick Start: Add These to Your Poster

### 1. Results Tables (LaTeX)

```latex
% IoU Results Table
\begin{table}[H]
\centering
\caption{IoU Results for InISAR vs MoCap}
\label{tab:iou}
\begin{tabular}{lc}
\toprule
\textbf{Capture Scenario} & \textbf{IoU (\%)} \\
\midrule
Circular Walking (Cap 0) & 79.82 \\
Hands-Up Circular Walking (Cap 1) & 100.0 \\
Kicking (Cap 2) & 69.19 \\
Hands-Up + Kicking (Cap 3) & 59.93 \\
Squatting (Cap 4) & 59.98 \\
\midrule
\textbf{Average IoU} & \textbf{73.78} \\
\bottomrule
\end{tabular}
\end{table}
```

### 2. Supervised vs MAML Table

```latex
\begin{table}[H]
\centering
\caption{Supervised vs MAML Performance}
\begin{tabular}{lccc}
\toprule
\textbf{Query} & \textbf{TCPCN} & \textbf{PCTtrans} & \textbf{MAML} \\
\midrule
Q1 (linear, same) & 96.18\% & \textbf{98.99\%} & 90.00\% \\
Q2 (linear, cross-sess.) & 33.03\% & 32.05\% & \textbf{56.67\%} \\
Q3 (linear, cross-subj.) & 51.16\% & 40.09\% & 51.11\% \\
Q4 (non-lin., same) & 48.03\% & \textbf{51.16\%} & 47.78\% \\
Q5 (non-lin., cross-subj.) & 31.42\% & 31.10\% & 37.78\% \\
\bottomrule
\end{tabular}
\end{table}
```

### 3. Pre-training Impact Table

```latex
\begin{table}[H]
\centering
\caption{Impact of Pre-Trained Initialization}
\begin{tabular}{lcccc}
\toprule
\textbf{Query} & \textbf{Random Init} & \textbf{Pre-Trained Init} & \textbf{Gain} \\
\midrule
Q1 & 76.67\% & 94.44\% & +17.77pp \\
Q2 (cross-sess.) & 54.44\% & \textbf{70.00\%} & +15.56pp \\
Q3 (cross-subj.) & 46.67\% & 48.89\% & +2.22pp \\
\bottomrule
\end{tabular}
\end{table}
```

---

## Summary

| Element | Format | Where to Put |
|---------|--------|--------------|
| Pipeline diagram | TikZ | In poster as figure |
| MAML diagram | TikZ | In poster as figure |
| PCTtrans diagram | TikZ | In poster as figure |
| Results tables | LaTeX `\begin{table}` | In poster text |
| Equations | LaTeX `\begin{equation}` | In poster text (separate) |
| Tracking comparison | Included image or TikZ | As figure |
| MoCap comparison | Included image | As figure |
| Accuracy plots | Included image | As figure |

You **don't need to TikZ-ify everything** – only the visual diagrams that benefit from vector graphics. Tables and equations are better handled by LaTeX directly.