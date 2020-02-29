#!/bin/bash

echo -ne "\033[0;32m"
echo 'Updating bazel dependencies. This will take about five minutes.'
echo -ne "\033[0m"

# update this to move to later versions of this repo:
# https://github.com/johnynek/bazel-deps
GITSHA="514c479c1afd3c4c73c6181f977e1066d65ceb8f"

set -e

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $SCRIPTS_DIR

REPO_ROOT=$(git rev-parse --show-toplevel)

BAZEL_DEPS_PATH="$HOME/.bazel-deps-cache/$(basename $REPO_ROOT)"
BAZEL_DEPS_REPO_PATH="$BAZEL_DEPS_PATH/bazel-deps"
BAZEL_DEPS_WORKSPACE="$BAZEL_DEPS_REPO_PATH/WORKSPACE"

if [ ! -f "$BAZEL_DEPS_WORKSPACE" ]; then
  mkdir -p $BAZEL_DEPS_PATH
  cd $BAZEL_DEPS_PATH
  git clone https://github.com/johnynek/bazel-deps.git
fi

cd $BAZEL_DEPS_REPO_PATH
git reset --hard $GITSHA || (git fetch && git reset --hard $GITSHA)
set +e
$REPO_ROOT/bazel run //:parse -- generate -r $REPO_ROOT -s 3rdparty/workspace.bzl -d dependencies.yaml  --target-file 3rdparty/target_file.bzl --disable-3rdparty-in-repo
RET_CODE=$?
set -e


if [ $RET_CODE == 0 ]; then
  echo "Success, going to format files"
else
  echo "Failure, checking out 3rdparty/jvm"
  cd $REPO_ROOT
  git checkout 3rdparty/jvm 3rdparty/workspace.bzl
  exit $RET_CODE
fi

# now reformat the dependencies to keep them sorted
$REPO_ROOT/bazel run //:parse -- format-deps -d $REPO_ROOT/dependencies.yaml -o

