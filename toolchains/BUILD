load("@io_bazel_rules_scala//scala:scala_toolchain.bzl", "scala_toolchain")

package(default_visibility = ["//visibility:public"])

scala_toolchain(
    name = "local_scala_toolchain_impl",
    plus_one_deps_mode = "on",
    scalac_jvm_flags = [
        # We've had trouble with stack overflows with the default
        # 1MB stack size
        "-Xss2m",
        # We dont' want jvms filling memory available, so lets limit these to 2gig heap for each
        # compiler instance
        "-Xmx2g",
    ],
    # Change this value to "error" to run the unused dependency checker.
    unused_dependency_checker_mode = "off",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "local_scala_toolchain",
    toolchain = "local_scala_toolchain_impl",
    toolchain_type = "@io_bazel_rules_scala//scala:toolchain_type",
    )

