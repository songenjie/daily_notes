```sql

ping: permission denied (are you root?) #65
 Closed
markych96 opened this issue on 4 Oct 2016 · 9 comments
Comments
@markych96
 
markych96 commented on 4 Oct 2016
Hello!
Is that normal behaviour? what after creating container by command
docker run -d smebberson/docker-alpine
and then getting shell by
docker exec -it [container_id] sh
and send ping 172.17.0.1 i've got a error message

ping: permission denied (are you root?)

how can i solve this problem?

P.S. docker version 1.12.1

thank you

@rbellamy
 
Contributor
rbellamy commented on 18 Oct 2016
Force UID=0 (root) when starting the container:

docker exec -u 0 -it [container_id] sh


```







docker rm $(docker ps -a -q)





/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/prometheus --web.console.libraries=/usr/share/prometheus/console_libraries --web.console.templates=/usr/share/prometheus/consoles