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

Pushes to `main` trigger CI/CD via GitHub Actions, which builds the site and deploys to IONOS via rsync.

To deploy manually:

```sh
cp .env.example .env  # fill in SSH credentials
./scripts/deploy.sh
```

To verify a deployment:

```sh
./scripts/check-deploy.sh
```
