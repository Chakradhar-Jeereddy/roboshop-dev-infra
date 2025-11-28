## Cloudfront(its a goblal service not regional)
Caching service
Edge cache network
application - cache - database

Establish a connection with database
run query
fetch results
parse results
then close connection

Increase speed by caching results before sharing to client, next request gets it from cache.
Edge location should have origin
