#!/bin/bash
# ============================================================
# 批量修改 .pw.toml 元数据
#   1. side 值统一改为 'both'
#   2. Modrinth 源: URL 改为 FileHub 中对应目录的文件链接
#   3. 删除 [update.modrinth] 表及其内容
#   4. CurseForge 源: 删除空的 url = '' 行
#
# 用法: bash ./fix-metadata.sh
# ============================================================
set -euo pipefail

TARGET_DIRS=("mods" "resourcepacks" "shaderpacks")
FILEHUB_BASE_URL="https://file.dark2932.cc/files/modrinth-resources"
TOTAL=0

urlencode_segment() {
  local LC_ALL=C
  local input="$1"
  local output=""
  local char encoded
  local i

  for ((i = 0; i < ${#input}; i++)); do
    char="${input:i:1}"
    case "$char" in
      [a-zA-Z0-9.~_-]) output+="$char" ;;
      *)
        printf -v encoded '%%%02X' "'$char"
        output+="$encoded"
        ;;
    esac
  done

  printf '%s' "$output"
}

for dir in "${TARGET_DIRS[@]}"; do
  if [ ! -d "$dir" ]; then
    echo "[skip] $dir: directory not found"
    continue
  fi

  while IFS= read -r -d '' file; do
    echo "  $file"

    # 1. side → 'both'（匹配 side = '' / 'client' / 'server' / 'both'）
    sed -i "s/^side = '.*'/side = 'both'/" "$file"

    if grep -q '^\[update\.modrinth\][[:space:]]*$' "$file"; then
      filename="$(sed -n "s/^filename = '\(.*\)'[[:space:]]*$/\1/p" "$file" | head -n 1)"
      if [ -z "$filename" ]; then
        echo "[error] $file: filename is missing" >&2
        exit 1
      fi

      # 2. Modrinth 文件改用 FileHub 链接，并按资源类型保留目录结构
      encoded_filename="$(urlencode_segment "$filename")"
      filehub_url="${FILEHUB_BASE_URL}/${dir}/${encoded_filename}"
      sed -i "s|^url = '.*'$|url = '${filehub_url}'|" "$file"

      # 3. 删除 [update.modrinth] 表，保留下一个 TOML 表及其内容
      sed -i '/^\[update\.modrinth\][[:space:]]*$/,/^\[/ {
        /^\[update\.modrinth\][[:space:]]*$/d
        /^\[/!d
      }' "$file"
    fi

    # 4. CurseForge: 删除空 url 行
    sed -i "/^url = ''\$/d" "$file"

    TOTAL=$((TOTAL + 1))
  done < <(find "$dir" -name "*.pw.toml" -type f -print0)
done

echo ""
echo "Done. Processed $TOTAL file(s)."
