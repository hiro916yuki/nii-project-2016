#!/bin/bash

. /home/centos/notebooks/stepdefs/jenkins-utility/functions.sh

# Reset file for pdf 103 execute jenkins job
# Tasks:
#  Install jenkins-cli client if not installed.
#  Create job, sample using predefind configuration file.
#  Create job, sample2 using predefined configuration file.

ssh="ssh root@10.0.2.100 -i /home/centos/mykeypair"
jobs=(tiny_web.rspec
      tiny_web.rpmbuild
      tiny_web.rpmpublish
      tiny_web.imagebuild
      tiny_web.integration)

xml_file=(tiny_web.rspec.xml
          tiny_web.rpmbuild.xml
          tiny_web.rpmpublish.xml
          tiny_web.imagebuild.xml
          tiny_web.integration.xml)

xml_to_vm

${ssh} <<EOF 2> /dev/null

$(declare -f reset_job)
$(declare -f check_client_exists)

check_client_exists

for job in ${jobs[@]} ; do
    reset_job \$job \$job.xml
done

EOF
