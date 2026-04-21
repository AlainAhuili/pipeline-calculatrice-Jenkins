FROM jenkins/jenkins:2.492.1-jdk17
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli# Match the host's docker GID (Replace 999 with your actual GID)
RUN groupadd -g 988 docker && usermod -aG docker jenkins
USER jenkins
# Removing specific versions allows the CLI to find the best match for this Jenkins version
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
