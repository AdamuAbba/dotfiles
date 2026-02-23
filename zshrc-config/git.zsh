export GIT_PAGER=delta

gcb() {
  url="$1"
  repo="${url##*/}"
  repo="${repo%.git}"
  mkdir "$repo" && cd "$repo" || return
  git clone --bare "$url" .git || return
  owner_repo="$(git remote get-url origin |
    sed -E 's#.*github.com[:/](.+)/(.+)\.git#\1/\2#')"
  gh repo set-default "$owner_repo"
}
