{% from "docker/settings.sls" import docker with context %}

include:
  - docker
# {{ salt['sdb.get']('sdb://docker_swarm/initializer') }}
{%- if salt['sdb.get']('sdb://docker_swarm/initializer') == None %}
  - .initialize
  {% if docker.swarm.drain_managers %}
  - .drain
  {% endif %}
  - .sdb
{%- else %}
  - .join
{% endif %}
