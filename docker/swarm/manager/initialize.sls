#!py

def run():
  '''
  Initialize a docker swarm cluster and add join tokens to SDB
  '''

  __salt__['cmd.run'](
    'docker swarm init --advertise-addr {}'.format(__grains__['fqdn_ip4'][0])
  )

  worker_token = __salt__['cmd.run']('docker swarm join-token worker -q')
  manager_token = __salt__['cmd.run']('docker swarm join-token manager -q')

  __salt__['sdb.set']('sdb://docker_swarm/worker_token', worker_token)
  __salt__['sdb.set']('sdb://docker_swarm/manager_token', manager_token)
  __salt__['sdb.set']('sdb://docker_swarm/initializer', __grains__['fqdn'])

  return {}

{#
#!jinja
{% from "docker/settings.sls" import docker with context %}

# This is done at render time...
{% do salt['cmd.run']('docker swarm init --advertise-addr {}'.format(grains['fqdn_ip4'][0])) %}
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
#}
