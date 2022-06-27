#! /bin/bash
METADATA_VALUE=$(curl http://metadata.google.internal/computeMetadata/v1/instance/attributes/metaKey -H "Metadata-Flavor: Google")
apt update
apt -y install apache2
cat <<EOF > /var/www/html/index.html
<html><body><p>Accessing metadata value of instance: $METADATA_VALUE</p></body></html>