# Production-Grade Infrastructure with Terraform, Ansible, and Spacelift

This repository demonstrates how to build production-ready cloud infrastructure using the following tools:

🔵 **Terraform** for infrastructure provisioning  
🔵 **Ansible** for configuration management  
🔵 **Spacelift** for CI/CD automation of Infrastructure as Code (IaC)

> Secrets and keys are managed securely using Spacelift's context-based secret management.

## Project Structure

```
📁 SpaceLift-Project/
├── 📁 terraform/
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   └── variables.tf
│
├── 📁 ansible/
│   ├── install_nginx.yml
│   └── install_htop.yml
│
└── spacelift.yml
└── README.md
```

## What It Does

🟣 Terraform provisions 3 EC2 Ubuntu servers in AWS  
🟣 Public keys are injected during provisioning  
🟣 Ansible connects via SSH using a private key and installs packages like `htop`  
🟣 Spacelift handles the following:
  - Plans infrastructure changes
  - Executes provisioning
  - Runs Ansible with `--check` in plan phase and real apply during deploy phase

## Ansible Playbook Example

```yaml
# ansible/install_htop.yml
- name: Install htop
  hosts: all
  become: yes
  tasks:
    - name: Ensure htop is installed
      apt:
        name: htop
        state: present
```

## SSH Key Management

🔵 SSH private key (`tf-keyy`) is stored in Spacelift as a multiline secret  
🔵 Format must be preserved exactly like below:

```
-----BEGIN OPENSSH PRIVATE KEY-----
...
-----END OPENSSH PRIVATE KEY-----
```

## Lessons Learned

🟣 `libcrypto` errors are usually due to a corrupt or misformatted SSH key in Spacelift  
🟣 Always test SSH connections locally before integrating with CI/CD  
🟣 Spacelift enables a clean separation between planning and applying infra/config changes

## Related Tools

- Terraform: https://www.terraform.io/
- Ansible: https://www.ansible.com/
- Spacelift: https://spacelift.io/
- AWS EC2: https://aws.amazon.com/ec2/

## Contributing

Pull requests are welcome for adding more roles, resources, or enhancements to the pipeline.

## LinkedIn Post Coming Soon

Follow me on [LinkedIn](https://linkedin.com/in/dakshsawhneyy) to see how this project works in real-world production automation.
