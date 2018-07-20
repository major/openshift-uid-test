FROM centos:latest
USER root
RUN yum -y upgrade && yum clean all
LABEL io.k8s.description="Major's test for arbitrary user ids in openshift" \
      io.k8s.display-name="Major UID Test" \
      io.openshift.tags="test" \
      io.openshift.s2i.scripts-url="image:///opt/app-root/s2i/bin"
COPY s2i /opt/app-root/s2i
RUN chgrp -Rf root /home/major && chmod -Rf g+w /home/major
RUN chmod g+w /etc/passwd
USER 1000
CMD [ "/opt/app-root/s2i/bin/run" ]
