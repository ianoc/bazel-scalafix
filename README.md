# bazel-scalafix
Example of using scalafix with bazel + scala_rules

A short example to show how to use bazel + scala fix for simple refactoring/rule application



Running bazel:

This repo will auto-install the bazel version configured in WORKSPACE, if you wish to use your local bazel remove the `tools/bazel` file.


Updating dependeinces:

run `./scripts/update_dependencies.sh` to update dependencies with the bazel-deps tool.
