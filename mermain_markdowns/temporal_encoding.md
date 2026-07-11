This `Encoder` script explicitly completes your temporal processing layer block. Your code comments reveal a critical detail for your EUSIPCO paper: `vocab_size` is evaluated as `None` in `main.py` because you are bypassing token/word text embedding. Instead, your frame-wise output features from the `PCT` act directly as your spatial embeddings, meaning `TransformerEmbedding` is strictly applying **Positional Encoding** and dropout to preserve the temporal tracking sequence order.

Here is the structurally complete block diagram detailing the internal mechanics of your temporal `Encoder` stage.

---

### Diagram: Internal Architecture of the `Encoder` Module

This details the embedding bypass logic and the iterative module loop handling your stacked `EncoderLayer` sub-modules.

```mermaid
graph TD
    %% Styling
    classDef io fill:#f5f5f5,stroke:#9e9e9e,stroke-width:2px;
    classDef embedding fill:#ede7f6,stroke:#5e35b1,stroke-width:2px;
    classDef stack fill:#fff3e0,stroke:#f57c00,stroke-width:2px;
    classDef skipped fill:#ffebee,stroke:#c62828,stroke-width:1px,stroke-dasharray: 5 5;

    In([Input Tensor from PCT <br/> B x 10 x 192]):::io --> Emb[TransformerEmbedding Module]:::embedding
    
    subgraph InsideEmbedding [TransformerEmbedding Mechanics]
        Emb --> TokenEmb[Token/Vocab Embedding]:::skipped
        Emb --> PosEnc[Positional Encoding <br/> Max Len = 10]:::embedding
        
        Note[vocab_size=None: <br/> Bypasses Token Embedding <br/> Multiplies directly with Positional order] .- TokenEmb
        PosEnc --> Add[Combine & Apply Dropout]:::embedding
    end

    Add -->|Shape: B x 10 x 192| LayerLoop{Loop Over n_layers}
    
    subgraph LayerStack [Stacked Feature Learning Blocks]
        LayerLoop -->|Layer 1| EncLayer1[EncoderLayer 1]:::stack
        EncLayer1 -->|Layer ...| EncLayeri[EncoderLayer ...]:::stack
        EncLayeri -->|Layer N| EncLayerN[EncoderLayer N]:::stack
        
        subgraph InsideLayer [Each EncoderLayer Components]
            EncLayer1 -.-> MHA[Multi-Head Attention <br/> n_head = 4]
            MHA -.-> AddNorm1[Residual Add & LayerNorm]
            AddNorm1 -.-> FFN[Positionwise Feed Forward <br/> Hidden Dim = 64]
            FFN -.-> AddNorm2[Residual Add & LayerNorm]
        end
    end

    EncLayerN -->|Shape: B x 10 x 192| Out([Output Contextual Tracking Matrix]):::io

```

---

### 📝 Strategic Technical Insight for Your Poster:

Because your inputs represent continuous physical tracking measurements from radar frames rather than discrete NLP language variables, emphasize in your architectural methodology section that:

1. **Feature Alignment:** The continuous point cloud structural features extracted via your spatial `PCT` framework align directly with the temporal transformer matrix space without requiring quantization matrices.
2. **Positional Injection:** The positional encoding step is vital because standard self-attention blocks are permutation invariant; injecting the sinusoidal coordinate markers guarantees that your meta-learner recognizes the true temporal chronographical trajectory of the target's movement.