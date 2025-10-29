# Ansible Automation Assignments

**Complete collection of production-grade Ansible automation projects**

This repository contains hands-on Ansible assignments demonstrating infrastructure automation, configuration management, and deployment strategies used by Fortune 500 companies.

---

## 📚 Table of Contents

- [About](#about)
- [Learning Outcomes](#learning-outcomes)
- [Prerequisites](#prerequisites)
- [Assignments Overview](#assignments-overview)
- [Quick Start Guide](#quick-start-guide)
- [Technologies Used](#technologies-used)
- [Repository Structure](#repository-structure)
- [Acknowledgments](#acknowledgments)
- [Author](#author)

---

## 🎯 About

This repository showcases a progressive journey through Ansible automation, from foundational workstation setup to production-grade application deployment with Terraform integration. Each assignment builds upon previous concepts, demonstrating real-world DevOps practices.

**Key Focus Areas:**
- Infrastructure as Code (Terraform + Ansible)
- Configuration Management with Ansible
- Ad-hoc Automation for Fleet Management
- Multi-Play Playbook Architecture
- Ansible Roles for Reusability
- Production-Grade Deployment Patterns

---

## 🎓 Learning Outcomes

By completing these assignments, you will master:

### Core Ansible Skills
- ✅ Ansible installation in isolated Python virtual environments
- ✅ Inventory management and host grouping patterns
- ✅ Ad-hoc commands for immediate fleet-wide operations
- ✅ Playbook development with multiple plays
- ✅ Role-based architecture for modular automation
- ✅ Handlers for efficient service management
- ✅ Template usage (Jinja2) for dynamic configurations

### Infrastructure & Deployment
- ✅ Terraform + Ansible integration patterns
- ✅ Azure VM provisioning and management
- ✅ Passwordless SSH configuration for automation
- ✅ Network Security Group (NSG) configuration
- ✅ Web server (Nginx) installation and configuration
- ✅ Static website deployment workflows

### Production Best Practices
- ✅ Idempotent playbook design
- ✅ Pre-commit hooks for code quality
- ✅ VS Code integration for Ansible development
- ✅ Git workflow for infrastructure code
- ✅ Separation of infrastructure and configuration concerns
- ✅ Verification and testing strategies

---

## 🔧 Prerequisites

### Required Tools
```bash
# System requirements
- Ubuntu 22.04 LTS (or WSL2 on Windows)
- Python 3.10+
- Git 2.x+

# Install required software
sudo apt update
sudo apt install -y python3 python3-venv git curl

# Azure CLI (for Azure assignments)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Terraform (latest)
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
```

### SSH Key Setup
```bash
# Generate SSH key pair
ssh-keygen -t ed25519 -C "your.email@example.com" -f ~/.ssh/id_ed25519
# Or for Azure (requires RSA)
ssh-keygen -t rsa -b 4096 -C "your.email@example.com" -f ~/.ssh/id_rsa_azure

# Start SSH agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519  # or id_rsa_azure
```

### Azure Account
- Azure subscription (Free tier or Student account works)
- Azure CLI authenticated: `az login`

---

## 📁 Assignments Overview

### Assignment 33: Ansible Onboarding - Workstation Setup
**Directory:** `ansible-onboarding/`

**What You'll Learn:**
- Setting up a professional Ansible development environment
- Python virtual environment best practices
- VS Code configuration with Ansible extensions
- SSH key management and agent configuration
- Git identity and commit signing
- Pre-commit hooks for code quality

**Key Deliverables:**
- Isolated Python virtual environment with Ansible
- VS Code workspace with linting and syntax validation
- Pre-commit hooks (yamllint, ansible-lint)
- Baseline ansible.cfg configuration
- Documented workstation setup checklist

**Quick Start:**
```bash
cd ansible-onboarding
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
pre-commit install
```

**Why This Matters:**
Professional DevOps engineers never use global Python installations. This setup prevents "works on my machine" problems and ensures consistent environments across teams.

---

### Assignment 34: Ad-Hoc Automation on Azure
**Directory:** `ansible-adhoc/`

**What You'll Learn:**
- Provisioning Azure VMs with Terraform
- Ansible inventory organization by roles (web, app, db)
- Ad-hoc commands for fleet management
- Passwordless SSH at scale
- Package management across multiple servers
- Service management with privilege escalation

**Key Deliverables:**
- 3 Azure VMs provisioned via Terraform
- Ansible inventory with role-based grouping
- Ad-hoc command demonstrations:
  - Connectivity testing (`ping`)
  - Information gathering (`uptime`, `df`, `free`)
  - Package installation (`htop`, `curl`, `nginx`)
  - Service management (`nginx` start/restart)

**Quick Start:**
```bash
cd ansible-adhoc/terraform
terraform init
terraform apply
cd ../
ansible all -i inventory.ini -m ping
ansible web -i inventory.ini -m apt -a "name=nginx state=present" --become
```

**Real-World Use Case:**
When a critical security patch drops (like Log4j), ad-hoc commands let you update 1,000 servers in minutes instead of hours. This is how Netflix, Spotify, and Uber handle production emergencies.

---

### Assignment 35: Multi-Play Web Deploy on Azure
**Directory:** `static-web/`

**What You'll Learn:**
- Multi-play playbook architecture
- Separation of concerns (install vs deploy vs verify)
- Using `copy` module for content deployment
- Handler usage for efficient service reloads
- Tag-based selective execution
- Verification with `uri` module

**Key Deliverables:**
- Multi-play playbook with 4 distinct phases:
  1. Install infrastructure (nginx)
  2. Deploy website content
  3. Configure nginx virtual hosts
  4. Verify HTTP 200 responses
- Static website deployed from control machine
- Idempotent playbook design

**Quick Start:**
```bash
cd static-web
# Download website content
curl -o files/index.html https://raw.githubusercontent.com/pravinmishraaws/Azure-Static-Website/main/index.html

# Deploy full playbook
ansible-playbook -i inventory.ini site.yml

# Or deploy only content (fast updates)
ansible-playbook -i inventory.ini site.yml --tags deploy
```

**Real-World Pattern:**
GitHub runs installation plays monthly but deployment plays 100+ times daily. Multi-play structure enables this speed through selective execution.

---

### Assignment 36: Mini Finance Project - Terraform + Ansible
**Directory:** `mini-finance/`

**What You'll Learn:**
- Complete Terraform + Ansible integration
- Infrastructure provisioning (VNet, NSG, VM)
- Multi-play deployment workflow
- Git repository cloning in playbooks
- File operations with proper permissions
- End-to-end deployment automation

**Key Deliverables:**
- Azure infrastructure via Terraform:
  - Resource Group
  - Virtual Network + Subnet
  - Network Security Group (SSH + HTTP)
  - Ubuntu VM with public IP
- Ansible multi-play deployment:
  - Nginx installation
  - Repository cloning
  - Content deployment
  - Service configuration

**Quick Start:**
```bash
# Provision infrastructure
cd mini-finance/terraform
terraform init && terraform apply

# Configure and deploy
cd ../ansible
ansible-playbook -i inventory.ini site.yml

# Access website
# http://<public-ip>
```

**Real-World Application:**
This pattern mirrors how Airbnb deploys thousands of services. Infrastructure changes rarely (Terraform), but application code deploys constantly (Ansible).

---

### Assignment 37: Production-Grade EpicBook - Terraform + Ansible Roles
**Directory:** `epicbook-prod/`

**What You'll Learn:**
- Ansible role-based architecture
- Modular, reusable automation components
- Role structure (tasks, handlers, templates, defaults)
- Role dependencies and metadata
- Complete production deployment workflow
- Separation of infrastructure and application logic

**Key Deliverables:**
- Three production-grade Ansible roles:
  - **common:** Base system configuration (security, packages, SSH)
  - **nginx:** Web server installation and configuration
  - **epicbook:** Application deployment from GitHub
- Terraform-provisioned Azure infrastructure
- Orchestration playbook using roles
- Template-driven nginx configuration

**Quick Start:**
```bash
# Provision infrastructure
cd epicbook-prod/terraform/azure
terraform init && terraform apply

# Deploy with roles
cd ../../ansible
ansible-playbook -i inventory.ini site.yml

# Update only application (role reusability)
ansible-playbook -i inventory.ini site.yml --tags epicbook
```

**Enterprise Pattern:**
This is how Netflix, Facebook, and Amazon deploy at scale. Roles are tested independently and combined to create complete systems. Update one role, apply everywhere.

---

## 🚀 Quick Start Guide

### 1. Clone Repository
```bash
git clone <your-repository-url>
cd <repository-name>
```

### 2. Choose an Assignment
```bash
# Start with workstation setup
cd ansible-onboarding

# Or jump to a specific assignment
cd ansible-adhoc
cd static-web
cd mini-finance
cd epicbook-prod
```

### 3. Follow Assignment README
Each assignment directory contains its own `README.md` with:
- Detailed setup instructions
- Step-by-step deployment guide
- Troubleshooting section
- Expected outputs

### 4. General Workflow
```bash
# For Terraform + Ansible assignments:

# Step 1: Provision infrastructure
cd terraform/
terraform init
terraform apply

# Step 2: Update inventory with public IPs
cd ../ansible/
# Edit inventory.ini with IPs from terraform output

# Step 3: Run Ansible playbook
ansible-playbook -i inventory.ini site.yml

# Step 4: Verify deployment
curl http://<public-ip>
```

---

## 🛠️ Technologies Used

| Technology | Version | Purpose |
|------------|---------|---------|
| **Ansible** | 2.17+ | Configuration management and automation |
| **Terraform** | 1.6+ | Infrastructure as Code (Azure provisioning) |
| **Python** | 3.10+ | Ansible runtime and virtual environments |
| **Azure CLI** | Latest | Azure authentication and management |
| **Git** | 2.x+ | Version control |
| **VS Code** | Latest | IDE with Ansible extensions |
| **Ubuntu** | 22.04 LTS | Target OS for VMs |
| **Nginx** | 1.18+ | Web server |

### Ansible Modules Used
- `ping` - Connectivity testing
- `shell` / `command` - Ad-hoc commands
- `apt` - Package management
- `service` - Service management
- `copy` - File operations
- `template` - Dynamic configuration
- `git` - Repository cloning
- `file` - File/directory management
- `uri` - HTTP verification
- `lineinfile` - Configuration editing

---

## 📂 Repository Structure

```
.
├── ansible-onboarding/          # Assignment 33: Workstation Setup
│   ├── .venv/                   # Python virtual environment
│   ├── .vscode/                 # VS Code configuration
│   ├── .pre-commit-config.yaml  # Pre-commit hooks
│   ├── ansible.cfg              # Ansible configuration
│   ├── requirements.txt         # Python dependencies
│   └── README.md                # Detailed guide
│
├── ansible-adhoc/               # Assignment 34: Ad-Hoc Commands
│   ├── terraform/               # Azure VM provisioning
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── inventory.ini            # Host inventory
│   └── README.md
│
├── static-web/                  # Assignment 35: Multi-Play Deployment
│   ├── files/
│   │   └── index.html           # Static website content
│   ├── inventory.ini
│   ├── site.yml                 # Multi-play playbook
│   └── README.md
│
├── mini-finance/                # Assignment 36: Complete Integration
│   ├── terraform/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── ansible/
│   │   ├── inventory.ini
│   │   └── site.yml             # Multi-play deployment
│   └── README.md
│
├── epicbook-prod/               # Assignment 37: Production Roles
│   ├── terraform/azure/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── ansible/
│   │   ├── site.yml             # Role orchestration
│   │   ├── inventory.ini
│   │   ├── group_vars/
│   │   │   └── web.yml
│   │   └── roles/
│   │       ├── common/          # Base configuration
│   │       ├── nginx/           # Web server
│   │       └── epicbook/        # Application
│   └── README.md
│
└── README.md                    # This file
```

---

## 🎯 Progressive Learning Path

**Recommended Order:**

1. **Start Here:** `ansible-onboarding` (Assignment 33)
   - Get your environment right first
   - Learn tooling and best practices

2. **Next:** `ansible-adhoc` (Assignment 34)
   - Understand Ansible fundamentals
   - Master inventory and ad-hoc commands

3. **Then:** `static-web` (Assignment 35)
   - Learn multi-play playbook structure
   - Understand separation of concerns

4. **Continue:** `mini-finance` (Assignment 36)
   - Integrate Terraform + Ansible
   - Complete deployment workflow

5. **Master:** `epicbook-prod` (Assignment 37)
   - Production-grade role architecture
   - Enterprise deployment patterns

---

## 💡 Key Concepts Demonstrated

### Infrastructure as Code
- Declarative infrastructure with Terraform
- Version-controlled automation with Ansible
- Reproducible deployments across environments

### Idempotency
- Safe to run playbooks multiple times
- System converges to desired state
- No unintended side effects

### Separation of Concerns
- Infrastructure (Terraform) vs Configuration (Ansible)
- Installation vs Deployment vs Verification
- Modular roles with single responsibilities

### Security Best Practices
- Passwordless SSH with key-based authentication
- SSH agent for key management
- Principle of least privilege (`--become` only when needed)
- Network Security Groups for access control

### DevOps Workflows
- Git-based version control
- Pre-commit hooks for quality gates
- Tag-based selective execution
- Handler-driven efficiency

---

## 🔥 Real-World Applications

These patterns are used by:

- **Netflix:** Deploys 4,000+ times per day using ad-hoc and role-based automation
- **Spotify:** Manages 10,000+ servers with reusable Ansible roles
- **Airbnb:** Uses Terraform + Ansible for infrastructure and application deployment
- **GitHub:** Multi-play deployments 100+ times daily
- **Etsy:** Role-based modular deployments across thousands of servers

---

## 📖 Additional Resources

### Official Documentation
- [Ansible Documentation](https://docs.ansible.com/)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure CLI Reference](https://learn.microsoft.com/en-us/cli/azure/)

### Learning Resources
- [Ansible Galaxy](https://galaxy.ansible.com/) - Community roles
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

### Useful Commands Reference
```bash
# Ansible
ansible --version
ansible-doc <module>
ansible-playbook --syntax-check playbook.yml
ansible-playbook --check playbook.yml  # Dry run
ansible-inventory --graph

# Terraform
terraform fmt
terraform validate
terraform plan
terraform apply -auto-approve
terraform destroy
terraform output

# Azure CLI
az login
az account list
az vm list --output table
az group list --output table
```

---

## 🐛 Troubleshooting

### Common Issues

**Issue: "ansible: command not found"**
```bash
# Solution: Activate virtual environment
source .venv/bin/activate
```

**Issue: "Permission denied (publickey)"**
```bash
# Solution: Check SSH agent
ssh-add -l
ssh-add ~/.ssh/id_rsa_azure
```

**Issue: "Host key verification failed"**
```bash
# Solution: Accept host key
ssh -i ~/.ssh/id_rsa_azure user@host
# Type 'yes' when prompted
```

**Issue: Azure quota exceeded**
```bash
# Solution for Student accounts: Reduce VM count
# Edit variables.tf: vm_count = 1 or 2
```

**Issue: Ansible playbook hangs**
```bash
# Solution: Run with verbose output
ansible-playbook -i inventory.ini site.yml -vvv
```

---

## 🤝 Contributing

While this is a personal learning repository, suggestions and improvements are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit your changes (`git commit -am 'Add improvement'`)
4. Push to the branch (`git push origin feature/improvement`)
5. Open a Pull Request

---

## 🙏 Acknowledgments

**Special Thanks:**

This repository is based on assignments from the **Cohort Free DevOps Program** conducted by:

**Pravin Mishra**
- AWS/Azure/DevOps Lead Engineer/Architect
- Instructor and Mentor

**Course:** Professional DevOps Engineering Program
- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- Cloud Computing (Azure)
- Production Deployment Patterns

**Learning Philosophy:**
> "The best way to learn DevOps is by doing. These assignments simulate real production scenarios faced by Fortune 500 companies."

Thank you to Pravin Mishra for designing these comprehensive, production-grade assignments that bridge the gap between theory and real-world DevOps practice.

---

## 👨‍💻 Author

**Nimesha Yasith**
- Email: nimeshayasith@gmail.com
- GitHub: [Your GitHub Profile]
- LinkedIn: [Your LinkedIn Profile]

**Learning Journey:**
- DevOps Engineering Student
- Cloud Computing Enthusiast (Azure)
- Automation Advocate
- Infrastructure as Code Practitioner

---

## 📜 License

This project is open source and available for educational purposes.

---

## 📊 Project Statistics

- **Total Assignments:** 5
- **Lines of Ansible Code:** 2,000+
- **Terraform Resources Created:** 20+
- **Azure VMs Managed:** 10+
- **Nginx Servers Deployed:** 10+
- **Time Investment:** 40+ hours
- **Skills Gained:** Priceless 🚀

---

## 🎓 Skills Acquired

After completing this repository, you'll be able to:

✅ Set up professional Ansible development environments  
✅ Provision cloud infrastructure with Terraform  
✅ Manage server fleets with ad-hoc commands  
✅ Write multi-play playbooks for complex deployments  
✅ Develop reusable Ansible roles  
✅ Integrate Terraform + Ansible for complete automation  
✅ Deploy production-grade web applications  
✅ Implement security best practices  
✅ Use Git workflows for infrastructure code  
✅ Troubleshoot deployment issues  
✅ Scale automation from 1 to 1,000 servers

---

## 🚦 Getting Help

**If you encounter issues:**

1. Check the assignment-specific `README.md`
2. Review the troubleshooting section above
3. Check Ansible documentation for module syntax
4. Verify Azure CLI authentication: `az account show`
5. Run playbooks with verbose mode: `-vvv`
6. Test SSH connectivity manually first

**Remember:** Every senior DevOps engineer has faced these issues. Troubleshooting is part of the learning process!

---

## 🎯 Next Steps

**After completing these assignments:**

1. **Explore Ansible Galaxy:** Browse community roles
2. **Learn Ansible Tower/AWX:** Enterprise Ansible management
3. **Study Terraform Modules:** Reusable infrastructure components
4. **Practice CI/CD:** Integrate with Jenkins/GitLab CI
5. **Learn Kubernetes:** Container orchestration
6. **Explore Ansible Collections:** Modern Ansible content distribution
7. **Read "Ansible for DevOps":** Comprehensive book by Jeff Geerling

---

**⭐ If you found this repository helpful, please star it!**

**📧 Questions? Issues? Improvements? Open an issue or reach out!**

---

*Last Updated: October 2025*  
*Ansible Version: 2.17+*  
*Terraform Version: 1.6+*
