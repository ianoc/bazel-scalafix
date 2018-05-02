load("@io_bazel_rules_scala//scala:scala.bzl",
     uppstream_lib = "scala_library",
     uppstream_macro = "scala_macro_library",
     uppstream_bin = "scala_binary",
     uppstream_test = "scala_test",
     uppstream_scala_library_suite = "scala_library_suite")

_default_scalac_opts = [
    "-Yskip-inline-info-attribute",  # without this minor changes almost always trigger recomputations
    "-Ywarn-dead-code",
    "-Ywarn-unused-import",  # macros can cause this to kill the compiler, see: https://github.com/scala/pickling/issues/370
    "-Ywarn-value-discard",
    "-Xmax-classfile-name", "128",  # Linux laptops don't like long file names
    "-Xlint",
    "-Xfuture",
    "-Ywarn-unused",
    #"-Xfatal-warnings",  # sometimes disabled due to https://issues.scala-lang.org/browse/SI-9673 on stubs, must be disabled for scalafix
    "-deprecation",
    "-feature",
    "-unchecked",
    "-Yrangepos" # needed for scalafix
]

# We use the linter: https://github.com/HairyFotr/linter
# This is disabled by default since it has a large performance overhead.
_plugins = ["@org_scalameta_semanticdb_scalac_2_11_12//jar:file"]  # "@org_psywerx_hairyfotr_linter_2_11//jar:file"]


def scala_library(name, srcs = [], deps = [], runtime_deps = [], data = [], resources = [],
                  scalacopts = _default_scalac_opts, jvm_flags = [], main_class = "", exports = [],
                  resource_jars = [], visibility = None, javacopts = []):
    uppstream_lib(name = name, srcs = srcs, deps = deps, runtime_deps = runtime_deps,
                  plugins = _plugins,
                  resources = resources, scalacopts = scalacopts,
                  jvm_flags = jvm_flags, main_class = main_class, exports = exports,
                  resource_jars = resource_jars, visibility = visibility, print_compile_time=False,
                  javacopts = [])


def scala_macro_library(name, srcs = [], deps = [], runtime_deps = [], data = [], resources = [],
                        scalacopts = _default_scalac_opts, jvm_flags = [], main_class = "", exports = [], visibility = None):
    uppstream_macro(name = name, srcs = srcs, deps = deps, runtime_deps = runtime_deps,
                    plugins = _plugins,
                    resources = resources, scalacopts = scalacopts,
                    jvm_flags = jvm_flags, main_class = main_class, exports = exports, visibility = visibility,
                    print_compile_time=False)


def scala_binary(name, srcs = [], deps = [], runtime_deps = [], data = [], resources = [],
                 resource_jars = [], scalacopts = _default_scalac_opts, jvm_flags = [],
                 main_class = "", visibility = None):
    uppstream_bin(name = name, srcs = srcs, deps = deps, runtime_deps = runtime_deps,
                  plugins = _plugins,
                  resources = resources, resource_jars = resource_jars, scalacopts = scalacopts,
                  jvm_flags = jvm_flags, main_class = main_class, visibility = visibility,
                  print_compile_time=False)

