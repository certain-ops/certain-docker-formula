{% from "docker/settings.sls" import docker with context %}

docker initialize swarm:
  cmd.run:
    - name: {{ 'docker swarm init --advertise-addr {}'.format(grains['fqdn_ip4'][0]) }}

docker initializer:
  module.run:
    - name: sdb.set
    - uri: sdb://docker_swarm/initializer
    - value: {{ salt['grains.get']('fqdn') }}

docker worker token:
  cmd.run:
    - name: {{ "salt-call sdb.set 'sdb://docker_swarm/worker_token' $(docker swarm join-token worker -q)" }}

docker manager token:
  cmd.run:
    - name: {{ "salt-call sdb.set 'sdb://docker_swarm/manager_token' $(docker swarm join-token manager -q)" }}
