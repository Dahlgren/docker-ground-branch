# Ground Branch

Uses Wine to run the dedicated Ground Branch server for Windows in a Linux container.

## How to use

The server will use UDP ports 7777 and 27015 by default which needs to be forwarded to the container.

Server config can be set by mounting a folder to `/groundbranch/GroundBranch/ServerConfig`.

### Example

`docker run dahlgren/ground-branch -p 7777:7777/udp -p 27015:27015/udp -v ./ServerConfig:/groundbranch/GroundBranch/ServerConfig`
