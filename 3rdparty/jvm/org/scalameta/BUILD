load("@io_bazel_rules_scala//scala:scala_import.bzl", "scala_import")
load("@bazel_scalafix//local_tools/scala:scala.bzl", "scala_library")
scala_import(
    name = "semanticdb_scalac_2_11_12",
    jars = [
        "//external:jar/org/scalameta/semanticdb_scalac_2_11_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library"
    ],
    visibility = [
        "//visibility:public"
    ]
)


