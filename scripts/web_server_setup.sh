 #! /bin/bash
 apt update
 apt -y install apache2
 echo "<html><body><p>Hello interview task.</p></body></html>" >  /var/www/html/index.html
 echo "ping pong" > /var/www/html/healthz
 sudo systemctl restart apache2