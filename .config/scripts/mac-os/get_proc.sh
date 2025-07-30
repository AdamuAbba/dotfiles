#!/usr/bin/env sh

get_proc() {
  ps -ax | awk -v pattern="$1" '$0 ~ pattern { for (i=4; i<=NF; i++) printf "%s%s", $i, (i<NF ? OFS : ORS); exit }'
}
