{% from "docker/settings.sls" import docker with context %}

{% set manager_token = salt['sdb.get']('sdb://docker_swarm/manager_token') %}
{% set join_endpoint = salt['sdb.get']('sdb://docker_swarm/initializer') %}

include:
  - docker
{% if docker.swarm.drain_managers %}
  - docker.swarm.manager.drain
{% endif %}

join cluster:
  cmd.run:
    - name: 'docker swarm join --token {{ manager_token }} {{ join_endpoint }}:2377'
{% if docker.swarm.drain_managers %}
    - require_in:
      - cmd: drain manager
{% endif %}
