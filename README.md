# Highly Available Load Balancing with Floating IP

Using Docker, Keepalived and HAProxy with NGINX server as a web application.

Note: Cloud environments require manual configuration for creating/attaching/detaching Floating IP. For AWS see `aws/keepalived/notify.sh`.

## Set-up

```sh
# enable ip_vs
sudo modprobe ip_vs

# configure system
# see: https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/load_balancer_administration/s1-initial-setup-forwarding-vsa
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv4.ip_nonlocal_bind=1
```

## Running

### Config

```yaml
Virtual Server:
    IP: 192.168.0.150/24
    Port H2: 8080
    Port HTTP: 80
Host 1:
    IP: 192.168.0.24/24
    Interface: enp2s0
    Instances:
        - keepalived-a
        - haproxy-a
        - haproxy-b
        - web-a
        - web-b
Host 2:
    IP: 192.168.0.66/24
    Interface: wlp3s0
    Instances:
        - keepalived-b
        - haproxy-a
        - haproxy-b
        - web-a
        - web-b
```

### Host 1

```sh
docker-compose up -d keepalived-a haproxy-a haproxy-b web-a web-b
```

### Host 2

```sh
docker-compose up -d keepalived-b haproxy-a haproxy-b web-a web-b
```

### Usage

```sh
##############
# h2 protocol
##############
curl 192.168.0.150:8080 --http2-prior-knowledge
# Server B
curl 192.168.0.150:8080 --http2-prior-knowledge
# Server A

################
# http protocol
################
curl 192.168.0.150
# Server B
curl 192.168.0.150
# Server A
```

## Debugging

### Wireshark

Look for `vrrp` packets.

### Getting docker's private ip address

```sh
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker-compose ps -q)
```
