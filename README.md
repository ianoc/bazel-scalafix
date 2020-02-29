![CI](https://github.com/ianoc/bazel-scalafix/workflows/CI/badge.svg)
# bazel-scalafix 
Example of using scalafix with bazel + scala_rules

A short example to show how to use bazel + scala fix for simple refactoring/rule application. So far this isn't really something you can keep on for every build. A few harder problems but likely some large improvements can be made for this:

1) Right now this builds a binary target for every found target to set up the classpaths. Via common caching this isn't too slow for an adhoc process but it doesn't scale very well. Or support real bazel distributed execution
2) Bazel likes the tree to be immutable, so it would be better to structure the rule application as itself a rule where the output is a diff possibly.
3) In order to allow scalafix to operate warn on error must be disabled, usually users like to keep this enabled so this is a tricky one for constant usage.



Running bazel:

This repo will auto-install the bazel version configured in WORKSPACE, if you wish to use your local bazel remove the `tools/bazel` file.


Updating dependeinces:

run `./scripts/update_dependencies.sh` to update dependencies with the bazel-deps tool.



Scalafix installation


scalafix is in the scripts folder, installed via coursier. Update/replace as necessary.




Running the scalafix fixups:

The command line args for the script look like:

`./scripts/run-scalafix <bazel query here> <other args/rules here>`


An example is

`./scripts/run-scalafix src/... --rules MissingFinal`

This will apply the MissingFinal rule against all targets under src
