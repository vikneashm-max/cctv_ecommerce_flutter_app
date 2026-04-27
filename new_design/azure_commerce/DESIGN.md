---
name: Azure Commerce
colors:
  surface: '#f9f9fc'
  surface-dim: '#dadadc'
  surface-bright: '#f9f9fc'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f6'
  surface-container: '#eeeef0'
  surface-container-high: '#e8e8ea'
  surface-container-highest: '#e2e2e5'
  on-surface: '#1a1c1e'
  on-surface-variant: '#434656'
  inverse-surface: '#2f3133'
  inverse-on-surface: '#f0f0f3'
  outline: '#737688'
  outline-variant: '#c3c5d9'
  surface-tint: '#004ced'
  primary: '#003ec7'
  on-primary: '#ffffff'
  primary-container: '#0052ff'
  on-primary-container: '#dfe3ff'
  inverse-primary: '#b7c4ff'
  secondary: '#5a5f68'
  on-secondary: '#ffffff'
  secondary-container: '#dee2ed'
  on-secondary-container: '#60656e'
  tertiary: '#952200'
  on-tertiary: '#ffffff'
  tertiary-container: '#bf3003'
  on-tertiary-container: '#ffddd5'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#dde1ff'
  primary-fixed-dim: '#b7c4ff'
  on-primary-fixed: '#001452'
  on-primary-fixed-variant: '#0038b6'
  secondary-fixed: '#dee2ed'
  secondary-fixed-dim: '#c2c6d1'
  on-secondary-fixed: '#171c23'
  on-secondary-fixed-variant: '#424750'
  tertiary-fixed: '#ffdbd2'
  tertiary-fixed-dim: '#ffb4a1'
  on-tertiary-fixed: '#3c0800'
  on-tertiary-fixed-variant: '#891e00'
  background: '#f9f9fc'
  on-background: '#1a1c1e'
  surface-variant: '#e2e2e5'
typography:
  h1:
    fontFamily: Manrope
    fontSize: 32px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  h2:
    fontFamily: Manrope
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.3'
    letterSpacing: -0.01em
  h3:
    fontFamily: Manrope
    fontSize: 20px
    fontWeight: '600'
    lineHeight: '1.4'
    letterSpacing: '0'
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.6'
    letterSpacing: '0'
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.5'
    letterSpacing: '0'
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1.0'
    letterSpacing: 0.05em
  button:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: '1.0'
    letterSpacing: 0.01em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 4px
  xs: 8px
  sm: 12px
  md: 16px
  lg: 24px
  xl: 32px
  container-margin: 16px
  gutter: 12px
---

## Brand & Style

This design system is built on a foundation of **Corporate Modernism**, tailored specifically for high-trust e-commerce environments. The brand personality is efficient, reliable, and transparent, aiming to reduce the cognitive load of the shopping experience. 

The aesthetic prioritizes clarity through generous whitespace and a disciplined color application. By utilizing a "Content-First" philosophy, the UI recedes into the background, allowing product imagery to serve as the primary visual driver while blue accents guide the user toward conversion points with surgical precision.

## Colors

The palette is anchored by a high-chroma "Clear Blue" primary, selected for its association with security and digital native proficiency. 

- **Primary (#0052FF):** Reserved exclusively for primary calls to action, active states, and critical progress indicators.
- **Secondary (#F0F4FF):** A soft tint used for decorative accents, badge backgrounds, and selected list items to provide subtle contrast without competing with the primary action.
- **Neutral (#1A1C1E):** A deep charcoal for text and icons, providing better readability than pure black.
- **Background (#F8F9FA):** An off-white "Paper" tone that reduces glare and distinguishes the app's canvas from the white cards containing product information.

## Typography

The typography strategy employs a dual-typeface system to balance character with utility. 

**Manrope** is used for headlines to provide a modern, geometric touch that feels welcoming yet engineered. **Inter** is utilized for all body copy, labels, and data-heavy interfaces due to its exceptional legibility at small sizes and neutral, systematic character. 

Hierarchy is established through weight shifts rather than dramatic size changes, maintaining a compact and professional information density suitable for mobile commerce.

## Layout & Spacing

This design system utilizes a **Fluid Grid** model based on an 8-point rhythmic scale. For mobile layouts, a 4-column grid is standard, transitioning to 12 columns for tablet and desktop views.

- **Margins:** A consistent 16px lateral margin ensures content does not bleed to the edge of the device.
- **Internal Spacing:** Components use "Stack" and "Inset" patterns. A standard 16px (md) padding is used for card containers, while 8px (xs) or 12px (sm) is used for tighter groupings like product metadata.
- **Rhythm:** Vertical rhythm is maintained by ensuring all heights and margins are multiples of the 4px base unit.

## Elevation & Depth

Visual hierarchy in this design system is achieved through **Tonal Layering** and **Ambient Shadows**. 

1.  **Level 0 (Base):** The #F8F9FA background.
2.  **Level 1 (Cards):** Pure white (#FFFFFF) surfaces with a subtle 1px stroke (#E9ECEF) or an extremely soft, diffused shadow (0px 4px 20px rgba(0, 0, 0, 0.04)).
3.  **Level 2 (Modals/Overlays):** These use a more pronounced shadow (0px 12px 32px rgba(0, 0, 0, 0.08)) to indicate temporary interaction layers.

Avoid heavy blurs or glassmorphism to keep the interface looking fast and performance-oriented. Depth should feel physical but understated.

## Shapes

The design system adopts a **Soft** shape language. This "Low-Radius" approach (0.25rem to 0.75rem) maintains a professional, organized structure while removing the harshness of sharp corners. 

Buttons and input fields should utilize the standard 4px (0.25rem) radius. Larger containers, such as product cards or bottom sheets, should use the 12px (0.75rem) radius to create a distinct visual container that feels friendly and approachable.

## Components

- **Buttons:** Primary buttons use a solid Clear Blue fill with white text. Secondary buttons use a Clear Blue border with blue text. "Add to Cart" actions should be full-width on mobile to maximize hit area.
- **Input Fields:** Use a subtle light gray border (#DEE2E6) that thickens and changes to Clear Blue on focus. Labels should be docked above the field in `label-caps` style.
- **Cards:** Product cards must be white with a very thin border. The image should occupy the top half, with a 12px padding for the product name and price details below.
- **Chips:** Used for category filtering and sizes. These use the `secondary` blue color for the background with a 100px (pill) radius for high tapability.
- **Lists:** Clean rows separated by a 1px #F1F3F5 divider. Chevron icons should be used to indicate drill-down navigation, tinted in a medium-gray.
- **Checkout Progress:** A custom component using a thin blue line and numbered circles to clearly demystify the multi-step purchasing process.