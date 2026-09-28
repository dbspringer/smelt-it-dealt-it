std = "lua51"
max_line_length = 120
self = false

exclude_files = { ".release/", "libs/" }

globals = {
}

read_globals = {
}

files["spec"] = { std = "+busted" }
-- A translated sentence can't wrap.
files["locales"] = { max_line_length = false }
