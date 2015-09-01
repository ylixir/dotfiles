#!/usr/bin/env lua

local p = require('posix.unistd')

os.execute("xbacklight =15")
os.execute("xhost +")
os.execute("xset -dpms s off")
p.exec("/usr/bin/herbstluftwm",{})
