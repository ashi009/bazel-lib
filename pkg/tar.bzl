"Adapter macro from rules_pkg pkg_tar rule to aspect_bazel_lib tar rule"

load("@aspect_bazel_lib//lib:tar.bzl", "mtree_spec", "tar")
load("@aspect_bazel_lib//pkg/private:utils.bzl", "mtree_mutate")

def pkg_tar(name, srcs = [], out = None, strip_prefix = None, mtime = None):
    out = out or name + ".tar"
    mtree_spec(
        name = "_{}.mtree".format(name),
        srcs = srcs,
    )
    mtree_mutate(
        name = "_{}.mutate".format(name),
        mtree = "_{}.mtree".format(name),
        strip_prefix = strip_prefix,
        mtime = mtime,
    )
    tar(
        name = name,
        mtree = "_{}.mutate".format(name),
        srcs = srcs,
        out = out,
    )
