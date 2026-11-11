#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
touch "$PROJECT_DIR/.deploy-request"
echo "已请求部署，自动部署助手会立即发布最新修改。"
