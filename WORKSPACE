workspace(name = "bazel_scalafix")

BAZEL_VERSION = "0.24.0"
BAZEL_INSTALLER_VERSION_linux_SHA = "bb9598b4a6b7b05d8ccf873426cf7c8f4f2c0e71d6121caba0902cafa9fde955"
BAZEL_INSTALLER_VERSION_darwin_SHA = "8e327033e6bbeb484e327b7d85ff702a610739784226d3da298503369aa65fdc"

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load("@bazel_tools//tools/build_defs/repo:git.bzl",
     "git_repository")

git_repository(
    name = "io_bazel_rules_scala",
    remote = "git://github.com/bazelbuild/rules_scala",
    commit = "ebc32f0e45a3fdd94b425fd7fcd10be05226795a"
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "9510dd2afc29e7245e9e884336f848c8a6600a14ae726adb6befdb4f786f0be2",
    strip_prefix = "protobuf-3.6.1.3",
    urls = ["https://github.com/protocolbuffers/protobuf/archive/v3.6.1.3.zip"],
)


load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

bind(name = 'io_bazel_rules_scala/dependency/scalatest/scalatest', actual = '//3rdparty/jvm/org/scalatest:scalatest')
bind(name = 'io_bazel_rules_scala/dependency/junit/junit', actual = '//3rdparty/jvm/junit:junit')

load("//3rdparty:workspace.bzl", "maven_dependencies")
maven_dependencies()
