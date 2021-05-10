#!/bin/sh

set -e

: "${SCW_ACCESS_KEY?SCW_ACCESS_KEY environment variable must be set}"
: "${SCW_SECRET_KEY?SCW_SECRET_KEY environment variable must be set}"
: "${SCW_REGION?SCW_REGION environment variable must be set}"

cat <<EOF > ~/.config/rclone/rclone.conf
# Configuration file for rclone https://rclone.org/s3/#scaleway
[scaleway]
type = s3
env_auth = false
endpoint = s3.${SCW_REGION}.scw.cloud
access_key_id = ${SCW_ACCESS_KEY}
secret_access_key = ${SCW_SECRET_KEY}
region = ${SCW_REGION}
location_constraint =
acl = private
force_path_style = false
server_side_encryption =
storage_class =
EOF

# Run and preserve output for consumption by downstream actions
rclone "$@" >"${GITHUB_WORKSPACE}/rclone.output"

# Write output to STDOUT
cat "${GITHUB_WORKSPACE}/rclone.output"
