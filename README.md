## Docker Installation
1. Install Docker


1.1. Install certobt
```bash
sudo apt install certbot
sudo certbot certonly --standalone -d you.domain.net --email you@domain.net --agree-tos --non-interactive
sudo systemctl list-timers | grep certbot
```
2. Build docker image
```bash
docker build -t ocserv https://github.com/mogilevich/OpenConnect-Cisco-AnyConnect-VPN-Server-OneKey-ocserv.git
```

3. Run docker container
```bash
docker run -d \
   -v /etc/letsencrypt/live/you.domain.net/fullchain.pem:/etc/ocserv/certs/server-cert.pem:ro\
   -v /etc/letsencrypt/live/you.domain.net/privkey.pem:/etc/ocserv/certs/server-key.pem:ro\
   --name ocserv_container\
   --restart=always\
   --privileged -p 443:443 -p 443:443/udp ocserv
```

4. Add user
```bash
docker exec -ti ocserv_container ocpasswd -c /etc/ocserv/ocpasswd testUserName
```

5. Change user password
```bash
docker exec -ti ocserv_container ocpasswd -c /etc/ocserv/ocpasswd testUserName
```

6. Delete user
```bash
docker exec -ti ocserv_container ocpasswd -c /etc/ocserv/ocpasswd -d testUserName
```

7. Lock user
```bash
docker exec -ti ocserv_container ocpasswd -c /etc/ocserv/ocpasswd -l testUserName
```

8. Unlock user
```bash
docker exec -ti ocserv_container ocpasswd -c /etc/ocserv/ocpasswd -u testUserName
```

9. Show all users and their hashed password
```bash
docker exec -ti ocserv_container cat /etc/ocserv/ocpasswd
```

## Features
- Easy install
- Easy uninstall
- Add User
- Change Password
- Show All Users
- Delete User
- Lock User
- Unlock User

## How to connect to it?
For making connection to your server, you can use `AnyConnect`, `OpenConnect` or other alternative clients.

- AnyConnect: [GUI AnyConnect client for available platforms](https://it.umn.edu/vpn-downloads-guides).
- OpenConnect: [OpenConnect client for Linux](https://computingforgeeks.com/how-to-connect-to-vpn-server-with-openconnect-ssl-vpn-client-on-linux/).

And one more thing, contributions are welcome.

## More
The script is based on [here](https://ocserv.gitlab.io/www/recipes-ocserv-configuration-basic.html)
