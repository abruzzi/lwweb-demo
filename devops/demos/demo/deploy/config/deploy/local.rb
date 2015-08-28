
server '192.168.2.105',
  user: 'liked',
  roles: 'app',
  ssh_options: {
    keys: %w(/Users/jtqiu/.ssh/id_vagrant_liked),
    forward_agent: true,
    auth_methods: %w(publickey)
  }