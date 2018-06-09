#!/bin/bash

pandoc -s ${1%.*}.md -o ${1%.*}.html --css ~/.config/pandoc/style/github-pandoc.css --css /github-pandoc.css --toc
