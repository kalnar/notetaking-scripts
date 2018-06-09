#!/bin/bash

pandocConvert() {
  pandoc -s ${1%.*}.md -o ${1%.*}.html --css ~/.config/pandoc/style/github-pandoc.css --css /github-pandoc.css --toc
}

export -f pandocConvert

if [[ "$1" == "-c" ]]
then 
  #find . ! -path "./toc.md" -type f -name "*.md" -execdir grip --export --no-inline {} \;
  find . ! -name "toc.md" -type f -name "*.md" -execdir bash -c 'pandocConvert "${0}"' {} \;
fi

# this is the old version: didn't work with symbolic links
tree -H . -P "*.html|*.pdf|*.txt" --prune -o toc.md
#tree -H . -I "*.md" --prune -o toc.md

grip --export --no-inline toc.md

sed -i '/^ *<\/style>$/i \
    p {\
      line-height: normal;\
      font-family: monospace;\
    }' toc.html


