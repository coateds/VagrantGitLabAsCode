# Instruction source

# You need to configure mail service on our server. We can use any mail service like postfix, sendmail, exim etc. In this article I am using postfix email service.
# yum install postfix 

# start and enable postfix
# service postfix start
# chkconfig postfix on
package 'postfix'
service 'postfix' do
  action [:enable, :start]
end

# yum install lokkit
# lokkit -s http -s ssh
package 'lokkit'
execute 'configure lokkit' do
  command 'lokkit -s http -s ssh'
end

# yum install curl openssh-server cronie
package %w(curl openssh-server cronie)

# does not work
# curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | bash

# copy file locally and run
# sudo curl  https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh -o script.rpm.sh
# + chmod and call file


# sudo yum install gitlab-ce


# sudo vim /etc/gitlab/gitlab.rb
# external_url 'http://gitlabce.davecoate.com'

# sudo gitlab-ctl reconfigure