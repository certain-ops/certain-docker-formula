{% from "docker/settings.sls" import docker with context %}

include:
  - docker
{%- if salt['sdb.get']('sdb://docker_swarm/initializer') | default('') == '' %}
  - .initialize
  {% if docker.swarm.drain_managers %}
  - .drain
  {% endif %}
  - .sdb
{%- else %}
  - .join
{% endif %}
