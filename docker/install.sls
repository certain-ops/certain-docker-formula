docker_dependencies_installed:
  pkg.installed:
    - pkgs:
      - yum-utils
      - device-mapper-persistent-data
      - lvm2

docker_installed:
  pkg.installed:
    - name: docker-ce
