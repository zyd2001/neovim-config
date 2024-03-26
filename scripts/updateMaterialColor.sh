#!/usr/bin/bash
sed '/if g:material_theme_style == '\''palenight'\''/ { N;N; s/\(.*'\''gui'\'': '\''#\)[a-z0-9]\{6\}/\1babed8/g }' -i colors/material.vim
