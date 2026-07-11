For an academic conference poster like EUSIPCO, you need two distinct types of diagrams:

1. **The Model Architecture Diagram:** Explaining how frame-wise point cloud data passes through the spatial PCT and temporal Transformer encoder.
2. **The Optimization/Training Flow Diagram:** Explaining the MAML meta-learning episodic setup (Inner Loop Task Adaptation vs. Outer Loop Meta-Update).

Here are the custom Mermaid scripts generated directly from your code structure.

---

### Diagram 1: The `PCT_Transformer` Architecture

This maps out your neural network design. It details the permutation, the temporal frame loop parsing into the `PCT` block, sequence reconstruction, and downstream classification blocks.

```mermaid
graph TD
    %% Styling
    classDef input fill:#f5f5f5,stroke:#9e9e9e,stroke-width:2px;
    classDef spatial fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef temporal fill:#e8f5e9,stroke:#388e3c,stroke-width:2px;
    classDef dense fill:#fff3e0,stroke:#f57c00,stroke-width:2px;

    In([Input Radar Video Tensor: <br/> B x Frames x Features x Points]):::input --> Perm[Permute Layers <br/> B x Frames x Points x Features]:::input
    
    subgraph SpatialBlock [Frame-wise Spatial Feature Extraction]
        Perm --> Split{Loop Over Time T}
        Split -->|Frame 1| PCT1[Point Cloud Transformer: PCT]:::spatial
        Split -->|Frame ...| PCTi[Point Cloud Transformer: PCT]:::spatial
        Split -->|Frame 10| PCT10[Point Cloud Transformer: PCT]:::spatial
        
        PCT1 --> Cat[torch.cat along Sequence Dim]
        PCTi --> Cat
        PCT10 --> Cat
    end

    subgraph TemporalBlock [Temporal Feature Extraction]
        Cat -->|Shape: B x 10 x 192| TransEncoder[Transformer Encoder <br/> n_head=4, d_model=192, layers=1]:::temporal
        TransEncoder --> AvgPool[Global Average Pooling <br/> AvgPool2d & Squeeze]:::temporal
    end

    subgraph Classifier [Classification Head / Projection]
        AvgPool --> DP1[Dropout p=args.dropout]:::dense
        DP1 --> Lin2[Linear Layer <br/> 192 -> 64]:::dense
        Lin2 --> BN7[BatchNorm1d 64]:::dense
        BN7 --> Act[LeakyReLU negative_slope=0.2]:::dense
        Act --> DP2[Dropout p=args.dropout]:::dense
        DP2 --> Lin3[Linear Layer <br/> 64 -> args.num_classes]:::dense
        Lin3 --> Out([Logits / Output Classification]):::dense
    end

```

---

### Diagram 2: The MAML Episodic Meta-Learning Pipeline

This diagram explains your `fast_adapt` function and `main` training loop block, showing how the support and query setups feed your optimization loops.

```mermaid
graph TD
    %% Styling
    classDef data fill:#ede7f6,stroke:#5e35b1,stroke-width:2px;
    classDef inner fill:#fffde7,stroke:#fbc02d,stroke-width:2px;
    classDef outer fill:#fce4ec,stroke:#c2185b,stroke-width:2px;

    subgraph TaskGen [Episodic Batch Generation]
        RawData[(Radar Datasets Mix)]:::data --> TaskSets[learn2learn TaskDataset <br/> 3-Way 10-Shot Interface]:::data
        TaskSets -->|Sample Task Batch| Batch[Episodic Task Batch]:::data
        Batch -->|Split 50/50| Support[Adaptation Set <br/> shots x ways]:::data
        Batch -->|Split 50/50| Query[Evaluation Set <br/> shots x ways]:::data
    end

    subgraph InnerLoop [Inner Loop: Task-Specific Adaptation]
        InitWeights[Meta-Model Parameters θ]:::outer -->|maml.clone| Clone[Learner Parameter θ']:::inner
        Support --> CrossEnt1[Smooth Cross Entropy Loss]:::inner
        Clone --> CrossEnt1
        CrossEnt1 -->|learner.adapt| GradUpdate[Backpropagation & Local SGD]:::inner
        GradUpdate -->|Updates| Clone
    end

    subgraph OuterLoop [Outer Loop: Meta-Optimization]
        Query --> CrossEnt2[Evaluation Meta-Loss]:::outer
        Clone --> CrossEnt2
        CrossEnt2 -->|evaluation_error.backward| AccumGrads[Accumulate Gradients across Meta-Batch]:::outer
        AccumGrads -->|opt.step using SGD| MetaUpdate[Update Global Meta-Weights θ]:::outer
        MetaUpdate -->|Refreshes| InitWeights
    end

```

---

### 💡 Academic Presentation Tips for EUSIPCO:

* **Vector Quality:** Do not use rasterized (.png/.jpg) screenshots of diagrams for a giant print poster. Copy these codes into a renderer tool (like `mermaid.live`) and export them as an **SVG** file. SVGs maintain perfect vector sharpness at A0 print scales.
* **Colors matching text:** Match the colors of your text headers on the poster to the background blocks of your architecture (e.g., if you talk about "Spatial Point Cloud Embeddings" in your methods section, give that text box the same light blue tint used in the diagram).

Whenever you are ready, go ahead and drop `point_cloud_transformer.py`! I can parse its sub-modules to break down the interior mechanisms of that block.