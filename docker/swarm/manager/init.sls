include:
  - docker.swarm.manager.initialize
  - docker.swarm.manager.join

# check whether sdb.get returns null, then use requisites to do initialize or join
docker check initializer:
  cmd.run:
    - name: '[[ $(salt-call --output=newline_values_only sdb.get sdb://docker_swarm/initializer) == None ]]'
    - require_in:
      - sls: docker.swarm.manager.initialize
    - onfail_in:
      - sls: docker.swarm.manager.join
