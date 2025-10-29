[web]
epicbook-vm ansible_host=${public_ip} ansible_user=${admin_username} ansible_ssh_private_key_file=${private_key}

[web:vars]
ansible_python_interpreter=/usr/bin/python3
