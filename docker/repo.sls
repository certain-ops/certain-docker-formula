docker_stable_repository_configured:
  pkgrepo.managed:
    - name: docker-ce-stable
    - humanname: docker-ce
    - baseurl: 'https://download.docker.com/linux/centos/7/$basearch/stable'
    - gpgcheck: 1
    - gpgkey: 'https://download.docker.com/linux/centos/gpg'
