#!/bin/bash --login

set -e
set -o pipefail

projects="$@"

for project in $projects
do
    if [ -d $project ]; then
        bash -c "cd $project && mix deps.get && mix compile" >/dev/null 2>&1
    fi
done

mix run priv/codegraph.exs $projects | node priv/heb/index.js
