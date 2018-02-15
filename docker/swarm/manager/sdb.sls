# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "docker/settings.sls" import docker with context %}

{% set worker_token = salt['cmd.run']('docker swarm join-token worker -q') %}
{% set manager_token = salt['cmd.run']('docker swarm join-token manager -q') %}

docker worker token:
  module.run:
    - name: sdb.set:
    - uri: sdb://docker_swarm/worker_token
    - value: {{ worker_token }}

docker manager token:
  module.run:
    - name: sdb.set
    - uri: sdb://docker_swarm/manager_token
    - value: {{ manager_token }}

docker initializer:
  module.run:
    - name: sdb.set
    - uri: sdb://docker_swarm/initializer
    - value: {{ salt['grains.get']('fqdn') }}

#
#wait until mine propogates:
#  loop.until:
#    - name: mine.get
#    - condition: m_ret != {}
#    - period: 1
#    - timeout: 120
#    - m_args:
#      - {{ grains.id }}
#      - 'docker_initializer'
#    - m_kwargs: {}
