Looking closely at your `main.py` code from earlier, your architecture actually utilizes only the standalone `encoder.Encoder` module from this framework for temporal aggregation (with `vocab_size=None` and `d_model=192`), bypassing the full sequence-to-sequence `Decoder` and target masking blocks shown in this file.

To give a complete picture on your EUSIPCO poster of how spatial feature extraction feeds into temporal processing, it is highly effective to show how these frames step sequentially through time.

---

### Diagram: The Joint Spatial-Temporal Pipeline (PCT + Encoder)

This diagram illustrates how frame-wise video slices are mapped via your spatial PCT modules into a sequence of feature vectors, which are then passed into the Transformer Encoder block for temporal tracking context.

```mermaid
graph TD
    %% Styling
    classDef input fill:#f5f5f5,stroke:#9e9e9e,stroke-width:2px;
    classDef pct fill:#e1f5fe,stroke:#0288d1,stroke-width:2px;
    classDef tensor fill:#e8f5e9,stroke:#388e3c,stroke-width:2px;
    classDef trans fill:#fff3e0,stroke:#f57c00,stroke-width:2px;

    subgraph Frames [Video Tensor Input Stream]
        In([Radar Track Video: <br/> B x 10 x Features x Points]):::input
    end

    subgraph Spatial [Spatial Point Feature Extraction Loop]
        In -->|Frame t=1| PCT1[PCT Architecture]:::pct
        In -->|Frame t=...| PCTi[PCT Architecture]:::pct
        In -->|Frame t=10| PCT10[PCT Architecture]:::pct
        
        PCT1 -->|Unsqueeze & Cat| Concat[Temporal Sequence Assembly]:::tensor
        PCTi -->|Unsqueeze & Cat| Concat
        PCT10 -->|Unsqueeze & Cat| Concat
    end

    subgraph Temporal [Temporal Context Processing: transformer.Encoder]
        Concat -->|Sequence Shape: B x 10 x 192| PosEnc[Scale Embeddings / Positional Context]:::trans
        PosEnc --> MHA[Multi-Head Attention <br/> n_head=4, d_model=192]:::trans
        MHA --> FFN[Feed Forward Network <br/> Hidden Dim=64, Dropout=0.1]:::trans
        FFN --> LayerNorm[Layer Normalization]:::trans
    end

    subgraph Head [Aggregation & Pooling]
        LayerNorm -->|Shape: B x 10 x 192| AvgPool[Global Average Pooling <br/> AvgPool2d over Sequence Length]:::input
        AvgPool -->|Squeezed Feature Vector: B x 192| Logits[Downstream MAML Projections]:::pct
    end

```

---

### 📌 Poster Formatting Tip for Reviewers

When describing the temporal step in your paper's methodology text, make sure to explicitly mention that **the decoder and casual triangular autoregressive masks are discarded**.

Because your tracking-integrated ISAR task evaluates complete macro-trajectories to classify a target identity, using a **bidirectional encoder-only self-attention layout** allows every frame in the tracking window to capture context from both past and future frames simultaneously. This provides a significantly more robust temporal embedding than standard autoregressive sequence modeling.