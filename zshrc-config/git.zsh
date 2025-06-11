#!/bin/bash
export GIT_PAGER=delta

new-repo(){
  gh repo create '$1' --add-readme --public --description '$2' --disable-wiki  --license mit --clone
}
