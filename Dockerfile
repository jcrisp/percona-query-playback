FROM centos:7
RUN yum -y update && \
  yum install -y git tbb tbb-devel cmake boost boost-devel make gcc-c++ doxygen mysql mariadb-devel python-sphinx wget && \
  yum clean all && rm -rf /var/cache/yum
WORKDIR /app
RUN git clone https://github.com/Percona-Lab/query-playback.git /app && \
  cd /app && git checkout 906f39258743 && \
  mkdir -p build_dir && cd /app/build_dir && \
  cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && make && make check && make install

ENTRYPOINT ["/app/build_dir/percona-playback"]
CMD ["--help"]
