workspace(name = "bazel_scalafix")

BAZEL_VERSION = "0.12.0"
BAZEL_INSTALLER_VERSION_linux_SHA = "1af7a70cc2c5180765ed2f0da366c625fac89e6656dedc008320d46eb1f75e20"
BAZEL_INSTALLER_VERSION_darwin_SHA = "a1e0e08959880de3c360006718332b6426afa40a09b4353aae552e40f411d0ee"

load("@bazel_tools//tools/build_defs/repo:git.bzl",
     "git_repository")

git_repository(
    name = "io_bazel_rules_scala",
    remote = "git://github.com/bazelbuild/rules_scala",
    commit = "8c1f7d000cb9cc8d380ff10017c4c4ff58f2e475"
)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

bind(name = 'io_bazel_rules_scala/dependency/scalatest/scalatest', actual = '//3rdparty/jvm/org/scalatest:scalatest')
bind(name = 'io_bazel_rules_scala/dependency/junit/junit', actual = '//3rdparty/jvm/junit:junit')

load("//3rdparty:workspace.bzl", "maven_dependencies")
maven_dependencies()
