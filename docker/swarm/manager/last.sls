{% from "docker/settings.sls" import docker with context %}

include:
  - docker
  - .join
{% if docker.swarm.drain_managers %}
  - .drain
{% endif %}
