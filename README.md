##  elk-container
Docker Compose and Logstash configuration files. 

### Usage
```
git clone https://github.com/cyberphor/elk-container
cd elk-container
docker-compose up
```

### Troubleshooting
> max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

If you are getting the error above, perform the edit below. Repeat this process as needed or automate it using PowerShell.
```bash
# step 1: invoke the Windows Subsystem for Linux (WSL)
wsl.exe 

# step 2: append the following parameter to the file specified
echo "vm.max_map_count = 262144" >> /etc/sysctl.conf

# step 3: reload kernel parameters and exit
sysctl -p
exit
```

The hack above is necessary when the WSL is used to run containers. By default, WSL-based containers are limited in the amount of memory they are allowed to use.  

`sysctl` is a utility used for configuring kernel parameters at runtime. 
`sysctl -p` forces the kernel to reload parameters albeit those saved in `/etc/sysctl.conf`.

>  ECS compatibility is enabled but `target` option was not specified. This may cause fields to be set at the top-level of the event where they are likely to clash with the Elastic Common Schema. 

```bash
# fix goes here
```

### References
* [https://hub.docker.com/r/sebp/elk/](https://hub.docker.com/r/sebp/elk/)
* [https://elk-docker.readthedocs.io/](https://elk-docker.readthedocs.io/)
* [https://www.elastic.co/guide/en/logstash/current/plugins-codecs-json.html#plugins-codecs-json-target](https://www.elastic.co/guide/en/logstash/current/plugins-codecs-json.html#plugins-codecs-json-target)