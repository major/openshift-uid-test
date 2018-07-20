FROM centos:latest
USER root
RUN yum -y install yum-utils rpm-build && yum-builddep git
LABEL io.k8s.description="Major's test for arbitrary user ids in openshift" \
      io.k8s.display-name="Major UID Test" \
      io.openshift.tags="test" \
      io.openshift.s2i.scripts-url="image:///opt/app-root/s2i/bin"
COPY s2i /opt/app-root/s2i
COPY sleepytime.sh /usr/local/bin/sleepytime.sh
RUN mkdir /home/major
RUN chgrp -Rf root /home/major && chmod -Rf g+w /home/major
RUN chmod g+w /etc/passwd /etc/group
USER 1000:1000
CMD [ "/opt/app-root/s2i/bin/run" ]
