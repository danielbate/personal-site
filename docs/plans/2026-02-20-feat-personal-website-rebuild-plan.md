---
title: Personal Website Rebuild
type: feat
date: 2026-02-20
---

# Personal Website Rebuild

## Overview

Rebuild danielbate.com as a single-page Astro static site with a terminal-inspired aesthetic. Replaces the current Vue/Vuetify app. Deployed to Vercel.

Brainstorm: `docs/brainstorms/2026-02-20-personal-website-rebuild-brainstorm.md`

## Proposed Solution

A single `index.astro` page with a centered card containing: name, role/location, interests list, and social text links. Dark/light mode toggle. CSS-only fade-in animations. JetBrains Mono font. Zero JS dependencies beyond a tiny inline theme script.

## Acceptance Criteria

- [x] Single page renders name, role, location, 5 interests, 4 social links
- [x] Dark mode is default; light mode available via toggle
- [x] Theme persists across page loads via `localStorage`
- [x] First visit respects `prefers-color-scheme`
- [x] No flash of wrong theme on load
- [x] Fade-in stagger entrance animation on page load (CSS only)
- [x] Responsive: works on mobile (320px) through desktop
- [x] Lighthouse performance score >= 95
- [x] Static output — no server-side rendering at runtime
- [x] Deploys to Vercel from `main` branch
- [x] All social links open in new tab with `rel="noopener noreferrer"`
- [x] Accessible: proper heading hierarchy, sufficient color contrast, keyboard-navigable toggle, `prefers-reduced-motion` disables animations

## Implementation Plan

### Phase 1: Project scaffold

**Files:**

- `package.json` — Astro dependency, project metadata
- `astro.config.mjs` — static output config, Vercel adapter
- `tsconfig.json` — Astro's strict preset
- `.gitignore` — node_modules, dist, .vercel
- `public/favicon.svg` — simple favicon

**Tasks:**

- [x] `npm create astro@latest` in `personal-website/` directory (empty template, strict TypeScript)
- [x] Install `@astrojs/vercel` adapter
- [x] Configure `astro.config.mjs`: `output: 'static'`, vercel adapter
- [x] Add JetBrains Mono via Google Fonts `<link>` in the layout head

### Phase 2: Layout and theme system

**Files:**

- `src/layouts/Base.astro` — HTML shell, head meta, theme script, font link
- `src/styles/global.css` — CSS custom properties, theme variables, reset, base styles

**Tasks:**

- [x] Create `Base.astro` layout with `<!DOCTYPE html>`, charset, viewport meta, and OG meta tags
- [x] Add inline `<script>` in `<head>` that reads `localStorage` or `prefers-color-scheme` and sets `data-theme` on `<html>` before paint
- [x] Define CSS custom properties for both themes using `[data-theme="dark"]` and `[data-theme="light"]` selectors
- [x] Add minimal CSS reset (box-sizing, margin, font-family)
- [x] Set `<title>` to "Daniel Bate" and add meta description

**Color tokens:**

```css
/* Dark (default) */
--bg: #0d1117;
--card-bg: #161b22;
--text: #e6edf3;
--text-muted: #8b949e;
--accent: #58a6ff;
--border: #30363d;

/* Light */
--bg: #f6f8fa;
--card-bg: #ffffff;
--text: #1f2328;
--text-muted: #656d76;
--accent: #0969da;
--border: #d0d7de;
```

### Phase 3: Index page and card component

**Files:**

- `src/pages/index.astro` — the single page
- `src/components/Card.astro` — the centered card
- `src/components/ThemeToggle.astro` — sun/moon toggle button

**Tasks:**

- [x] Create `Card.astro`: centered container, max-width 640px, border, border-radius 8px, padding
- [x] Create `ThemeToggle.astro`: button with sun/moon SVG, toggles `data-theme` attribute and writes to `localStorage`. Include `aria-label="Toggle theme"`
- [x] Create `index.astro` using `Base` layout containing:
  - `<h1>` — "Daniel Bate" (~2rem bold)
  - `<p>` — "Software Engineer / Bristol, UK" (~1rem muted)
  - Interests list: `<ul>` with no bullets, stacked — Consumer Applications, Agentic AI, ML, Decentralised Tech, Developer Evangelism
  - Social links: `<nav>` with horizontal `<a>` tags — GitHub, X, LinkedIn, Instagram
- [x] All social links: `target="_blank"` and `rel="noopener noreferrer"`
- [x] Theme toggle positioned top-right of card

### Phase 4: Animations

**Files:**

- `src/styles/animations.css` — keyframes and animation classes

**Tasks:**

- [x] Define `@keyframes fadeInUp` — opacity 0→1, translateY 8px→0
- [x] Apply to card container: 600ms ease-out
- [x] Apply stagger to content elements: each child gets incremental `animation-delay` (~100ms apart)
- [x] Wrap all animations in `@media (prefers-reduced-motion: no-preference)` — users who prefer reduced motion see instant content, no animation

### Phase 5: Responsive and polish

**Tasks:**

- [x] Test at 320px, 375px, 768px, 1024px, 1440px widths
- [x] Scale font sizes down on screens < 480px using a media query
- [x] Card gets `width: 100%; padding: 1rem` on mobile (no fixed max-width constraint)
- [x] Verify color contrast ratios meet WCAG AA (4.5:1 for text, 3:1 for large text)
- [x] Add `<meta name="theme-color">` matching dark/light bg for browser chrome

### Phase 6: SEO and meta

**Tasks:**

- [x] Add Open Graph tags: `og:title`, `og:description`, `og:type`, `og:url`
- [x] Add `<meta name="description" content="Daniel Bate — Software Engineer based in Bristol, UK">`
- [x] Add canonical URL `<link rel="canonical" href="https://danielbate.com/">`
- [x] Add `robots.txt` in `public/` (allow all)
- [x] Add `sitemap.xml` via Astro's `@astrojs/sitemap` integration

### Phase 7: Deploy

**Tasks:**

- [x] Initialize git repo, commit all files
- [x] Push to GitHub
- [x] Connect repo to Vercel, configure custom domain `danielbate.com`
- [x] Verify production build: `npm run build && npm run preview`
- [x] Run Lighthouse audit — target >= 95 on all categories

## Technical Considerations

- **No JS framework.** Astro components are server-rendered to static HTML. The only client JS is a tiny inline theme toggle script (~20 lines).
- **Font loading.** Use `font-display: swap` to avoid invisible text during font load. Consider `<link rel="preconnect" href="https://fonts.googleapis.com">` for faster load.
- **Theme flash prevention.** The inline script in `<head>` must run synchronously before first paint. It reads `localStorage`, falls back to `prefers-color-scheme`, and sets `data-theme` immediately.
- **Animation accessibility.** All animations gated behind `prefers-reduced-motion: no-preference`.

## Dependencies

| Package | Purpose |
|---------|---------|
| `astro` | Static site generator |
| `@astrojs/vercel` | Vercel deployment adapter |
| `@astrojs/sitemap` | Auto-generate sitemap.xml |

No other dependencies. Font loaded from Google Fonts CDN.

## References

- Astro docs: https://docs.astro.build
- Vercel Astro adapter: https://docs.astro.build/en/guides/deploy/vercel/
- JetBrains Mono: https://fonts.google.com/specimen/JetBrains+Mono
