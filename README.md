# HAProxy-ACME2

This is a build of HAProxy incorporating the LUA ACME2 client explained here :

https://www.haproxy.com/blog/lets-encrypt-acme2-for-haproxy/

``
docker pull rayel/haproxy-acme2
``

# Run with host networking

``
docker run -d -v /dev/log:/dev/log   --network host --name my-acme2-haproxy rayel/haproxy-acme2
``

# Generate keys

```
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out account.key

openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out example.net.key
```

Then from the host :

```
curl -vv -XPOST http://127.0.0.1:9011/acme/order \
-F 'account_key=@account.key' \
-F 'domain=example.net' \
-F 'domain_key=@example.net.key' \
-o example.net.pem
```

# Run without host networking

``
docker run -d -p 80:80  -v /dev/log:/dev/log  -v /usr/local/certs:/usr/local/certs  --name my-acme2-haproxy rayel/haproxy-acme2
``

Now you can run curl inside the container , with a mounted volume above (/usr/local/certs) containing your keys, and to deposit the cert

```
docker exec -it  my-acme2-haproxy \
curl -vv -XPOST http://127.0.0.1:9011/acme/order \
-F 'account_key=@/usr/local/certs/account.key' \
-F 'domain=example.net' \
-F 'domain_key=@/usr/local/certs/account.key' \
-o /usr/local/certs/example.net.pem
```


