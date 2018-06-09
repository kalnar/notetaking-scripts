#!/bin/bash

tree -H . -P "*.md|*.pdf|*.txt" --prune -o toc.md

grip --export --no-inline toc.md


