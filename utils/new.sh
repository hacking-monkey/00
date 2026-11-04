#!/bin/bash
set -e

hex=$(head -c 15 /dev/urandom | xxd -p | tr -d '\n')

v_dec=$((16#${hex:13:1}))
case $((v_dec % 4)) in
  0) v_new=8 ;;
  1) v_new=9 ;;
  2) v_new=a ;;
  3) v_new=b ;;
esac

uuid="${hex:0:6}-${hex:6:4}-4${hex:10:3}-${v_new}${hex:14:3}-${hex:17:12}"

p=${uuid:0:2}
pl=${uuid:2}

dir="./src/$p/"
mkdir -p "$dir"

path="${dir}${pl}.md"

if [ -f "$path" ]; then
  echo "Path already exists: $path" >&2
  exit 1
fi

git_name=$(git config user.name 2>/dev/null)
if [ -z "$git_name" ]; then
  git_name="new.sh"
fi

cat > "$path" <<EOF
---
title: 00$uuid
description:
author: $git_name
license: CC BY 4.0
create_at: $(date +"%Y-%m-%d")
---

##
EOF

echo "$path"
