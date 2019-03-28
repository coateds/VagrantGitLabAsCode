execute "append to log" do
  command <<-EOF
    echo #{node['hosts']['jenkins']} >> /etc/hosts
  EOF
end

