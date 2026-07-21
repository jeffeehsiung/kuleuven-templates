# tikz-radar-lib

A reusable TikZ graphics library in the "Radar Night" palette, built for
the EUSIPCO poster (radar-based few-shot person identification) and meant
to be reused for future papers/posters.

Tested with TeX Live 2023 / pdfTeX. Every file in `examples/` compiles
standalone (`pdflatex examples/<name>.tex`) and each corresponding `.png`
is a rendered preview.

## Structure

```
tikz-radar-lib/
├── radar_styles.tex     % palette, libraries, ProcessCard, flow arrows,
│                         %   MetricBox, LegendSwatch, SectionHeader
├── radar_icons.tex      % radar signal-processing icons
├── nn_icons.tex         % deep learning / meta-learning icons
├── geometry_icons.tex   % 3D vision / point-cloud geometry icons
└── examples/
    ├── test_styles.tex        % minimal sanity check of the primitives
    ├── pipeline_demo.tex       % all radar_icons.tex icons in cards
    ├── nn_demo.tex             % all nn_icons.tex icons in cards
    ├── geometry_demo.tex       % all geometry_icons.tex icons in cards
    └── poster_centerpiece.tex  % the full composed poster centerpiece
                                 %   (radar pipeline -> PCTtrans -> MAML
                                 %    -> few-shot ID, with metrics + legend)
```

## Usage

In your poster/paper `.tex`:

```latex
\input{radar_styles.tex}     % always first
\input{radar_icons.tex}      % if you need radar icons
\input{nn_icons.tex}         % if you need NN/meta-learning icons
\input{geometry_icons.tex}   % if you need point-cloud/geometry icons
```

(Paths are relative to wherever you put the library folder; adjust as
needed, or add the folder to your TEXINPUTS.)

### The core primitive: `\ProcessCard`

```latex
\begin{tikzpicture}
  \ProcessCard{a}{Raw Radar}{\RadarSensor}
  \ProcessCard[right=1.2cm of a]{b}{Range FFT}{\RangeFFT}
  \draw[flow] (a) -- (b);
\end{tikzpicture}
```

- `#1` (optional) — any node option, most commonly a `positioning`
  library key like `right=1.2cm of a`, or `card color=deepLearning` to
  recolor the title bar.
- `#2` — node name (for connecting with `\draw[flow] (a) -- (b);`)
- `#3` — title text shown in the colored bottom bar
- `#4` — icon content: any of the icon macros below, or your own raw
  TikZ `\draw`/`\fill` commands (drawn in a local coordinate box from
  roughly (-0.55,-0.55) to (0.55,0.55))

**Important gotcha (already worked around in the library, but worth
knowing if you extend it):** never set `fill=` directly on a
`process card` node — it conflicts with the `rectangle split part fill`
key used internally and silently blanks the whole node. Use the
`card color=<colorname>` style instead.

### Icon inventory

**radar_icons.tex** (default color `radarProcessing`):
`\RadarCube`, `\RadarGrid{rows}{cols}`, `\RangeFFT`, `\RangeProfile`,
`\MotionCompensation`, `\ISARImage`, `\Interferometry`, `\Tracking`,
`\GhostCluster`, `\PointCloudHuman`, `\RadarSensor`

**nn_icons.tex** (default color `deepLearning`, all accept `[color]`
as an optional first argument, e.g. `\PCTBlock[resultsColor]`):
`\ConvBlock`, `\MLPBlock`, `\AttentionBlock`, `\TransformerBlock`,
`\FPSBlock`, `\kNNBlock`, `\PCTBlock`, `\GeoTransformerBlock`,
`\TemporalTransformerBlock`, `\MAMLBlock`, `\MetaUpdateBlock`,
`\SupportQuerySplit`

**geometry_icons.tex** (default color `geometryColor`, same
`[color]` override convention):
`\CoordinateFrame`, `\VoxelCube`, `\PointCloud`, `\ICPRegistration`,
`\BoundingBox`, `\TransformMatrix`, `\CorrespondenceLines`

### Other primitives (radar_styles.tex)

- `\MetricBox{name}{coord}{73.8\%}{IoU}` — the big number + label
  callouts for a results band.
- `\LegendSwatch{coord}{colorname}{Label text}` — small colored square
  + label for a figure legend.
- `\SectionHeader[color]{Contribution 1}` — colored pill for poster
  column headers.
- `\draw[flow] (a) -- (b);` / `\draw[flow dashed] (a) -- (b);` —
  the standard pipeline connector arrow.

### Positioning tip

Don't hand-place cards with absolute coordinates — chain them with the
`positioning` library (`right=of`, `below=of`) as in the examples, then
anchor anything else (metric bands, legends, dividers) relative to the
actual node names using `|-`/`-|` and `!0.5!` (see
`poster_centerpiece.tex` for a worked example). This way the whole
figure re-flows correctly if you resize a card or change a title.

## What's next / not yet built

This covers the full three-module scope you asked for (radar +
geometry + NN), but it's a first pass, not exhaustive. Natural next
steps if useful:

- A `problem_pipeline.tex` composed figure for the "Why radar?" panel
  (ghost targets / sparse point cloud story).
- A results-table style to match the palette (currently just
  `\MetricBox` for the big numbers).
- Tuning icon line-weights/sizes once you see them at actual A0 scale
  (icons here are tuned for the ~2.1cm card width from the plan; if you
  go with a different card size, some line widths may want scaling up).
