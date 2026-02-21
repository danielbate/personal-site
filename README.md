# Personal Website

Source for [danbate.dev](https://danbate.dev). Built with [Astro](https://astro.build).

## Setup

```sh
pnpm install
git config core.hooksPath hooks
```

## Development

```sh
pnpm dev
```

Runs a local dev server at `localhost:4321`.

## Deployment

Pushes to `main` trigger CI/CD via GitHub Actions.

To deploy manually:

```sh
cp .env.example .env  # fill in SSH credentials
./scripts/deploy.sh
```