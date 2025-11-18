https://roboshop-dev.chakra86.shop -> r53, we configure FALB
FLAB -> https listener on 443
Rules - > roboshop-dev.chakra86.shop -> frontend target group
Health check 
Frontend instance -> calling https://roboshop-dev.chakra86.shop/api/catalogue/categories
the url is getting evaluated in nginx configuration.

Go to ansible frontend role and replace the port 8080 with 80 in frontend's nginx config file.
Now apply the terrform takes time, so we manually update the port in frontend instance.

R53 -> *.backend-alb-dev.chakra86.shop -> backend ALB
Listener - 80
Listener rule - catalogue.backend-alb-dev.chakra86.shop -> roboshop-dev-catalogue target group
Health check
we get response from catalogue instance -> momgodb

login, select robot, add to cart
https://roboshop-dev.chakra86.shop/api/cart/add/chakra/HPTD/1

Do this checks
1) Security group rules
2) .service file dependencies
3) check host url and port number

Issue - While upgrading application in one VM it is successfully upgraded by terraform and ansible.
        Later few days, we are not able to ssh into that, but application is running
        something in playbook distrubed the server configuration bu application is running
        While installing python3-devel in vm it is dependent on openssl-libs package
        openssl-server was old but openssl-libs upgraded to new version
        version mismatch between openssl-libs and the openssl-server already present on server.
        SSH depends on this openssl, os it was broken and stopped.
1. Fix devops-practice AMI to have latest openssl
2. While installing python3-devel make sure openssl other packages also upgraded.
3. added below to fix the issue

changed this as part of latest python3-devel from repos have upgraded openssl-libs but other openssl packages are old in AMI, so mismatch occured. we are upgrading before installing python or after
- name: upgrade openssl packages
  ansible.builtin.dnf:
    name: "{{ item }}"
    state: latest
  loop:
  - openssl
  - openssl-libs
  - openssh
  - openssh-server
  - openssh-clients
        
        






