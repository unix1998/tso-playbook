#!/bin/bash

#generate ssh if it doesn't exist
if [ ! -f ~/.ssh/id_rsa ]; then
   echo
   echo ssh does not exist, creating it.............
   ssh-keygen -q -f ~/.ssh/id_rsa -N ""
fi

echo 
echo This will check/install software dependency...............................
echo

#check sshpass
rpm -qa sshpass > epelx
if [[ ! -s epelx ]]; then
   sudo yum install sshpass -y
fi
#check ansible
rpm -qa ansible > epely
if [[ ! -s epely ]]; then
   sudo yum install ansible -y
fi

while true; do
    read -p "Do you want to copy the ssh to the client(y/n)?" yn
    case $yn in
        [Yy]* )    
	      #if secret is not created
              if [ ! -f secret ]; then
	         echo
                 echo "Please create your secret first! (e.g. echo Your_AD_password > secret)"
                 exit 1
              fi
              pass=$(cat secret)
              awk -v password="$pass" '{print "sshpass -p " password " ssh-copy-id -o StrictHostKeyChecking=no " $1}' inventory > sshcopy
              chmod u+x sshcopy
              ./sshcopy
              break
              ;;
        [Nn]* ) break
                ;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo
echo Pinging client connectivity............................
echo
ansible all -i inventory -m ping
if [ $? -gt 0  ]; then
   echo
   read -p "One or more client connectivity failed. Troubleshoot it!" yn
fi

# rm -f epel* sshcopy  