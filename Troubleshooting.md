https://roboshop-dev.chakra86.shop -> r53, we configure FALB
FLAB -> https listener on 443
Rules - > roboshop-dev.chakra86.shop -> frontend target group
Health check 
Frontend instance -> calling https://roboshop-dev.chakra86.shop/api/catalogue/categories
the url is getting evaluated in nginx configuration.
