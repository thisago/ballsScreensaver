# Package

version       = "0.1.0"
author        = "Thisago"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["script"]

backend = "js"
binDir = "../"

# Dependencies

requires "nim >= 1.4.2"

task buildRelease, "Builds the release version",
  exec "nimble -d:release build"
