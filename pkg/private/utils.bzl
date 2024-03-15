def mtree_mutate(name, mtree, strip_prefix = None, mtime = None):
    script = "@aspect_bazel_lib//pkg/private:modify_mtree.awk"
    vars = []
    if strip_prefix:
        vars.append("-v strip_prefix='{}'".format(strip_prefix))
    if mtime:
        vars.append("-v mtime='{}'".format(mtime))
    native.genrule(
        name = name,
        srcs = [mtree],
        outs = [name + ".mtree"],
        cmd = "awk {} -f $(execpath {}) <$< >$@".format(" ".join(vars), script),
        tools = [script],
    )
