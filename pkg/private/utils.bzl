"Utilities for working with mtree format"

# buildifier: disable=function-docstring
def mtree_mutate(name, mtree, **kwargs):
    script = "@aspect_bazel_lib//pkg/private:modify_mtree.awk"
    vars = [
        "-v {}='{}'".format(variable, value)
        for variable, value in kwargs.items()
        if value != None
    ]

    native.genrule(
        name = name,
        srcs = [mtree],
        outs = [name + ".mtree"],
        cmd = "awk {} -f $(execpath {}) <$< >$@".format(" ".join(vars), script),
        tools = [script],
    )
