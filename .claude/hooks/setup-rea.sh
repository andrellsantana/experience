#!/usr/bin/env bash
# Instala o REA e o conecta ao Claude Code no início de cada sessão.
# Idempotente: se o registro e a skill já existem, não faz nada.
set -u
REA_VERSION="6.8.0"

if grep -q "rea-agents@${REA_VERSION}" "$HOME/.claude.json" 2>/dev/null \
  && [ -f "$HOME/.claude/skills/reverse-engineer-anything/SKILL.md" ]; then
  exit 0
fi

if npx -y "rea-agents@${REA_VERSION}" setup --client claude_code --yes --format json >/dev/null 2>&1; then
  echo "REA ${REA_VERSION} configurado para o Claude Code."
else
  echo "Aviso: falha ao configurar o REA (sessão segue sem ele)." >&2
fi
exit 0
