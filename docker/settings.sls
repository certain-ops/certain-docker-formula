{%- import_yaml 'docker/defaults.yaml' as docker_defaults -%}
{%- set docker_pillar = salt.pillar.get('docker', {}) %}
{%- set docker_grains = salt.grains.get('docker', {}) %}

{%- set docker = docker_defaults.docker %}
{%- do salt.slsutil.update(docker, docker_pillar) %}
{%- do salt.slsutil.update(docker, docker_grains) %}
