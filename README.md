Modulus Docker Application
============
A Docker image for [OpenMRS Modulus][2] Developers :whale:

**Hosted on [Docker Hub][1]**.

**To Run It :**
`docker run --name modulus -h modulus openmrs/modulus:dev-1.0`

### IMPORTANT: Before You Start

1. Make sure you're running a **64 bit** version of either [Ubuntu 12.04 LTS](http://releases.ubuntu.com/precise/),  or [Ubuntu 14.04](http://releases.ubuntu.com/14.04/).
1. Upgrade to the [latest version of Docker](http://docs.docker.io/en/latest/installation/ubuntulinux/).
1. Run the docker installation and launcher as **root** or a member of the **docker** group.
1. Add your user account to the docker group: `usermod -a -G docker yourusername` and re-login.
1. Make sure these ports are free on your host.

### Pull the container and run it

1. **Pull** this container from Docker Hub : ``docker pull openmrs/modulus:dev-1.0`
2. **Run** with environnement variable, hostname, ports 
`docker run--name modulus -h modulus openmrs/modulus:dev-1.0`
3. **Shutdow** the container when you finish your work : ``docker stop modulus``
4. **Start** the container when needed : ``docker start modulus``

### Configuration

*TODO*

### Tips

[Modulus repository][4]

[Modulus UI repository][3]

 [1]: https://hub.docker.com/u/openmrs/
 [2]: https://modules.openmrs.org
 [3]: https://github.com/openmrs/openmrs-contrib-modulus-ui.git
 [4]: https://github.com/openmrs/openmrs-contrib-modulus.git