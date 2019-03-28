execute 'log header' do
    command <<-EOF
      echo '*********'  >> #{node['log-file']['path']}
      echo 'install-jenkins recipe' >> #{node['log-file']['path']}
      echo ''  >> #{node['log-file']['path']}
    EOF
  end
  
  # On CentOS 7 (and RedHat/Oracle/Scientific Linux 7), the commands below will also open HTTP and SSH access in the system firewall. 
  # These are already installed and running
  # sudo yum install -y curl policycoreutils-python openssh-server
  # sudo systemctl enable sshd
  # sudo systemctl start sshd
  
  package %w(curl openssh-server)
  service 'sshd' do
    action [ :enable, :start ]
  end
  
  execute 'install' do
    command 'yum install policycoreutils-python -y'
  end
  
  # firewalld is not running
  # sudo firewall-cmd --permanent --add-service=http
  # sudo systemctl reload firewalld
  
  # These are already installed and running
  # sudo yum install postfix
  # sudo systemctl enable postfix
  # sudo systemctl start postfix
  package 'postfix'
  service 'postfix' do
    action [ :enable, :start ]
  end
  
  # Add the GitLab package repository.
  # Adds gitlab_gitlab-ee.repo to /etc/yum.repos.d
  execute 'config gitlab yum repo' do 
    command 'curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash'
  end
  
  # git lab must be installed in this fashion (as a single line)
  # The two resources below do not work.
  execute 'set gitlab url' do 
    command 'EXTERNAL_URL="https://gitlab.davecoate.com" yum install -y gitlab-ee'
  end
  
  # execute 'set gitlab url' do 
  #   command 'EXTERNAL_URL="https://gitlab.davecoate.com"'
  # end
  # 
  # # sudo EXTERNAL_URL="https://gitlab.davecoate.com" yum install -y gitlab-ee
  # package 'gitlab-ee' do
  #   flush_cache before: true
  #   action :install
  # end
  
  
  # To delete your old exception: 
  # Click the menu button  and choose Options. 
  # Select the Privacy & Security panel. 
  # Scroll down to the Certificates section. 
  # Click View Certificates to open the Certificate Manager window. 
  # In the Certificate Manager window click on the Servers tab. 
  # Find the item that corresponds to the site that generates the error. Note the Certificate Authority (CA) for that server - the CA name appears above the site name. 
  # Click on the server certificate that corresponds to the site that generates the error and press Delete.... 
  # Click OK when prompted to delete the exception. 
  # Click on the Authorities tab. 
  # Click on the item that corresponds to the CA that you noted earlier and then press Delete or Distrust.... 
  # Click OK when prompted to delete the exception. 
  # Click OK close the Certificate Manager window. 
  # Close the about:preferences page. Any changes you've made will automatically be saved. 