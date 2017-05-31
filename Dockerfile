
FROM centos
RUN yum -y update
RUN yum install java openjdk
RUN yum install -y wildfly
ADD mkdir -p /opt/wildfly
RUN cd /opt/
RUN tar zxvf /root/wildfly-10.0.0.Final.tar.gz
RUN firewall-cmd --zone=public --add-port=8080/tcp --permanent
RUN firewall-cmd --zone=public --add-port=9990/tcp --permanent
RUN firewall-cmd --reload
RUN useradd -s /usr/sbin/nologin wildfly
RUN chown -R wildfly /opt/wildfly-9.0.1.Final
ADD cd /opt/wildfly-9.0.1.Final/bin
RUN ./add-user.sh 
RUN cd /etc/init.d
RUN ln -s /opt/wildfly/bin/init.d/wildfly-init-redhat.sh wildfly
RUN cd /etc/default
RUN service wildfly start
RUN chkconfig wildfly on
