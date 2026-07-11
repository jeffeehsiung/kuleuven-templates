This `EncoderLayer` code implements the classic Transformer block architecture using a Post-Layer Normalization (Post-LN) scheme. It cleanly manages the dual-sublayer layout: the Multi-Head Self-Attention sublayer and the Positionwise Feed-Forward Network (FFN) sublayer.

For your EUSIPCO conference poster, mapping the precise execution flow of these residual paths (`x + _x`), dropout steps, and normalization components is critical to demonstrating how you preserve gradients through the deep temporal layer.

---

### Diagram: Detailed Architecture of the `EncoderLayer` Block

This diagram captures your step-by-step tensor routing, showing where cloning (`_x = x`), operations, dropouts, and residual additions occur.

```mermaid
graph TD
    %% Styling
    classDef io fill:#f5f5f5,stroke:#9e9e9e,stroke-width:2px;
    classDef sublayer fill:#fff3e0,stroke:#f57c00,stroke-width:2px;
    classDef regularization fill:#ffebee,stroke:#c62828,stroke-width:2px;
    classDef norm fill:#e8f5e9,stroke:#388e3c,stroke-width:2px;

    In([Input Sequence <br/> B x 10 x 192]):::io --> Split1{Clone Tensor _x}
    
    %% Sublayer 1: Attention
    Split1 -->|x| MHA[Multi-Head Self-Attention <br/> q=x, k=x, v=x]:::sublayer
    MHA --> DP1[Dropout 1 <br/> p=drop_prob]:::regularization
    
    %% Residual & Norm 1
    Split1 -->|_x| Add1((+ <br/> Residual Connection))
    DP1 -->|x| Add1
    Add1 --> LN1[LayerNorm 1]:::norm

    %% Sublayer 2: FFN
    LN1 -->|x| Split2{Clone Tensor _x}
    Split2 -->|x| FFN[Positionwise Feed Forward <br/> Hidden Dim = 64]:::sublayer
    FFN --> DP2[Dropout 2 <br/> p=drop_prob]:::regularization
    
    %% Residual & Norm 2
    Split2 -->|_x| Add2((+ <br/> Residual Connection))
    DP2 -->|x| Add2
    Add2 --> LN2[LayerNorm 2]:::norm
    
    LN2 --> Out([Output Sequence Vector <br/> B x 10 x 192]):::io

```

---

### 💡 Poster Content & Discussion Tip

* **Post-LN vs. Pre-LN:** Your script implements classic **Post-LN** (where LayerNorm is applied *after* adding the residual connection: `self.norm1(x + _x)`). In your poster presentation or discussion, if a reviewer asks about training stability, you can note that since your temporal encoder is a highly focused $N=1$ layer network (`n_layers=1` in `main.py`), Post-LN provides excellent representational capacity without suffering from the vanishing/exploding gradient constraints often found in deeply stacked (e.g., 12+ layers) architectures.
* **Parameter Sizing:** Explicitly display the compact parameters on the poster layout text: $d_{\text{model}} = 192$, $d_{\text{ffn}} = 64$, and $\text{heads} = 4$. Showing this lean design proves you have tailored the capacity specifically for high-rate episodic radar sample constraints, preventing overfitting on your few-shot tracking classes.