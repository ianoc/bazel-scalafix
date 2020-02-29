# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "org.scala-lang.modules:scala-parser-combinators_2.12:1.1.2", "lang": "scala", "sha1": "2ad65ccbeed662b51e2b96221cb4e7d7d6b7b87a", "sha256": "24985eb43e295a9dd77905ada307a850ca25acf819cdb579c093fc6987b0dbc2", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.1.2/scala-parser-combinators_2.12-1.1.2.jar", "source": {"sha1": "17be9d543fa1f7f01d57722cc37d0c4024a15f69", "sha256": "8fbe3fa9e748f24aa6d6868c0c2be30d41a02d20428ed5429bb57a897cb756e3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-parser-combinators_2.12/1.1.2/scala-parser-combinators_2.12-1.1.2-sources.jar"} , "name": "org_scala_lang_modules_scala_parser_combinators_2_12", "actual": "@org_scala_lang_modules_scala_parser_combinators_2_12//jar:file", "bind": "jar/org/scala_lang/modules/scala_parser_combinators_2_12"},
    {"artifact": "org.scala-lang.modules:scala-xml_2.12:1.2.0", "lang": "scala", "sha1": "5d38ac30beb8420dd395c0af447ba412158965e6", "sha256": "1b48dc206f527b7604ef32492ada8e71706c63a65d999e0cabdafdc5793b4d63", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.2.0/scala-xml_2.12-1.2.0.jar", "source": {"sha1": "97b3021c2ceef1170ff2f0e8a12a1cb5dfc9bfd3", "sha256": "288fdce0b296df28725707cc87cff0f65ef435c54e93e0c1fbc5a7fcc8e19ade", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-xml_2.12/1.2.0/scala-xml_2.12-1.2.0-sources.jar"} , "name": "org_scala_lang_modules_scala_xml_2_12", "actual": "@org_scala_lang_modules_scala_xml_2_12//jar:file", "bind": "jar/org/scala_lang/modules/scala_xml_2_12"},
    {"artifact": "org.scala-lang:scala-compiler:2.12.10", "lang": "scala/unmangled", "sha1": "33e91b29dff873755751bfc45e916a16100ec818", "sha256": "cedc3b9c39d215a9a3ffc0cc75a1d784b51e9edc7f13051a1b4ad5ae22cfbc0c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-compiler/2.12.10/scala-compiler-2.12.10.jar", "source": {"sha1": "1fe4d588040be2b8254639becdc4042986f72a7a", "sha256": "bb695d1b05c5239bb93ef4b07023993a59df073ba6150f541725d81f1cc23e4d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-compiler/2.12.10/scala-compiler-2.12.10-sources.jar"} , "name": "org_scala_lang_scala_compiler", "actual": "@org_scala_lang_scala_compiler//jar:file", "bind": "jar/org/scala_lang/scala_compiler"},
# duplicates in org.scala-lang:scala-library fixed to 2.12.10
# - org.scala-lang.modules:scala-parser-combinators_2.12:1.1.2 wanted version 2.12.8
# - org.scala-lang.modules:scala-xml_2.12:1.2.0 wanted version 2.12.8
# - org.scala-lang:scala-compiler:2.12.10 wanted version 2.12.10
# - org.scala-lang:scala-reflect:2.12.10 wanted version 2.12.10
# - org.scalameta:semanticdb-scalac_2.12.10:4.3.0 wanted version 2.12.10
    {"artifact": "org.scala-lang:scala-library:2.12.10", "lang": "scala/unmangled", "sha1": "3509860bc2e5b3da001ed45aca94ffbe5694dbda", "sha256": "0a57044d10895f8d3dd66ad4286891f607169d948845ac51e17b4c1cf0ab569d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-library/2.12.10/scala-library-2.12.10.jar", "source": {"sha1": "686bb459f3026f14165373324d943a4cac6959c2", "sha256": "a6f873aeb9b861848e0d0b4ec368a3f1682e33bdf11a82ce26f0bfe5fb197647", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-library/2.12.10/scala-library-2.12.10-sources.jar"} , "name": "org_scala_lang_scala_library", "actual": "@org_scala_lang_scala_library//jar:file", "bind": "jar/org/scala_lang/scala_library"},
    {"artifact": "org.scala-lang:scala-reflect:2.12.10", "lang": "scala/unmangled", "sha1": "14cb7beb516cd8e07716133668c427792122c926", "sha256": "56b609e1bab9144fb51525bfa01ccd72028154fc40a58685a1e9adcbe7835730", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-reflect/2.12.10/scala-reflect-2.12.10.jar", "source": {"sha1": "f864c8487d2da5c1a009a9131e61dcf179bf561d", "sha256": "c3a883670038f8030c41e5e3840d592e2c8bd89bf33d7d42a15c60f1207b9a32", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-reflect/2.12.10/scala-reflect-2.12.10-sources.jar"} , "name": "org_scala_lang_scala_reflect", "actual": "@org_scala_lang_scala_reflect//jar:file", "bind": "jar/org/scala_lang/scala_reflect"},
    {"artifact": "org.scalameta:semanticdb-scalac_2.12.10:4.3.0", "lang": "scala/unmangled", "sha1": "06d87936f8b67bf8b9e990a54e652b53441c7d22", "sha256": "53385858d9107e9eee2feaad6fe67b28e7fcf98c2ee453c79947a72632c5e6b0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalameta/semanticdb-scalac_2.12.10/4.3.0/semanticdb-scalac_2.12.10-4.3.0.jar", "source": {"sha1": "4ddeadcdbdc0975fecd9fbac23cc28d85a825f65", "sha256": "cf3dd494e32e40b130ebcb86389bb01fb4ae9b2a4f9f7f97227a63e37754e4bf", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalameta/semanticdb-scalac_2.12.10/4.3.0/semanticdb-scalac_2.12.10-4.3.0-sources.jar"} , "name": "org_scalameta_semanticdb_scalac_2_12_10", "actual": "@org_scalameta_semanticdb_scalac_2_12_10//jar:file", "bind": "jar/org/scalameta/semanticdb_scalac_2_12_10"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
