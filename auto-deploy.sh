#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
TRIGGER_FILE="$PROJECT_DIR/.deploy-request"
LOG_FILE="$PROJECT_DIR/deploy.log"

cd "$PROJECT_DIR"
rm -f "$TRIGGER_FILE"

run_deploy() {
  echo ""
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] 开始部署最新修改..."
  if bash "$PROJECT_DIR/deploy.sh" 2>&1 | tee -a "$LOG_FILE"; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 部署完成。"
  else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 部署失败，请查看上方错误。" | tee -a "$LOG_FILE"
  fi
}

echo "自动部署助手已启动。请保持这个终端窗口打开。"
run_deploy

while true; do
  if [ -f "$TRIGGER_FILE" ]; then
    rm -f "$TRIGGER_FILE"
    run_deploy
  fi
  sleep 2
done
