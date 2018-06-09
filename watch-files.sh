#!/bin/bash

(inotifywait -e delete,create -m -r /home/kalnar/notes/ | grep -E '\.md$|\.pdf$' --line-buffered || true) |
while read -r directory events filename; do
  date >> /home/kalnar/projects/programming/kalnarapps/notetaking/inotify.log
  if [[ ${events} == "CREATE" && ${filename} == *md ]]; then
    /home/kalnar/bin/pandoc_convert.sh ${directory}${filename}
    echo pandoc_convert.sh ${directory}${filename} >> /home/kalnar/projects/programming/kalnarapps/notetaking/inotify.log
  fi
  cd ${directory}
  create_toc_html.sh > /dev/null 2>&1
  # it is still called dropbox...althoudh I should rename it to something more general
  cd ${dropbox}/notes
  create_toc_html.sh > /dev/null 2>&1
done &


#(inotifywait -e create -m /home/kalnar/.task/backlog.data || true) |
#while read -r directory events filename; do
  #/home/kalnar/projects/tasks/taskwarrior-html/mustache-html/test.sh
#done 
