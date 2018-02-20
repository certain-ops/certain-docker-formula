{% from "docker/settings.sls" import docker with context -%}

# Should I allow docker.swarm.managers here?
{% set manager_nodes = salt['saltutil.runner'](
    'manage.up', 
    tgt=docker.swarm.manager_target,
    expr_form=docker.swarm.manager_target_type
  )
-%}
{% set initializer = manager_nodes[0] -%}
{% do manager_nodes.remove(initializer) -%}

docker bootstrap initializer node:
  salt.state:
    - sls: docker.swarm.manager.first
    - tgt: {{ intializer }}

docker bootstrap swarm managers:
  salt.state:
    - sls: docker.swarm.manager.last
    - tgt: {{ manager_nodes }}
    - tgt_type: list
