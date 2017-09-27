# kill ssh agent on logout
trap 'test -n "$SSH_AUTH_SOCK" && eval `/usr/bin/ssh-agent -k`' 0

