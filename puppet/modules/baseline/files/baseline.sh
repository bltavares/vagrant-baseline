provision () {
  PROVISION=$(echo "$@" | tr " " "-")
  (
  cd ${PUPPET_FILES:-/tmp/vagrant-puppet/manifests}
  sudo FACTER_hostname=$PROVISION puppet apply --confdir . init.pp --verbose --debug
  )

  if [[ $SHELL = *bash ]]; then
    echo "sourcing /etc/profile"
    source /etc/profile
  fi

  if [[ $SHELL = *zsh ]]; then
    echo "sourcing $HOME/.zshenv"
    source $HOME/.zshenv
  fi
}
