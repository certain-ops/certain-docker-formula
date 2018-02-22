{% from "docker/settings.sls" import docker with context %}

# Swarm: {{ salt['cmd.run']("docker info | grep Swarm | awk '{print $2}'") }}
# Is manager: {{ salt['match.{}'.format(docker.manager_target_type)](docker.manager_target) }}
# Is worker: {{ salt['match.{}'.format(docker.worker_target_type)](docker.worker_target) }}

{%- if salt['cmd.run']("docker info | grep Swarm | awk '{print $2}'") == 'inactive' %}
include:
  {%- if salt['match.{}'.format(docker.manager_target_type)](docker.manager_target) %}
  - .manager
  {%- elif salt['match.{}'.format(docker.worker_target_type)](docker.worker_target) %}
  - .worker
  {%- endif %}
{%- endif %}
