# HA

### Getting docker's private ip address

```sh
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker-compose ps -q)
```
