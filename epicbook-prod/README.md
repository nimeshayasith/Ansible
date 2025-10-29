# EpicBook - Terraform + Ansible Deployment

## Project Structure
```
epicbook-prod/
├── terraform/azure/          # Infrastructure as Code
├── ansible/                  # Configuration Management
│   ├── roles/
│   │   ├── common/          # Base system setup
│   │   ├── nginx/           # Web server
│   │   └── epicbook/        # Application deployment
│   ├── site.yml
│   └── ansible.cfg
└── README.md
```

## Prerequisites
- Azure CLI installed and authenticated
- Terraform >= 1.0
- Ansible >= 2.9
- Your public IP address

## Deployment Steps

### 1. Update Your IP
Edit `terraform/azure/terraform.tfvars` and replace with your IP:
```bash
curl ifconfig.me  # Get your IP
```

### 2. Deploy Infrastructure
```bash
cd terraform/azure
terraform init
terraform plan
terraform apply -auto-approve
```

### 3. Test SSH Connection
```bash
$(terraform output -raw ssh_command) 'hostname'
```

### 4. Run Ansible
```bash
cd ../../ansible
ansible web -m ping
ansible-playbook site.yml
```

### 5. Verify
```bash
cd ../terraform/azure
curl http://$(terraform output -raw public_ip)
```

## Cleanup
```bash
cd terraform/azure
terraform destroy -auto-approve
```
