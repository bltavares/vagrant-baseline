provision () {
  PROVISION=$(echo "$@" | tr " " "-")
  (
  cd ${PUPPET_FILES:-/tmp/vagrant-puppet/manifests}
  sudo FACTER_hostname=$PROVISION puppet apply --confdir . init.pp --verbose --debug
  )
}
