#!/bin/sh

echo 'Setting up SSH for deployment...'

# Setup SSH
mkdir -p ~/.ssh
cat <<EOF > ~/.ssh/config
Host *
  ForwardAgent no
EOF

# Setup SSH User
if test -n ${DEPLOY_SERVER_USER-}; then
  echo "  User $DEPLOY_SERVER_USER" >> ~/.ssh/config
fi

# Setup SSH Hostname
if test -n ${DEPLOY_SERVER_IP-}; then
  echo "  Hostname $DEPLOY_SERVER_IP" >> ~/.ssh/config
fi

# Setup .ssh/known_hosts
if test -z "${SSH_KNOWN_HOSTS-}"; then
  echo 'No server fingerprints supplied. SSH will run with "StrictHostKeyChecking=no"'
  echo '  StrictHostKeyChecking no' >> ~/.ssh/config
else
  echo "$SSH_KNOWN_HOSTS" > ~/.ssh/known_hosts
  chmod 644 ~/.ssh/known_hosts
  echo '  StrictHostKeyChecking yes' >> ~/.ssh/config
fi

# Setup SSH Agent with private key
if [[ ! -f "$SSH_PRIVATE_KEY" ]]; then
  echo 'No private key supplied. Exiting SSH setup';
  exit 0;
fi

cat $SSH_PRIVATE_KEY > ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

echo '  IdentityFile ~/.ssh/id_rsa' >> ~/.ssh/config

eval $(ssh-agent -s)

if test -z ${SSH_PRIVATE_KEY_PASS-}; then
  echo 'Adding unencrypted private key to agent...'
  ssh-add ~/.ssh/id_rsa
else
  echo 'Adding private key with passphrase to agent...'
  cat ~/.ssh/id_rsa \
    | tr -d '\r' \
    | DISPLAY=":0.0" \
      SSH_ASKPASS=/setup/ssh-askpass.sh \
      setsid \
      ssh-add -
fi
