include:
  - .initialize
  - .join

# check whether sdb.get returns null, then use requisites to do initialize or join
docker_check_initializer:
  cmd.run:
    - name: '[[ $(salt-call --output=newline_values_only sdb.get sdb://docker_swarm/initializer) == None ]]'
    - require_in:
      - sls: initialize
    - onfail_in:
      - sls: join
