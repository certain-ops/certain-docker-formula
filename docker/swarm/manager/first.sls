{% from "docker/settings.sls" import docker with context %}

include:
  - docker
  - .initialize
{% if docker.swarm.drain_managers %}
  - .drain
{% endif %}
