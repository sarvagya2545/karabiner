#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
cd ~/dotfiles/karabiner/.config/karabiner
ERROR_OUTPUT=$({ npm run build && launchctl kickstart -k gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server; } 2>&1)

if [ $? -eq 0 ]; then
  osascript -e 'display notification "Rules rebuilt and reloaded" with title "Karabiner"'
else
  SAFE_ERROR=$(echo "$ERROR_OUTPUT" | tail -c 200 | tr '\n' ' ' | sed 's/"/\\"/g')
  osascript -e "display notification \"$SAFE_ERROR\" with title \"Karabiner Build Failed\" sound name \"Basso\""
fi
