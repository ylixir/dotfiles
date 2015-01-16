#!/usr/bin/env lua

local p = require('posix.unistd')

os.execute("xbacklight =15")
p.exec("/usr/bin/herbstluftwm",{})
