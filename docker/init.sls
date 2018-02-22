{% from "docker/settings.sls" import docker with context %}

include:
  - .repo
  - .install
  - .config
  - .service
{%- if docker.swarm.enabled | lower() == 'true' %}
  - .swarm
{%- endif %}
