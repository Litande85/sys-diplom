[web]
%{ for ip in web_ip ~}
${ip} ansible_ssh_private_key_file=/home/user/.ssh/id_rsa ansible_user=user ansible_python_interpreter=/usr/bin/python3
%{ endfor ~} 


[prometheus]
prometheus ansible_host=${prometheus_ip}  ansible_ssh_private_key_file=/home/user/.ssh/id_rsa ansible_user=user ansible_python_interpreter=/usr/bin/python3


[grafana]
grafana ansible_host=${grafana_ip}  ansible_ssh_private_key_file=/home/user/.ssh/id_rsa ansible_user=user ansible_python_interpreter=/usr/bin/python3


[elasticsearch]
elasticsearch ansible_host=${elasticsearch_ip}  ansible_ssh_private_key_file=/home/user/.ssh/id_rsa ansible_user=user ansible_python_interpreter=/usr/bin/python3


[kibana]
kibana ansible_host=${kibana_ip}  ansible_ssh_private_key_file=/home/user/.ssh/id_rsa ansible_user=user ansible_python_interpreter=/usr/bin/python3


[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -W %h:%p -q ${bastion_ip}"'


