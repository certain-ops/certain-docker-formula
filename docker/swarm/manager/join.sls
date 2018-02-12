{% from "docker/settings.sls" import docker with context %}

{% set join_token = salt['mine.get']('*', 'docker_manager_token').items()[0][1] %}
{% set join_endpoint = salt['mine.get']('*', 'docker_intializer').values()[0] %}

include:
  - docker
{% if docker.swarm.drain_managers %}
  - docker.swarm.manager.drain
{% endif %}

join cluster:
  cmd.run:
    - name: 'docker swarm join --token {{ join_token }} {{ join_endpoint }}:2377'
{% if docker.swarm.drain_managers %}
    - require_in:
      - cmd: drain manager
{% endif %}
