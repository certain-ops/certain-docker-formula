{% from "docker/settings.sls" import docker with context %}

init new swarm cluster:
  cmd.run:
    - name: 'docker swarm init --advertise-addr {{ grains['fqdn_ip4'][0] }}'

{% set worker_token = salt['cmd.run']('docker swarm join-token worker -q') %}
{% set manager_token = salt['cmd.run']('docker swarm join-token manager -q') %}

docker worker token:
  module.run:
    - name: sdb.set
    - uri: sdb://docker_swarm/worker_token
    - value: '{{ worker_token }}'

docker manager token:
  module.run:
    - name: sdb.set
    - uri: sdb://docker_swarm/manager_token
    - value: '{{ manager_token }}'

docker initializer:
  module.run:
    - name: sdb.set
    - uri: sdb://docker_swarm/initializer
    - value: '{{ salt['grains.get']('fqdn') }}'
