load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@bazel_scalafix//local_tools/scala:scala.bzl", "scala_library")
scala_library(
    name = "scala_compiler",
    exports = [
        "@scala//:scala-compiler"
    ],
    visibility = [
        "//visibility:public"
    ]
)



scala_library(
    name = "scala_library",
    exports = [
        "@scala//:scala-library"
    ],
    visibility = [
        "//visibility:public"
    ]
)



scala_library(
    name = "scala_reflect",
    exports = [
        "@scala//:scala-reflect"
    ],
    visibility = [
        "//visibility:public"
    ]
)


