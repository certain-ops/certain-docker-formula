include:
  - .repo
  - .install
  - .config
  - .service
{%- if docker.swarm.enabled | lower() == 'true' %}
  - .swarm
{%- endif %}
