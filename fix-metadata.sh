#!/bin/bash
# ============================================================
# 批量整理 .pw.toml 元数据
#   1. side 值统一为 'both'
#   2. CurseForge 元数据下载模式改为 url
#   3. 所有资源的 url 指向 FileHub 对应目录
#   4. 仅保留 filename、name、side 和 [download] 内容
#
# 用法: bash ./fix-metadata.sh
# ============================================================
set -euo pipefail

TARGET_DIRS=("mods" "resourcepacks" "shaderpacks")
FILEHUB_BASE_URL="https://file.dark2932.cc/files"
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
        printf -v encoded '%%%02X' "'${char}"
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

    filename_line="$(sed -n '/^filename[[:space:]]*=/p' "$file" | head -n 1)"
    name_line="$(sed -n '/^name[[:space:]]*=/p' "$file" | head -n 1)"
    filename="$(sed -n "s/^filename = '\(.*\)'[[:space:]]*$/\1/p" "$file" | head -n 1)"

    if [ -z "$filename_line" ] || [ -z "$name_line" ] || [ -z "$filename" ]; then
      echo "[error] $file: filename/name is missing or malformed" >&2
      exit 1
    fi

    encoded_filename="$(urlencode_segment "$filename")"
    filehub_url="${FILEHUB_BASE_URL}/${dir}/${encoded_filename}"
    tmp_file="${file}.tmp"

    {
      printf '%s\n' "$filename_line"
      printf '%s\n' "$name_line"
      printf "side = 'both'\n\n"
      awk '
        BEGIN { in_download = 0; found_download = 0 }
        /^\[download\][[:space:]]*$/ {
          in_download = 1
          found_download = 1
          print
          next
        }
        in_download && /^\[/ { exit }
        in_download {
          if ($0 ~ /^[[:space:]]*mode[[:space:]]*=/ || $0 ~ /^[[:space:]]*url[[:space:]]*=/) next
          print
        }
        END {
          if (!found_download) exit 2
        }
      ' "$file"
      printf "mode = 'url'\n"
      printf "url = '%s'\n" "$filehub_url"
    } > "$tmp_file"

    mv "$tmp_file" "$file"
    TOTAL=$((TOTAL + 1))
  done < <(find "$dir" -name '*.pw.toml' -type f -print0)
done

echo ""
echo "Done. Processed $TOTAL file(s)."
