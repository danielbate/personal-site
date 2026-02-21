#!/usr/bin/env bash
set -euo pipefail

if [[ -f .env ]]; then
  source .env
elif [[ -z "${SSH_HOST:-}" ]]; then
  echo "Error: No .env file and no SSH_HOST env var set."
  echo "Copy .env.example to .env and fill in your values."
  exit 1
fi

DRY_RUN=""
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN="--dry-run"
  echo "Dry run mode — no files will be transferred"
fi

pnpm build

mkdir -p ~/.ssh
ssh-keyscan -p "${SSH_PORT}" "${SSH_HOST}" >> ~/.ssh/known_hosts 2>/dev/null

echo "Deploying dist/ to ${SSH_HOST}:${SSH_PATH}"

if [[ -n "${SSH_PASS:-}" ]]; then
  if ! command -v sshpass &>/dev/null; then
    echo "Error: sshpass is required when SSH_PASS is set."
    echo "Install with: brew install hudochenkov/sshpass/sshpass"
    exit 1
  fi
  SSHPASS="$SSH_PASS" sshpass -e rsync -avz --delete $DRY_RUN \
    -e "ssh -p ${SSH_PORT}" \
    dist/ "${SSH_USER}@${SSH_HOST}:${SSH_PATH}"
else
  rsync -avz --delete $DRY_RUN \
    -e "ssh -p ${SSH_PORT}" \
    dist/ "${SSH_USER}@${SSH_HOST}:${SSH_PATH}"
fi

echo "Done"
