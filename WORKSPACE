workspace(name = "bazel_scalafix")

BAZEL_VERSION = "2.1.1"
BAZEL_INSTALLER_VERSION_linux_SHA = "d6cea18d59e9c90c7ec417b2645834f968132de16d0022c7439b1e60438eb8c9"
BAZEL_INSTALLER_VERSION_darwin_SHA = "b4c94148f52854b89cff5de38a9eeeb4b0bcb3fb3a027330c46c468d9ea0898b"

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load("@bazel_tools//tools/build_defs/repo:git.bzl",
     "git_repository")

git_repository(
    name = "io_bazel_rules_scala",
    remote = "git://github.com/bazelbuild/rules_scala",
    commit = "cfff088f0eef18a8ca4d8bb62143f079e9174772"
)

http_archive(
    name = "com_google_protobuf",
    sha256 = "9748c0d90e54ea09e5e75fb7fac16edce15d2028d4356f32211cfa3c0e956564",
    strip_prefix = "protobuf-3.11.4",
    urls = ["https://github.com/protocolbuffers/protobuf/archive/v3.11.4.zip"],
)

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
protobuf_deps()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories((
        "2.12.10",
        {
            "scala_compiler": "cedc3b9c39d215a9a3ffc0cc75a1d784b51e9edc7f13051a1b4ad5ae22cfbc0c",
            "scala_library": "0a57044d10895f8d3dd66ad4286891f607169d948845ac51e17b4c1cf0ab569d",
            "scala_reflect": "56b609e1bab9144fb51525bfa01ccd72028154fc40a58685a1e9adcbe7835730",
        },
    ))


load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

bind(name = 'io_bazel_rules_scala/dependency/scalatest/scalatest', actual = '//3rdparty/jvm/org/scalatest:scalatest')
bind(name = 'io_bazel_rules_scala/dependency/junit/junit', actual = '//3rdparty/jvm/junit:junit')

load("//3rdparty:workspace.bzl", "maven_dependencies")
maven_dependencies()

load("//local_tools:java.bzl", "load_java")

load_java(
    name = "fetched_openjdk_8",
    jdk_major_version = "8",
)
