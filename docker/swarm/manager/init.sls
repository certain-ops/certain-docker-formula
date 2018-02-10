{% from "docker/settings.sls" import docker with context %}

include:
  - docker
{%- if salt['mine.get']('*', 'docker_initializer') | default(None) == None %}
  - .initialize
  {% if docker.swarm_drain_managers %}
  - .drain
  {% endif %}
  - .mine
{%- else %}
  - .join
{% endif %}
