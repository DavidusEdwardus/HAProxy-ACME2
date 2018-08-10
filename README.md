# HAProxy-ACME2

This is a build of HAProxy incorporating the LUA ACME2 client explained here :

https://www.haproxy.com/blog/lets-encrypt-acme2-for-haproxy/

``
docker pull rayel/haproxy-acme2
``

# Generate keys

```
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out account.key

openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out example.net.key
```


# Start container

``
docker run -d -p 80:80 -p 443:443 -v /dev/log:/dev/log -v /usr/local/certs:/etc/haproxy/ssl -v /usr/local/keys:/usr/local/keys --name my-acme2-haproxy rayel/haproxy-acme
``

N.B. The contaner will not start if there are no existing certificates to serve from /etc/haproxy/ssl. If you're starting from scratch, you can put a dumym self signed cert in to get you going.

# Apply for certificate 

Now you can run curl from inside the container , with a mounted volume above (/usr/local/certs) containing your keys, and to deposit the cert

```
docker exec -it  my-acme2-haproxy \
curl -vv -XPOST http://127.0.0.1:9011/acme/order \
-F 'account_key=@/usr/local/keys/account.key' \
-F 'domain=example.net' \
-F 'domain_key=@/usr/local/keys/example.net.key' \
-o /etc/haproxy/ssl/example.net.pem
```


