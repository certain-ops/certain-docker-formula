{% from "docker/settings.sls" import docker with context %}

docker_initialize_swarm:
  cmd.run:
    - name: {{ 'docker swarm init --advertise-addr {}'.format(grains['fqdn_ip4'][0]) }}

{% set initializer = salt['grains.get'](docker.swarm.initializer_grain) -%}
docker_initializer:
  module.run:
    - name: sdb.set
    - uri: sdb://docker_swarm/initializer
{%- if initializer is sequence and not initializer is string %}
    - value: {{ initializer[0] }}
{%- else %}
    - value: {{ initializer }}
{%- endif %}

docker_worker_token:
  cmd.run:
    - name: {{ "salt-call sdb.set 'sdb://docker_swarm/worker_token' $(docker swarm join-token worker -q)" }}

docker_manager_token:
  cmd.run:
    - name: {{ "salt-call sdb.set 'sdb://docker_swarm/manager_token' $(docker swarm join-token manager -q)" }}
