bootstrap swarm worker:
  salt.state:
    - sls: docker.swarm.worker.join
    - tgt: {{ docker.swarm.worker_target }}
    - tgt_type: {{ docker.swarm.worker_target_type }}
