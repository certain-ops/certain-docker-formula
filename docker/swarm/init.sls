{% from "docker/settings.sls" import docker with context %}

# Swarm: {{ salt['cmd.run']("docker info 2>/dev/null | grep Swarm | awk '{print $2}'") }}
# Is manager: {{ salt['match.{}'.format(docker.swarm.manager_target_type)](docker.swarm.manager_target) }}
# Is worker: {{ salt['match.{}'.format(docker.swarm.worker_target_type)](docker.swarm.worker_target) }}

{%- if salt['cmd.run']("docker info 2>/dev/null | grep Swarm | awk '{print $2}'") != 'active' %}
include:
  {%- if salt['match.{}'.format(docker.swarm.manager_target_type)](docker.swarm.manager_target) %}
  - .manager
  {%- elif salt['match.{}'.format(docker.swarm.worker_target_type)](docker.swarm.worker_target) %}
  - .worker
  {%- endif %}
{%- endif %}
