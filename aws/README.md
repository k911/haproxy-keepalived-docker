# Keepalived Proxy AWS

1. Create instances
2. Copy contents of this directory into them
3. Run `ubuntu-setup.sh` on them
4. Run `docker-compose up -d webserver` on one of them - remember IP address
5. Configure `keepalived/keepalived-*.conf` files.
    * `real_server` in virtual server should be one with running `webserver` docker-compose service
    * `unicast_src_ip` is always a IP address of a current keepalived host
    * in `unicast_peer` should be other instance's ip with another keepalived host
6. Run proper keepalived services on different host
7. `curl 10.0.0.100` on any of the keepalived hosts and try failover (e.g. run `docker-compose down` on one instance and check logs on another one)
