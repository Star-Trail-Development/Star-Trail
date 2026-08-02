#!/bin/bash
# ============================================================
# 批量修改 .pw.toml 元数据
#   1. side 值统一改为 'both'
#   2. Modrinth 源: cdn.modrinth.com → mod.mcimirror.top
#   3. CurseForge 源: 删除空的 url = '' 行
#
# 用法: bash ./fix-metadata.sh
# ============================================================
set -euo pipefail

TARGET_DIRS=("mods" "resourcepacks" "shaderpacks")
TOTAL=0

for dir in "${TARGET_DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "[skip] $dir: directory not found"
    continue
  fi

  while IFS= read -r -d '' file; do
    echo "  $file"

    # 1. side → 'both'（匹配 side = '' / 'client' / 'server' / 'both'）
    sed -i "s/^side = '.*'/side = 'both'/" "$file"

    # 2. Modrinth CDN 换源
    sed -i "s|cdn\.modrinth\.com|mod.mcimirror.top|g" "$file"

    # 3. CurseForge: 删除空 url 行
    sed -i "/^url = ''\$/d" "$file"

    TOTAL=$((TOTAL + 1))
  done < <(find "$dir" -name "*.pw.toml" -type f -print0)
done

echo ""
echo "Done. Processed $TOTAL file(s)."
