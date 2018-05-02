# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.

def declare_maven(hash):
    native.maven_jar(
        name = hash["name"],
        artifact = hash["artifact"],
        sha1 = hash["sha1"],
        repository = hash["repository"]
    )
    native.bind(
        name = hash["bind"],
        actual = hash["actual"]
    )

def list_dependencies():
    return [
    {"artifact": "org.scalameta:semanticdb-scalac_2.11.12:3.6.0", "lang": "scala/unmangled", "sha1": "786a3b74c1a44d0fb0f0f2cd61f9592343c2c454", "repository": "http://central.maven.org/maven2/", "name": "org_scalameta_semanticdb_scalac_2_11_12", "actual": "@org_scalameta_semanticdb_scalac_2_11_12//jar:file", "bind": "jar/org/scalameta/semanticdb_scalac_2_11_12"},
    ]

def maven_dependencies(callback = declare_maven):
    for hash in list_dependencies():
        callback(hash)
