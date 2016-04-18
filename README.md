# bind9
This is an Response Policy Zone update script for versions of bind9 support RPZ files.
First thing needed is:
```bash
#Place this in named.conf.options file
response-policy {
            zone "rpz.block.internal";
        };
```

```bash
#Place this in named.conf.local file
zone "rpz.block.internal" {
      type master;
      file "/etc/bind/db.rpz";
      allow-query { localhost; };

};
```
```bash
#Place this in the /etc/bind9 folder and save it as db.rpz.bk
$TTL 60
@            IN    SOA  localhost. root.localhost.  (
                          3   ; serial
                          3H  ; refresh
                          1H  ; retry
                          1W  ; expiry
                          1H) ; minimum
@                         IN    NS    localhost.


;BADZONES
```
