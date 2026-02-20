# Personal Website Rebuild

**Date:** 2026-02-20
**Status:** Approved

## What We're Building

A single-page personal website for Daniel Bate — software engineer based in Bristol, UK. The site advertises who Dan is, his interests, and links to his social profiles. Nothing more.

## Why This Approach

The current site is a Vue/Vuetify app with a contact form. It's overengineered for what it does. The rebuild strips it down to a single static page with a terminal-inspired aesthetic — monospace typography, dark/green color palette — without literal terminal UI elements (no fake commands, no window chrome).

Astro was chosen for static generation: zero JS by default, fast builds, easy Vercel deploys. No UI framework needed for a single page.

## Key Decisions

- **Framework:** Astro (static output)
- **Hosting:** Vercel
- **Contact:** No form. Social links only.
- **Socials:** GitHub, X, LinkedIn, Instagram (text links, not icons)
- **Style:** Terminal-inspired — monospace font, dark/cyan palette — but clean and minimal, not a literal terminal
- **Theme:** Dark and light mode with a toggle (sun/moon)
- **Animation:** Fade-in with stagger on page load (CSS only, no JS animation library)
- **Content:** Name, role/location, interests list, social links

## Design Specification

### Layout

Full viewport height, vertically and horizontally centered card.

```
+----------------------------------------------+
|                                          [*]  |
|                                               |
|  Daniel Bate                                  |
|  Software Engineer / Bristol, UK              |
|                                               |
|  Consumer Applications                        |
|  Agentic AI                                   |
|  ML                                           |
|  Decentralised Tech                           |
|  Developer Evangelism                          |
|                                               |
|  GitHub   X   LinkedIn   Instagram            |
|                                               |
+----------------------------------------------+
```

- `[*]` = theme toggle (sun/moon)
- Name is the largest text element
- Role/location is secondary, smaller
- Interests are a stacked list, no bullets
- Social links are a horizontal row of text links

### Typography

- **Font:** JetBrains Mono (Google Fonts)
- Monospace throughout
- Name: ~2rem bold
- Role/location: ~1rem, muted color
- Interests: ~0.9rem
- Social links: ~0.9rem

### Colors

**Dark mode (default):**
- Background: #0d1117
- Card background: #161b22
- Primary text: #e6edf3
- Accent/links: #58a6ff
- Muted text: #8b949e

**Light mode:**
- Background: #f6f8fa
- Card background: #ffffff
- Primary text: #1f2328
- Accent/links: #0969da
- Muted text: #656d76

### Card

- Max-width: 640px
- Subtle border (1px, muted color)
- Small border-radius (~8px)
- Slight box-shadow in light mode, none in dark

### Theme Toggle

- Small sun/moon icon in top-right of card
- Toggles a `data-theme` attribute on `<html>`
- Persists choice to `localStorage`
- Respects `prefers-color-scheme` on first visit
- Tiny inline `<script>` in `<head>` to prevent flash of wrong theme

### Entrance Animation

- Card: fade-in + translate-up (~8px), 600ms ease-out
- Content lines: stagger-fade with ~100ms delay between each line
- Pure CSS using `@keyframes` and `animation-delay`

### Responsive

- Card fills viewport width with 1rem padding on mobile
- Font sizes scale down slightly on screens < 480px
- Layout remains single-column at all sizes

## Open Questions

None — scope is intentionally minimal.
