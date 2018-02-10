{% from "docker/settings.sls" import docker with context -%}

bootstrap swarm managers:
  salt.state:
    - sls: docker.swarm.manager
    - tgt: {{ docker.swarm.manager_target }}  # Should I allow docker.swarm.managers here?
    - tgt_type: {{ docker.swarm.manager_target_type }}

update manager mines:
  salt.function:
    - name: mine.update
    - tgt: {{ docker.swarm.manager_target }}
    - tgt_type: {{ docker.swarm.manager_target_type }}
    - require:
      - salt: bootstrap swarm managers
