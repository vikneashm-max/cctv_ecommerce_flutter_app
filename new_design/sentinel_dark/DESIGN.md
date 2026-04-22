# Design System Document: SecureVision Editorial Authority

## 1. Overview & Creative North Star
### The Creative North Star: "The Digital Sentinel"
To move beyond a generic "app" feel, this design system adopts the persona of **The Digital Sentinel**. We are not just building an eCommerce interface; we are crafting a high-end, editorial command center. The aesthetic rejects the cluttered "grid-of-boxes" found in typical retail and instead embraces **The Layered Command**—a layout strategy using deep tonal shifts, intentional asymmetry, and vast negative space to convey an atmosphere of absolute surveillance and impenetrable security.

We break the "template" look by treating every screen as a premium hardware catalog. Products aren't just listed; they are "presented." We utilize overlapping elements—where a high-definition camera render might bleed over a title—to create a sense of three-dimensional depth and bespoke craftsmanship.

---

## 2. Colors & Surface Architecture

### The Palette of Trust
Our color strategy utilizes the **Primary Blue (#1A73E8)** as a beacon of reliability against a void-like **Dark Slate (#121315)**. 

*   **Primary (#ADC7FF) & Container (#1A73E8):** Use these to signal active security states and "High-Alert" calls to action.
*   **Tertiary (#FFB691):** Reserved exclusively for "Human Elements"—smart alerts, motion detection notifications, or premium support. This warm contrast breaks the coldness of the tech.

### The "No-Line" Rule
**Explicit Instruction:** Designers are prohibited from using 1 px solid borders to define sections. Boundaries must be felt, not seen.
*   **Tonal Sectioning:** Use background shifts (e.g., `surface-container-low` for a product feature section sitting on a `surface` background).
*   **The "Glass & Gradient" Rule:** Floating UI elements (like bottom navigation or camera controls) must use a Glassmorphic treatment: `surface-container` at 70% opacity with a `24px` backdrop-blur. This makes the UI feel integrated into the environment.
*   **Signature Textures:** Apply a subtle linear gradient to main CTAs (from `primary-container` to `primary`) to give them a metallic, machined quality rather than a flat, digital look.

---

## 3. Typography: The Editorial Voice

We utilize **Inter** for its mathematical precision and neutral "engineered" feel. 

*   **Display-LG (3.5rem) / Headline-LG (2rem):** Used sparingly. Headlines should be treated like pull-quotes in a high-end magazine. Use asymmetrical placement—offsetting headlines from the main content column—to create a signature visual rhythm.
*   **Title-MD (1.125rem):** The workhorse for product names. Set these with tighter letter-spacing (-0.02em) to look more authoritative.
*   **Body-LG (1rem):** For descriptions. Ensure line heights are generous (1.6) to provide "breathing room" and ease of scanning during high-stress monitoring.
*   **Label-SM (0.6875rem):** Use all-caps with 0.05em tracking for technical specs (e.g., "4K ULTRA HD"). This mimics industrial labeling on hardware.

---

## 4. Elevation & Depth

### The Layering Principle
Hierarchy is achieved by "stacking" surfaces. We move from the background (The Foundation) to the foreground (The Interaction) using the `surface-container` tiers:
1.  **Level 0 (Foundation):** `surface` (#121315).
2.  **Level 1 (Sections):** `surface-container-low` (#1B1C1E).
3.  **Level 2 (Cards):** `surface-container` (#1F2022).
4.  **Level 3 (Interactive):** `surface-container-high` (#292A2C).

### Ambient Shadows
For floating elements, use "The Invisible Lift." Shadows must be ultra-diffused: 
*   **Values:** `Y: 16px, Blur: 40px, Opacity: 6%`.
*   **Color:** The shadow must be tinted with `primary` or `on-surface` to avoid "dirty" grey cast.

### The "Ghost Border" Fallback
If a border is required for accessibility, it must be a **Ghost Border**: `outline-variant` (#414754) at **15% opacity**. This provides a whisper of structure without breaking the seamless flow.

---

## 5. Components

### Primary Buttons
*   **Style:** `Rounded-LG` (16px).
*   **Fill:** A gradient of `primary-container` to `primary`.
*   **Interaction:** On hover, the container expands slightly (2px) while the shadow intensity increases by 2%, creating a physical "tactile" feedback.

### Input Fields
*   **Style:** Filled containers (`surface-container-highest`) with no bottom line.
*   **States:** On focus, use a 2px `surface-tint` internal glow rather than a thick outer stroke.

### Product Cards & Lists
*   **Constraint:** **Never use dividers.**
*   **Logic:** Separate list items using 12px of vertical white space or a subtle shift from `surface-container-low` to `surface-container-lowest`.
*   **Visual:** Product images should have a `rounded-lg` (16px) radius and a subtle `on-surface` inner glow to make the hardware "pop" from the dark background.

### Security-Specific Components
*   **The "Live Feed" Chip:** A glassmorphic pill with a pulsating `error` (#FFB4AB) dot.
*   **The "Status Ring":** A circular progress indicator using `primary` for "Secure" and `tertiary` for "Attention Required," utilizing a 4px stroke width for an industrial feel.

---

## 6. Do’s and Don’ts

### Do
*   **Do** use extreme negative space. Trust is built through the absence of clutter.
*   **Do** use high-quality, high-contrast photography of security hardware with dramatic rim lighting.
*   **Do** favor vertical rhythm over horizontal density.
*   **Do** use `primary-fixed-dim` for secondary text that still requires high legibility.

### Don’t
*   **Don't** use 100% white (#FFFFFF) for text. Use `on-surface` (#E3E2E5) to prevent eye strain in dark environments.
*   **Don't** use standard Material Design 3 elevation shadows (the dark, heavy ones). Always use the Ambient Shadow specification.
*   **Don't** use iconography from different sets. Stick to high-stroke, geometric security icons to maintain the "Sentinel" aesthetic.
*   **Don't** center-align long blocks of text. Stick to editorial left-alignment to maintain the "column" feel of a high-end document.