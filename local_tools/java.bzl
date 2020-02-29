__build_file_content = """
java_runtime(
    name = "jdk",
    srcs = glob(["**"]),
    visibility = ["//visibility:public"],
)
"""

java_version_config = {
    "8": {
        "platform_to_url": {
            "macosx_x64": "https://cdn.azul.com/zulu/bin/zulu8.44.0.11-ca-jdk8.0.242-macosx_x64.tar.gz",
            "linux_x64": "https://cdn.azul.com/zulu/bin/zulu8.44.0.11-ca-jdk8.0.242-linux_x64.tar.gz",
        },
        "platform_to_sha256": {
            "macosx_x64": "6146b7fa7552a1853b7b0f228b1f4802d4ffb704f83eb0b1a74b1649d10194cd",
            "linux_x64": "2db117fcaeec0ccd00d08fc3bb374aa15d871a01120d7090cf91fe9764756ae9",
        },
        "prefix": "zulu8.44.0.11-ca-jdk8.0.242-{platform}",
    },
}


def _java_jdk_download_impl(ctx):
    platform = _platform_suffix(ctx)
    if ctx.attr.force_platform != None and ctx.attr.force_platform != "":
        platform = ctx.attr.force_platform
    version = ctx.attr.jdk_major_version

    ctx.download_and_extract(
        url = java_version_config[version]["platform_to_url"][platform],
        sha256 = java_version_config[version]["platform_to_sha256"][platform],
        stripPrefix = java_version_config[version]["prefix"].format(platform = platform),
    )
    ctx.file("BUILD", __build_file_content.format(jdk_version = version))
    ctx.file("WORKSPACE", "workspace(name = \"{name}\")".format(name = ctx.name))

load_java = repository_rule(
    implementation = _java_jdk_download_impl,
    attrs = {
        "jdk_major_version": attr.string(mandatory = True),
        "force_platform": attr.string(mandatory = False),
    },
)

# based on https://github.com/bazelbuild/rules_go/blob/master/go/private/sdk.bzl#L129
def _platform_suffix(ctx):
    if ctx.os.name == "linux":
        host = "linux_x64"
    elif ctx.os.name == "mac os x":
        host = "macosx_x64"
    else:
        fail("Unsupported operating system: " + ctx.os.name)
    return host
