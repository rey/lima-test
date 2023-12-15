#!/bin/bash

debug=1
vm_name=$(basename "${PWD}")
vm_working_directory=$(realpath "${PWD}")

# Check if debug or nah
if [[ ${debug} = 1 ]]; then
  echo
  echo "📠 Hello! Let's create a new virtual machine!"
  echo "📠"
  echo "📠  Name:"
  echo "📠      ${vm_name}"
  echo "📠  Working directory:"
  echo "📠      ${vm_working_directory}"
  echo
fi

# Check if a vm is already running
check_for_existing_vm=$(limactl list ${vm_name} 2>/dev/null | wc -l | sed 's/^[[:space:]]*//')

# If there's 2 rows let's assume a match
if [[ ${check_for_existing_vm} = 2 ]]; then
  limactl stop --force ${vm_name}
  limactl delete --force ${vm_name}
fi

# Start the VM with a bunch of options
# https://lima-vm.io/docs/templates/
limactl start \
  --name="${vm_name}" \
  --set=".mounts[0].location=\"${vm_working_directory}\",.mounts[0].writable="true"" \
  --vm-type=vz \
  --mount-type=virtiofs \
  --tty=false