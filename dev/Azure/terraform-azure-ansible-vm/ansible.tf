/**
 * # Ansible Integration for Azure VM Configuration
 * 
 * This configuration automates the post-deployment setup of the Azure VM using Ansible.
 * It triggers an Ansible playbook execution after the VM is successfully deployed,
 * ensuring consistent configuration and software installation without manual intervention.
 *
 * ## Features
 * - Automatically runs after VM deployment using dependency chains
 * - Dynamically updates Ansible inventory with the VM's private IP
 * - Uses local-exec provisioner to run Ansible commands securely
 * - Configures SSH options for first-time connections to new VMs
 */

# Ansible integration resource triggered by VM deployment
resource "null_resource" "ansible" {
  # Re-run this resource if VM ID changes (VM recreated)
  triggers = {
    vm_machine_ids = azurerm_linux_virtual_machine.cloudacademy_web_vm.virtual_machine_id
  }

  # Execute Ansible playbook via local-exec provisioner
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]  # Use bash for script execution
    working_dir = "${path.module}/ansible"  # Run from ansible directory
    
    # Command sequence to:
    # 1. Create dynamic inventory file by replacing HOST_IPS with actual VM IP
    # 2. Run the Ansible playbook with this inventory
    # 3. Configure SSH to ignore host key checking for first connection
    command     = <<EOT
        sed 's/HOST_IPS/${azurerm_linux_virtual_machine.cloudacademy_web_vm.private_ip_address}/g' hosts > vms
        ansible-playbook \
        -v -i vms playbook.web.yaml \
        --ssh-common-args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
    EOT
  }

  # Explicit dependency to ensure VM is fully deployed before Ansible runs
  depends_on = [
    azurerm_linux_virtual_machine.cloudacademy_web_vm
  ]
}