#!/usr/bin/env bash
set -euo pipefail

# スクリプト自身のあるディレクトリ（scripts）を取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# プロジェクトルート（scripts の一つ上）を想定
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
# prisma フォルダは apps/api/prisma にある、という想定
PRISMA_DIR="$PROJECT_ROOT/prisma"
MIG_DIR="$PROJECT_ROOT/migrations"

# 以降、PRISMA_DIR／MIG_DIR を使う
# 使い方チェック
if [ $# -ne 1 ]; then
  echo "Usage: $0 <migration-name>"
  exit 1
fi

NAME="$1"

# 最新番号検出
LATEST=$(ls "$MIG_DIR" \
  | grep -E '^[0-9]{4}' \
  | cut -c1-4 \
  | sort -n \
  | tail -n1 \
  || echo "0000")
NEXT_NUM=$((10#$LATEST + 1))
PREFIX=$(printf "%04d" "$NEXT_NUM")
MIG_FILE="$MIG_DIR/${PREFIX}_${NAME}.sql"
OLD_SCHEMA="$PRISMA_DIR/old_schema.prisma"
NEW_SCHEMA="$PRISMA_DIR/schema.prisma"

echo "→ Pulling current D1 schema…"
pnpm prisma db pull --print > "$OLD_SCHEMA"
sed -i '1,2d' "$OLD_SCHEMA"

echo "→ Generating diff SQL…"
pnpm prisma migrate diff \
  --from-schema-datamodel="$OLD_SCHEMA" \
  --to-schema-datamodel="$NEW_SCHEMA" \
  --script \
  > "$MIG_FILE"
sed -i '1,1d' "$MIG_FILE"

echo "→ Cleaning up…"
rm "$OLD_SCHEMA"

echo "✅ Migration generated at $MIG_FILE"