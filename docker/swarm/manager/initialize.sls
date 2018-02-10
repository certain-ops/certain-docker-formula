{% from "docker/settings.sls" import docker with context %}

init new swarm cluster:
  cmd.run:
    # Should we advertise the host name here instead of the IP
    - name: 'docker swarm init --advertise-addr {{ grains['fqdn'] }}'
    #- name: 'docker swarm init --advertise-addr {{ grains['id'] }}'
    #- name: 'docker swarm init --advertise-addr {{ grains['fqdn_ip4'][0] }}'
{% if docker.swarm.drain_managers %}
    - require_in:
      - cmd: drain manager
{% endif %}
