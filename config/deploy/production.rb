server "52.199.20.125",
  user: "ec2-user",
  roles: %w{web db app},
  ssh_options: {
    user: "ec2-user",
    keys: %w(~/Downloads/エンジニア島編/rails-app-key.pem),
    forward_agent: false,
    auth_methods: %w(publickey password)
  }