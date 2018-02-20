#!py

def run():
  '''
  Join a docker swarm cluster
  '''

  manager_token = __salt__['sdb.get']('sdb://docker_swarm/manager_token')
  join_endpoint = __salt__['sdb.get']('sdb://docker_swarm/initializer')
  
  __salt__['cmd.run'](
    'docker swarm join --token {} {}:2377'.format(manager_token, join_endpoint)
  )

  return {}

{#
#!jinja
{% from "docker/settings.sls" import docker with context %}

{% set manager_token = salt['sdb.get']('sdb://docker_swarm/manager_token') %}
{% set join_endpoint = salt['sdb.get']('sdb://docker_swarm/initializer') %}

join cluster:
  cmd.run:
    - name: 'docker swarm join --token {{ manager_token }} {{ join_endpoint }}:2377'
#}
