#!/usr/bin/env bash

# Install Nginx if not already installed
if ! dpkg -s nginx > /dev/null 2>&1; then
    apt-get -y update
    apt-get -y install nginx
fi

# Create necessary directories if they don't exist
web_static_dir="/data/web_static"
releases_dir="${web_static_dir}/releases/test"
shared_dir="${web_static_dir}/shared"
index_file="${releases_dir}/index.html"

mkdir -p "${web_static_dir}" "${releases_dir}" "${shared_dir}"

# Create fake HTML index file
echo -e "<html>\n<head>\n</head>\n<body>\n\t<h1>Testing Nginx Configuration</h1>\n</body>\n</html>" > "${index_file}"

# Create symbolic link
symbolic_link="/data/web_static/current"
if [ -L "${symbolic_link}" ]; then
    rm "${symbolic_link}"
fi
ln -s "${releases_dir}" "${symbolic_link}"

# Set ownership to ubuntu user and group recursively
chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
config_file="/etc/nginx/sites-available/default"
new_config="location /hbnb_static {\n\talias ${symbolic_link}/;\n\tindex index.html;\n}"
sed -i "/server {/a ${new_config}" "${config_file}"

# Restart Nginx
service nginx restart
