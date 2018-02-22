{% from "docker/settings.sls" import docker with context %}

include:
  - .initialize
  - .join
{% if docker.swarm.drain_managers %}
  - .drain
{% endif %}

# check whether sdb.get returns null, then use requisites to do initialize or join
docker_check_initializer:
  cmd.run:
    - name: '[[ $(salt-call --output=newline_values_only sdb.get sdb://docker_swarm/initializer) == None ]]'
    - require_in:
      #- sls: initialize
      - cmd: docker_initialize_swarm
      - module: docker_initializer
      - cmd: docker_worker_token
      - cmd: docker_manager_token
    - onfail_in:
      #- sls: join
      - cmd: join_cluster
