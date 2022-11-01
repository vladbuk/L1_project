#!/bin/bash
sudo apt update
sudo apt install -y apache2 mc
myip=$(curl ifconfig.io)
cat <<EOF | sudo tee /var/www/html/index.html
<html>
    <h1>My ${site_name} running on IP: $myip</h1>
    <p>Builded by Terraform and ${site_owner}</p>

    %{ for x in names ~}
        <p>Hello to ${x} from ${site_owner}</p>
    %{ endfor ~}

</html>
EOF

sudo systemctl enable apache2.service
sudo systemctl start apache2.service