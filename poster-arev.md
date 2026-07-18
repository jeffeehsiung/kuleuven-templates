# EUSIPCO 2026 Poster — Build Package

## Contents
```
poster.tex                  Main LaTeX source (tikzposter, A0 portrait)
poster.pdf                  Pre-compiled output (verified, 1 page, A0)
img/                        All figures referenced by poster.tex
mermaid_diagrams/           Editable .mmd source for the 6 flowchart-style diagrams
```

## How to compile
Requires a full TeX Live install (tikzposter, amsmath, booktabs, pifont, hyperref — all standard).

```
pdflatex poster.tex
pdflatex poster.tex     # run twice for cross-references
```

## Editing the Mermaid diagrams
6 of the poster's diagrams (the simple box-and-arrow pipelines) are generated from Mermaid
source in `mermaid_diagrams/`, already rendered to PNG in `img/`:

| .mmd file | Renders to | Used in |
|---|---|---|
| `01_system_architecture.mmd` | `01_system_architecture.png` | Section 4 (framework overview) |
| `02_inisar_pipeline.mmd` | `02_inisar_pipeline.png` | Section 5a |
| `03_preprocessing.mmd` | `03_preprocessing.png` | Section 5a |
| `04_pcttrans_highlevel.mmd` | `04_pcttrans_highlevel.png` | Section 5b |
| `05_pcttrans_decomposed.mmd` | `05_pcttrans_decomposed.png` | Section 5b |
| `06_pretrained_maml.mmd` | `06_pretrained_maml.png` | Section 5b |

To edit: change the `.mmd` text, then either:
- Paste into https://mermaid.live to preview and export PNG/SVG manually, **or**
- Use the Mermaid CLI locally:
  ```
  npm install -g @mermaid-js/mermaid-cli
  mmdc -i 01_system_architecture.mmd -o img/01_system_architecture.png \
       -b white -c mermaid_diagrams/mermaid_theme.json -w 2400 -s 3
  ```
`mermaid_theme.json` holds the color palette (steel blue / navy / purple / orange / green) so
new renders stay visually consistent with the rest of the poster.

## Why NOT Mermaid for every diagram
Several of your diagrams (PCT hexagon architecture, MIMO antenna array, CFAR cell grid,
Range-Doppler FFT derivation, MAML θ-convergence plot) involve custom shapes, math formulas,
or real data plots that Mermaid's flowchart syntax cannot represent well. For those, this
package uses your existing PowerPoint/Keynote-exported PNGs directly (already in `img/`,
already styled consistently). Re-doing them in Mermaid would produce a visibly worse result
than what you already have — so only the genuinely sequential box-and-arrow diagrams were
converted to editable Mermaid; the rest stay as image assets.

## Placeholders still needed (marked `% TODO` in poster.tex)
These were not sourced from your reference material and currently show grey placeholder boxes:

| File | Needed for |
|---|---|
| `img/fig_motivation_cluster.png` | Section 1 — 4-icon cluster (low-light / weather / occlusion / privacy) |
| `img/fig_results_barchart.png` | Section 6 — Random vs. Pre-Trained init bar chart |
| `img/qr_inisar_video.png` | Section 7 — QR to InISAR reconstruction video |
| `img/qr_dbscan_video.png` | Section 7 — QR to DBSCAN before/after video |

Drop in replacement PNGs with the same filenames and recompile — no `.tex` edits needed.

## Color palette reference (for any new assets you create)
```
radarNavy    #1A2332   headers, body text
radarPurple  #6B4E9E   ML domain / attention
radarOrange  #E8734A   highlights, phase-1 / gain callouts
radarBlue    #3B7A9E   radar domain / primary blocks
radarGreen   #4A9B6E   outputs, positive results
radarBG      #FAFAF8   poster background
```

---

---


This is a genuinely well-thought-out content map — let's lock in the structural framework first, then I'll build piece by piece against it (waiting for your reference diagrams where you mention them).

# 1. Vertical Poster Layout Framework (A0 Portrait)

Following the audience journey (attract → problem recognition → how it's solved → deep-dive if interested → proof → "can I use this" → honest limits), here's the section stack top to bottom:

```
┌─────────────────────────────────────────────┐
│ 0. HEADER — Title, authors, logos, QR(paper) │
├─────────────────────────────────────────────┤
│ 1. MOTIVATION — why vision-based fails       │
│    (icon cluster: low-light/weather/         │
│     occlusion/privacy)                       │
├─────────────────────────────────────────────┤
│ 2. WHY RADAR — sensing theory                │
│    (time-stack + ToF/scatterer/spectrum)     │
├─────────────────────────────────────────────┤
│ 3. THE TWO PROBLEMS (side-by-side)           │
│    3a. Radar imaging quality problem         │
│    3b. Data-scarcity / learning problem      │
├─────────────────────────────────────────────┤
│ 4. OUR FRAMEWORK — 3-fold contribution       │
│    (hierarchy diagram + system-level         │
│     architecture, high-level only)           │
├─────────────────────────────────────────────┤
│ 5. DEEP DIVE (two columns)                   │
│    5a. InISAR pipeline detail                │
│    5b. Learning (PCTtrans+MAML) pipeline     │
│         detail                               │
├─────────────────────────────────────────────┤
│ 6. RESULTS — bar charts, stat callouts,      │
│    compact table, bullet highlights          │
├─────────────────────────────────────────────┤
│ 7. QR VIDEOS — InISAR 3D reconstruction,     │
│    DBSCAN before/after                       │
├─────────────────────────────────────────────┤
│ 8. INDUSTRIAL OUTLOOK — obstacles/future     │
│    work (5 points), invites collaboration    │
├─────────────────────────────────────────────┤
│ 9. FOOTER — contact, acknowledgments         │
└─────────────────────────────────────────────┘
```

**One structural flag before we go further:** this is a *lot* of content for one A0 sheet — more than most posters attempt, and closer to "poster + mini-paper." That's not necessarily wrong for your audience (researchers wanting depth), but I'd recommend treating **Sections 0-4 + 6 as the "primary path"** (readable standing 2m away, ~2 min), and **Section 5 (deep dive) as an optional "zoom-in" path** (smaller text, denser, for someone who's already engaged and steps closer). I'll design 5 visually distinct (e.g., subtly different background tint) so it doesn't feel like the poster demands uniform reading depth from everyone.

---

# 2. Section-by-Section Content & Icon Allocation

## Section 1 — Motivation (why vision-based approaches fail)
**Icon cluster (4 icons, small multiples, same visual family):**
| Icon | Represents |
|---|---|
| Low-light scene (moon/dim bulb over faint silhouette) | Low-light conditions |
| Fog/rain streaks over silhouette | Adverse weather (foggy, raining) |
| Silhouette partially behind a wall/object | Occlusions |
| Face with blur/pixelation overlay (**not** a slash — good call, blur reads as "privacy protected" rather than "camera forbidden") | Privacy concerns |

→ These 4 sit together as a **"conventional vision breaks down here"** cluster, one row, minimal/duotone.

## Section 2 — Why Radar (sensing theory)
This is the most conceptually rich icon in your list. Content to encode:
- **Time-stack of person silhouettes** (like a motion-blur/strobe photo) — shown twice: once indoor, once outdoor — establishing "radar works across environments"
- **Reflected signal concept:** transmitted pulse → travels → hits scatterers on body → reflects back (ToF arrows), with a small annotation for round-trip time
- **Scatterer model:** body rendered as a handful of point-scatterers (not full silhouette) — ties directly to your later point-cloud framing
- **Spectrum panel:** small range-Doppler-style plot fragment (just illustrative, not real data) to preview "this is what gets processed"

**Proposed composition:** one wide horizontal icon — indoor silhouette-stack (left) + radar unit with ToF arrows to a scatterer-body (center) + small spectrum thumbnail (right) — with the caption line: *"mmWave radar: privacy-preserving, robust across lighting/weather"*.

## Section 3a — Radar Imaging Quality Problem
Content: AoA limitations (sparse/noisy, limited angular resolution, motion defocusing, multipath ghosts, indoor) + related-work gap (micro-Doppler = no 3D structure; InISAR proven on rigid targets like ships/aircraft, not validated on articulated humans; indoor ghost clusters + aspect-dependent sparsity)

**Icons needed:**
- Sparse/ghost point cloud (you already have this from earlier)
- Ship/aircraft silhouette icon with a small "✓ validated" vs. human silhouette with "? not validated" — visually shows the *gap* your paper fills
- Small "articulated joints" icon (skeleton with joint dots) to signal *why* humans are harder than rigid targets

## Section 3b — Data Scarcity / Learning Problem
Content: existing methods need >100 sequences/person (hours of recording) + PointNet (permutation-invariant, MLP+max-pool, no local geometry) + PCT (neighbor embedding + offset-attention, but static-object-focused)

**Icons needed:**
- Stack-of-many-files/clock icon → ">100 sequences, hours of recording" (scalability bottleneck)
- Simple before/after: PointNet icon (scattered points, no connections = "no local structure") → PCT icon (points with local neighbor-links = "captures local structure") → both labeled "static objects only" with a small arrow pointing to your gait/time icon asking "temporal + noisy?"

## Section 4 — Our Framework (3-fold contribution)
**No model internals here** — agreed, this stays conceptual/system-level.

**Layout: hierarchy/layered diagram**, 3 horizontal bands converging into one system icon:
```
[Radar domain icon]  ──┐
[ML domain icon]     ──┼──→ [System-level integration icon]
[bridges: quality+scarcity]─┘
```
- **(1) Radar domain** icon: antenna + point-cloud-cluster + tracking-line (tracking-integrated InISAR)
- **(2) ML domain** icon: transformer block silhouette + MAML inner/outer loop arrows (small, abstract — not the full architecture)
- **(3) System integration** icon: the two above merging into one output icon (person ID checkmark)

**Center placement:** your uploaded system architecture reference diagram goes here, restyled to match palette — I'll wait for your upload.

**Adjacent callout box** (small text, not icon-heavy): the meta-learning novelty statement — *"prior radar PID + MAML work initializes randomly; NLP shows pre-trained init accelerates meta-learning; we extend this to radar point-cloud PID"* — this is a good candidate for a **highlighted "novelty" text box** (colored border) rather than another icon, since it's a positioning argument, not a visual concept.

## Signal Processing Callout (sits near Section 5a)
Compact formula/definition box: FMCW→FFT (fast-time/slow-time), ISAR aperture synthesis, motion compensation, InISAR elevation-via-phase. Then **4 challenge icons** (small, in a 2×2 grid):
| Icon | Challenge |
|---|---|
| Torso dense-dots / limb sparse-dots figure | Aspect-dependent density (∝1/r⁴) |
| Ghost-cluster duplicate silhouette | Multipath noise |
| "<4m" ruler + broken phase wave | Near-field errors |
| Stack of files with a small "×100" | Data scarcity (echoes 3b, reinforces) |

## Section 5a — InISAR Pipeline (deep dive, left column)
- Stacked noisy/sparse point-cloud snapshots (time-axis) — reuse/extend Section 3a's motif in 2D+3D small multiples
- Range-Doppler spectrogram icon (simple FFT heatmap silhouette)
- MIMO antenna layout diagram — **waiting on your reference upload**
- CFAR icon: classic CUT (cell under test) + guard cells + training cells (leading/lagging) grid — this is a very standard radar-textbook diagram, I can build this cleanly once we're ready
- 6-stage pipeline strip (Style 1, matches what we tested): Range FFT → ICBA autofocus → Doppler FFT → CFAR → Interferometry → EKF-JPDA tracking

## Section 5b — Learning Pipeline (deep dive, right column)
- Stacked point clouds across time (input) — **waiting on your reference upload**
- Decomposed PCTtrans layers, restyled to poster palette — **waiting on your reference upload** (this is likely your Fig. 3 redrawn)
- Input-embedding flow diagram — **waiting on your reference upload**
- **Few-shot icon:** a small cluster of "new/unlabeled" samples (dashed-outline points) next to a "?" — signals unseen-domain samples
- **Pre-trained meta-learning icon:** a "knowledge base" icon (stacked layers/brain-like abstract shape, not literal brain) with inner-loop/outer-loop curved gradient arrows looping back — this is the visual anchor for your headline contribution

## Section 6 — Results
- Bar chart: Random vs. Pre-trained init across Q1/Q2/Q3 (S2), **+15.56pp** annotated
- 3 big stat callouts (98.99% / 32.05%→70.0% / +15.6pp) — as discussed earlier
- Compact table: collapse Table II+III into one small results table (few rows only)
- 3-4 bullet highlights in plain language

## Section 7 — QR Videos
Two QR codes (not three, since the tracking-integrated video isn't ready):
1. **InISAR-processed 3D point cloud video** (ffmpeg-generated)
2. **DBSCAN before/after** on non-tracking-integrated point clouds (ffmpeg-generated)

Label clearly as supplementary — small icons (play-button + point-cloud) next to each QR so it's obvious what they'll see before scanning.

## Section 8 — Industrial Outlook (5 points, honest limitations)
This is your collaboration-invitation section. I'd render as **5 compact numbered cards**, each: icon + 1-line problem + 1-line "what's needed":

| # | Icon | Problem | Path forward |
|---|---|---|---|
| 1 | Clock/hourglass over point cloud | Offline processing (particle-like per-scatter tracking is slow) | Online version / cluster-center-only tracking |
| 2 | Radar + camera icon, half-faded | Radar-only lacks RGB discriminative power at scale | Multimodal fusion (where privacy allows) |
| 3 | Server/HPC rack icon | Pre-trained weights as public resource need more subjects + compute | Community dataset + HPC access |
| 4 | Tracking-line with a gap | Current tracking not optimized for industrial speed | Tracking algorithm improvements |
| 5 | Slider/dial icon | Fixed max-missing-frame (=1) not adaptive to occlusion probability | Tunable / self-adaptive threshold |

---

# 3. What I need from you to proceed

You mentioned **4 reference diagrams** you'll upload (system architecture, MIMO antenna layout, stacked-point-cloud-in-time, layer decomposition, embedding-flow). Once those land, I'll restyle each to match the palette/icon language we've been testing (recommend: **Style 3 duotone for hero diagrams, Style 1 outline for repeated/small elements**, per our last comparison).

**Suggested build order** (tell me if you'd reorder):
1. Section 1 motivation cluster (4 icons) — quick, unblocks nothing else
2. Section 2 "why radar" hero icon
3. Section 3a/3b problem icons
4. Section 4 hierarchy diagram (needs your system architecture reference)
5. Section 5a/5b deep dive (needs 4 more references)
6. Section 6 results bar chart
7. Section 8 industrial outlook cards

---
---

Let me check the full set of uploaded files, including the HEIC ones that may not have rendered inline.ImageMagick can read HEIF. Let me convert all of them.All converted. Let me view each one to understand what you're referencing.This is a great "why radar" concept diagram — MIMO antenna array (TX/RX) sensing through a wall to a person, output through "Signal Processing & AI" to answer "who?" Let me continue through the rest.This is exactly the MIMO antenna layout you mentioned (physical array → virtual array via TX/RX combinations). Continuing.Same MIMO diagram, higher resolution version — good, this is the clean vector version. Continuing through the rest.This is the **full system architecture** — exactly what belongs in Section 4! Continuing.This is the InISAR-specific pipeline (Section 5a target) — CFAR Detection, Interferometry, Tracking with clean per-stage labeling. Continuing.This one adds the ICBA autofocus + motion compensation + 2D-ISAR detail with range/Doppler formula — very useful for the signal-processing callout box. Continuing.This is a nice general "what is a point cloud" educational visual (Stanford bunny) — could support the PointNet/PCT explanation section. Continuing.Same pipeline family, zoom-in on interferometry. Continuing with the JPG/JPEG files now.Excellent — full interferometry derivation with the virtual antenna geometry and formulas. Continuing.This is the **exact CFAR icon** you described — Cell Under Test, Guard Cells, Training Cells grid! Continuing to the last two heif files, then the JPGs.Full ICBA/motion-compensation formula derivation — great for the signal-processing callout. Last heif file:I've converted and reviewed all 20 references (12 HEIC + the JPGs from your last message rendered inline). This is excellent material — a lot of it is publication-ready as-is. Here's the catalog and how each maps to our framework.

## Important style observation first

Your own HEIC references (from the IMEC/Surv-AI-llance work) already share a **clean, consistent visual language**: steel-blue rounded blocks, dark slate-teal labels, white background, thin connecting arrows. This is *coincidentally* very close to our "Radar Night" Option A blue accent (`#3B7A9E`).

**Recommendation:** rather than restyling these into our full 5-color palette, treat **your existing steel-blue block style as the poster's primary diagram language** for all system/pipeline diagrams, and reserve purple/orange/green from our palette for *icons, highlights, and stat callouts* layered on top. This keeps everything you already have nearly drop-in usable, and avoids a jarring style clash between "your diagrams" and "my icons."

---

## What you have, mapped to poster sections

| File | Content | Poster section |
|---|---|---|
| `IMG_5347` | "Why radar" concept — MIMO array sensing through wall → person, Signal Processing & AI → "who?" | **Section 2** (Why Radar) — near-perfect as-is |
| `IMG_9341` | MIMO-ISAR vs. Camera: target image/point cloud vs. photo | **Section 2 or 3a** — strong visual proof pairing radar output vs. camera |
| `IMG_8925` + `IMG_1014` | Physical board photo + Physical/Virtual antenna array diagram | **Section 5a deep dive** — MIMO antenna layout you specifically asked for |
| `IMG_2421` | **Full system architecture**, person→signal→3D point cloud→PCT→Transformer→classification | **Section 4** — this is your centerpiece system diagram |
| `IMG_5783` / `IMG_9098` / `IMG_9286` / `IMG_2715` / `IMG_6571` | Progressive zoom-ins of the InISAR sub-pipeline (Radar imaging→CFAR→Interferometry→Tracking, plus ICBA/motion-compensation zoom) | **Section 5a** — pick the most complete version + 1-2 zoom details |
| `IMG_2331` | Same pipeline **+ CFAR cell diagram** (CUT/Guard/Training cells) + Range-Doppler-Channel cube | **Section 5a** — exactly the CFAR icon you wanted |
| `IMG_1591` | Interferometry derivation (virtual antenna geometry + φ_diff formulas + altitude formula) | **Signal processing callout box** near 5a |
| `IMG_3337` | ICBA/motion-compensation math derivation | **Signal processing callout box** near 5a |
| `IMG_0397` | **Stacked range-Doppler spectrograms** (velocity vs. range, time-stacked) — real data | **Section 3a / 5a** — this IS your "stacked snapshots + spectrogram" ask, and it's real data not illustration |
| `IMG_9021` | Point Cloud vs. Voxel vs. Mesh (Stanford bunny) | Optional — supports PointNet/PCT explanation in 3b, only if space allows |
| Image 1–5 (JPG, generic ML diagrams) | Style/format references: layered feature maps, QKV attention blocks, hierarchical fusion trees, encoder-decoder blocks, tensor-shape annotations | **Style guide for Section 5b** (learning pipeline decomposition) — not domain content, but shows the *diagram convention* you want for the PCTtrans layer breakdown |

---

## What's still missing (from your "part one" framing, I assume more is coming)

Looking back at your detailed message, I don't yet have:
- The **stacked point clouds across time** reference for the *learning* pipeline input (you distinguished this from the InISAR-side spectrogram stack — `IMG_0397` covers radar-side, not the point-cloud-sequence-as-transformer-input side)
- The **decomposed PCTtrans layer diagram** reference (your Fig. 3 redrawn/detailed)
- The **input-embedding flow diagram**
- Anything for the **few-shot** and **pre-trained meta-learning** icons

---
---
All converted. Let me view each one.This is real 3D point cloud data showing sparsity/noise/missing body segments — perfect for Section 3a problem illustration.This shows the DBSCAN-colored clusters (ghost identification) with the key insight "sequence of consecutive frames as ML model input" — this bridges directly into your temporal transformer motivation.This is the exact **DBSCAN before/after** you wanted the QR video for — this static version is even great as a poster figure directly.Same steel-blue family, DBSCAN concept explainer with target cluster / noise / clusters legend — great supporting visual for preprocessing.Adds the full DBSCAN Core/Border/Noise/ε diagram — textbook clean. Continuing.Same set, adds Kneedle algorithm loop (Knee Point Analysis → ε distribution → DBSCAN, repeat) — matches your paper's "adaptive Kneedle algorithm" detail.Normalization step: centroid-shift illustration.This is the **"stacked point clouds across time" for the learning-side input** you specifically asked for — 10 frames grouped into "1 video," near-field filtering shown too. Continuing.Encoder/Decoder high-level building block — same style family, useful base for the transformer explanation.This is your **input-embedding flow diagram** — point cloud silhouettes → Input Embedding → stacked feature vectors. Exactly what you asked for.QKV self-attention flow, same style. Continuing.QK matrix multiplication → attention scores, continuing the same teaching sequence.Scale + Softmax step. Continuing.Final attention output step (weights × value = output). Continuing.Full residual + LayerNorm + FFN block — the complete encoder internals teaching sequence. Continuing.This is a beautifully simple **high-level PCTtrans summary** — time-stacked person point clouds → Spatial Feature Extraction → Temporal Feature Extraction → ID. Perfect top-level anchor for Section 5b.This is the **decomposed PCTtrans layer diagram** — Point Embedding→Neighbour Embedding→Attention→Pooling | Position Encoding→Transformer→Pooling & Classification. Exactly what you needed for Section 5b.Zoom-in on Point Embedding: 3D→128D→128D via LBR (shared weights). Excellent educational detail.Neighbor Embedding zoom: FPS (Farthest Point Sampling) → Group → Set-Level Abstraction, exactly matching your SG1/SG2 sampling-and-grouping description. Last one:Offset-Attention zoom: input features → attention output → weighted features. This completes the full teaching sequence for your PCT encoder.

---

# Part 2 catalog — this is remarkably complete

You now have (combined with Part 1) essentially **every diagram needed for Sections 3a, 3b, 4, 5a, and 5b**, all in one consistent steel-blue visual language. Updated mapping:

| File(s) | Content | Section |
|---|---|---|
| `IMG_2353`, `IMG_1578` | Real 3D point cloud data: sparsity/non-uniform density/noise, missing body segments → "solution: sequence of frames" | **3a** — direct evidence for the problem, and bridges to why temporal modeling matters |
| `IMG_4340` | **DBSCAN before/after** (6 clusters → 1 cluster) | **This can BE your QR-video poster still**, or a static callout |
| `IMG_9834`, `IMG_8616`, `IMG_2995` | DBSCAN concept (Core/Border/Noise/ε) + Kneedle loop | **5a preprocessing detail** |
| `IMG_8081` | Normalization (centroid shift) | **5a preprocessing detail** |
| `IMG_7465` | 10 frames → "1 video" grouping (with <4m near-field filtering) | **5a preprocessing** — also doubles as your "stacked point clouds in time" input visual |
| `IMG_0331` | **High-level PCTtrans summary**: time-stack → Spatial FE → Temporal FE → ID | **5b hero/top-level anchor** |
| `IMG_4016` | **Full decomposed PCTtrans layers**: Point Emb→Neighbor Emb→Attention→Pooling \| Pos Enc→Transformer→Pooling&Classification | **5b main diagram** |
| `IMG_0424` | Point Embedding zoom: 3D→128D→128D via LBR | **5b zoom-in detail** |
| `IMG_8726` | Neighbor Embedding zoom: FPS→Group→Set Abstraction | **5b zoom-in detail** |
| `IMG_8389` | Offset-Attention zoom: input features→attention→weighted features | **5b zoom-in detail** |
| `IMG_6019`,`8185`,`4531`,`8196`,`0926`,`8438`,`8276` | Generic Transformer teaching sequence (Encoder/Decoder → QKV → scores → scale/softmax → output → residual/LayerNorm/FFN) | **Background/style reference** — probably too generic-textbook for the poster itself, but confirms the diagram convention for anything custom I build |

## Still open
Your **few-shot icon** (unseen/dashed-outline samples) and **pretrained meta-learning icon** (knowledge base + inner/outer loop gradient arrows) aren't in either batch — those seem to need original creation rather than restyling a reference, unless you have something for those too.

**Given how complete this is, my suggestion:** I now have everything needed to build **Sections 3a, 4, 5a, and 5b almost entirely from restyled versions of your own diagrams** (consistent, fast, low-risk), and only need to originally design: the Section 1 motivation cluster, Section 2 hero icon, few-shot/meta-learning icons, and Section 6/8 results & industrial-outlook visuals.
---
---

All converted successfully. Let me view each.Pooling zoom-in: Weighted Features → Global Feature Vector — completes the PCT encoder teaching sequence.This is the **master version** — full pipeline with the time-stacked "sequence of global feature vectors" visual before AND after the transformer. This should be the primary Section 5b diagram.This is exactly the **few-shot motivation icon** — Task 1 trained model tested on Task 2 people → low accuracy. Excellent for setting up MAML.This is your **pre-trained meta-learning hero diagram** — θ_pretrained vs. θ_random within task distribution, plus the classic MAML gradient-convergence plot. This is the visual anchor for your headline contribution.FMCW chirp/frame timing diagram (TX1/TX2 interleaved) — great for the signal-processing callout box (fast-time/slow-time explanation).Classic FMCW TX/RX chirp diagram with round-trip time, bandwidth, IF frequency — this is your **"why radar" ToF/scatterer signal model** visual, textbook clean.This is a **gold-standard Range-Doppler FFT explainer** — full grid derivation with a real range-Doppler heatmap and all formulas. This alone could anchor your entire signal-processing callout box.Grayscale grid version, same content — cleaner as a standalone building block if I need to isolate it.Isolated Range FFT → Doppler FFT → scatterer identification grid, clean standalone version.Real range-Doppler heatmap, high resolution — great as an actual-data thumbnail in the spectrum panel.This "Multipath Noise" slide with the radar spoke/cell/range-bin fan diagram is great supporting material for Section 3a's multipath explanation.Real DBSCAN result with Noise vs. Non-Noise points clearly separated (blue target vs. red multipath ghosts). Excellent real-data evidence for Section 5a.# Part 3 catalog — this closes essentially every remaining gap

| File | Content | Section |
|---|---|---|
| `IMG_3036` | **Master PCTtrans pipeline**: full chain with time-stacked "sequence of global feature vectors" shown *before and after* the transformer | **5b — primary diagram** (supersedes the simpler `IMG_0331`/`IMG_4016`, use this as the main one) |
| `IMG_9236` | Pooling zoom: weighted features → global feature vector | 5b zoom-in (completes the PCT encoder walkthrough) |
| `IMG_4923` | **Few-shot motivation**: model trained on Task 1 people → tested on Task 2 people → low accuracy | **3b / novelty callout** — perfect setup for "why MAML" |
| `IMG_9508` | **θ_pretrained vs. θ_random within task distribution + MAML gradient convergence plot** | **This is your pre-trained meta-learning hero icon** — Section 4/5b anchor, exactly as requested |
| `IMG_7422` | FMCW TX1/TX2 interleaved chirp/frame timing | Signal processing callout (fast-time/slow-time) |
| `IMG_9942` | FMCW TX/RX signal model: round-trip time, bandwidth, IF frequency, Doppler | **Section 2 "why radar"** — the ToF/scatterer visual you asked for |
| `IMG_9825` | **Full Range-Doppler FFT explainer**: grid derivation + real heatmap + all resolution formulas | **Signal processing callout centerpiece** |
| `IMG_1880`, `IMG_3957` | Isolated grid building blocks (range-Doppler-channel cube, Range FFT→Doppler FFT→scatterer) | Supporting pieces if I need to recompose `IMG_9825` |
| `IMG_4933` | Real range-Doppler heatmap (clean, high-res) | Spectrum thumbnail, actual data |
| `IMG_4720` | Multipath Noise: radar spoke/cell/range-bin fan + 2-stage clustering insight | **3a multipath explanation** |
| `IMG_0536` | Real DBSCAN result: Noise (red) vs. Non-Noise (blue) 3D scatter | **3a/5a — real evidence, strong visual** |
| `IMG_1681` | Original PCT paper (Guo et al.) hexagon-style figure | Style reference — confirms your hexagon convention (matches `pcttrans_v4.png`) |
| `pcttrans_v4.png` (your Image 1) | Your refined PCTtrans architecture, hexagon style, already colored | **This can likely BE the Section 4/5b diagram directly**, minimal restyling needed |
| `p05_frame29.png` (your Image 2) | Real example: sparse 3D point cloud (radar) vs. camera photo, same scene | **Section 1/2 — strong real "why radar" privacy/robustness proof**, better than an illustrated icon |

---

## Where this leaves us

Across all three batches, I now have real source material for **every section in the framework** except the pure "motivation icon cluster" (low-light/weather/occlusion/blur — Section 1) and the results/industrial-outlook visuals (Sections 6/8), which don't have paper precedent and were always going to be built fresh.

**I'd suggest we stop gathering and start assembling.** Continuing to search for one-more-perfect-reference has diminishing returns now — `pcttrans_v4.png`, `IMG_3036`, `IMG_9508`, `IMG_9825`, and `p05_frame29.png` alone cover your five most content-critical visuals almost completely.

Proposed build order:
1. **Section 4 + 5b** (system architecture + PCTtrans decomposition + pretrained-MAML) — nearly free, mostly restyle/crop of what you have
2. **Section 5a + signal-processing callout** — same, from your InISAR/CFAR/Range-Doppler references
3. **Section 3a/3b problems** — combine `IMG_2353`/`IMG_1578`/`IMG_4720`/`IMG_0536`/`IMG_4923` with light relabeling
4. **Section 1 + 2** — the only sections needing original icon design (motivation cluster + why-radar hero), now informed by `p05_frame29.png` and `IMG_9942`
5. **Section 6/8** — original (results charts, industrial outlook cards)

Want me to proceed in that order, starting with Section 4 now?