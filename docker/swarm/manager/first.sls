{% from "docker/settings.sls" import docker with context %}

include:
  - docker
  - docker.swarm.manager.initialize
{% if docker.swarm.drain_managers %}
  - docker.swarm.manager.drain
{% endif %}
  - docker.swarm.manager.mine
