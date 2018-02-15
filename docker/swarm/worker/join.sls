{% set worker_token = salt['sdb.get']('sdb://docker_swarm/worker_token') %}
{% set join_endpoint = salt['sdb.get']('sdb://docker_swarm/initializer') %}

include:
  - docker

join cluster:
  cmd.run:
    - name: 'docker swarm join --token {{ worker_token }} {{ join_endpoint }}:2377'
