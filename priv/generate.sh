#!/bin/bash --login

set -eo pipefail

projects="$@"

for project in $projects
do
    if [ -d $project ]; then
        bash -c "cd $project && mix deps.get && mix compile" >/dev/null
    fi
done

MAX_DEPS_DEPTH=${MAX_DEPS_DEPTH:=0}
BUILTIN=${BUILTIN:=false}
SHORTEN_MODULE_NAMES=${SHORTEN_MODULE_NAMES:=true}
COLOR=${COLOR:="#ccc"}
mix run priv/graf.exs $projects \
    --max-deps-depth=${MAX_DEPS_DEPTH} \
    --builtin=${BUILTIN} | \
    node priv/heb/index.js \
    --color=${COLOR} \
    --shorten_module_names=${SHORTEN_MODULE_NAMES}
