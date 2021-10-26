# alpine-deployer
Lightweight Docker image (Alpine based) with SSH client and RSync installed for deployment jobs.

## ⚙️ SSH Setup

### Environment variables
| ENV                     | Type     | Description                                           | If not set                                                |
|-------------------------|----------|-------------------------------------------------------|-----------------------------------------------------------|
|**DEPLOY_SERVER_USER**   | Variable | The user to login to the server as                    | Run the ssh command with `-l username` (or `username@ip`) |
|**DEPLOY_SERVER_IP**     | Variable | Deployment server IP address or hostname              | Run the ssh command with `-h ip` (or `username@ip`)       |
|**SSH_KNOWN_HOSTS**      | Variable | Deployment server fingerprints to add to known_hosts  | Ssh commands will run with `-o StrictHostKeyChecking=no`  |
|**SSH_PRIVATE_KEY**      | File     | The private key to use for authentication             | Run the ssh command with `-i /path-to-your-key`           |
|**SSH_PRIVATE_KEY_PASS** | Variable | The passphrase for the private key (if encrypted)     | If your private key is encrypted setup will fail          |

### Setup
Source `/setup/ssh.sh` in your CD job to setup SSH with the environment variables.

#### Example for Gitlab-CI:

```yaml
# gitlab-ci.yml

stages:
  - deploy

deploy:
  stage: deploy
  tags: [ docker ]
  image: tribal2/alpine-deployer:latest
  script:
    - . /setup/ssh.sh
    - ssh . "hostname && whoami"
```

## 🚂 Execute commands in the deployment server
```bash
# All environment variables set
ssh . "hostname && whoami"

# User not set
ssh -l username . "hostname && whoami"
ssh username@ipOrHost "hostname && whoami"

# Host not set
ssh -h ipOrHost . "hostname && whoami"
ssh ipOrHost "hostname && whoami"

# Key not set
ssh -i /path-to-your-key . "hostname && whoami"
ssh -i /path-to-your-key username@ipOrHost "hostname && whoami"
```

## 🛳️ Using the image from Docker Hub
```bash
docker pull alpine-deployer
docker run --rm -it alpine-deployer ash
```

## 👨‍💻 Repo and building the image for local use
```bash
git clone https://github.com/tribal2/alpine-deployer.git
cd alpine-deployer
docker build \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  -t alpine-deployer \
  .
```

## 🤝 Contributing

Contributions, issues and feature requests are welcome.<br />
Feel free to check [issues page](https://github.com/tribal2/alpine-deployer/issues) if you want to contribute.<br />

## 👤 Author

**Ricardo Tribaldos**

- Twitter: [@r_tribaldos](https://twitter.com/r_tribaldos)
- Github: [@tribal2](https://github.com/tribal2)

## Show your support

Please ⭐️ this [repository in Github](https://github.com/tribal2/alpine-deployer) if this project helped you!

## 📝 License

Copyright © 2021 [Ricardo Tribaldos](https://github.com/tribal2).<br />
This project is [MIT](https://github.com/tribal2/alpine-deployer/blob/master/LICENSE) licensed.