#!/usr/bin/env bash
set -euo pipefail

SITE_URL="https://danbate.dev"
ERRORS=0

check() {
  local label="$1"
  local ok="$2"
  if [[ "$ok" == "true" ]]; then
    echo "  PASS  $label"
  else
    echo "  FAIL  $label"
    ERRORS=$((ERRORS + 1))
  fi
}

echo "Checking ${SITE_URL}"
echo ""

RESPONSE=$(curl -sI -o /dev/null -w "%{http_code}|%{redirect_url}|%{ssl_verify_result}" "$SITE_URL" 2>/dev/null)
HTTP_CODE=$(echo "$RESPONSE" | cut -d'|' -f1)
SSL_OK=$(echo "$RESPONSE" | cut -d'|' -f3)

check "HTTP status is 200" "$([[ "$HTTP_CODE" == "200" ]] && echo true || echo false)"
check "SSL certificate valid" "$([[ "$SSL_OK" == "0" ]] && echo true || echo false)"

SERVER=$(curl -sI "$SITE_URL" 2>/dev/null | grep -i "^server:" | tr -d '\r')
IS_IONOS=$([[ "$SERVER" != *"Netlify"* && "$SERVER" != *"Vercel"* && "$SERVER" != *"cloudflare"* ]] && echo true || echo false)
check "Not served by third party (${SERVER:-unknown})" "$IS_IONOS"

BODY=$(curl -s "$SITE_URL" 2>/dev/null)
HAS_HTML=$([[ "$BODY" == *"<html"* || "$BODY" == *"<!DOCTYPE"* || "$BODY" == *"<!doctype"* ]] && echo true || echo false)
check "Response contains HTML" "$HAS_HTML"

SITEMAP_CODE=$(curl -sI -o /dev/null -w "%{http_code}" "${SITE_URL}/sitemap-index.xml" 2>/dev/null)
check "Sitemap accessible" "$([[ "$SITEMAP_CODE" == "200" ]] && echo true || echo false)"

echo ""
if [[ "$ERRORS" -eq 0 ]]; then
  echo "All checks passed"
else
  echo "${ERRORS} check(s) failed"
  exit 1
fi
