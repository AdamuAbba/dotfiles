#!/bin/bash

ACTIVE_WORKSPACE="$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')"
if [ -f /tmp/workspace_active_tmp ]; then
  rm /tmp/workspace_active_tmp
fi
echo "$ACTIVE_WORKSPACE" >/tmp/workspace_active_tmp
export ACTIVE_WORKSPACE
