{% from "docker/settings.sls" import docker with context %}

{%- if salt['cmd.run']("docker info | grep Swarm | awk '{print $2}'") == 'inactive' %}
include:
  {%- if salt['match.{}'.format(docker.manager_target_type)](manager_target) %}
  - .manager
  {%- elif salt['match.{}'.format(docker.manager_target_type)](worker_target) %}
  - .worker
  {%- endif %}
{%- endif %}
