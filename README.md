## Server Requirements

- Node.js 18.7
- NPM

## Prepare deploy

1. First, ssh into your machine and create a directory (e.g. `~/services/digital-ocean-sample`)
2. Update the `./deploy.sh` script and replace `DROPLET_HOST`, `DROPLET_USER`, and `REMOTE_PATH` with the appropriate values. Optionally you should change the way rsync ssh's into your machine from the current `ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no`
3. On the server, create your `.env` file and add your _live_ `TRIGGER_API_KEY`:

```sh
cd ~/services/digital-ocean-sample`
echo "TRIGGER_API_KEY=<your live api key>" >> .env
```

## Deploy

When you want to deploy, just run the `./deploy.sh` script, which will build the typescript into `./dist` and then it will upload the following files to the `REMOTE_PATH`:

- Makefile
- package.json
- package-lock.json
- ./dist

## Running on the server

Before setting up systemd, you can test running on your server by changing into the directory and running `make start`. This will install production node modules, and run `node dist/index.js`.

## Running Locally

1. Run `npm install`
2. Add your _dev_ api key to a local (ignored) .env file:

```sh
echo "TRIGGER_API_KEY=<your dev api key>" >> .env
```

3. Run `make dev` and you should see a success message

## systemd Setup

To set up Systemd to make sure your Node.js service is running by calling make start, you can create a Systemd service unit file. Here is an example unit file that you can use as a starting point:

```
[Unit]
Description=Node.js Service

[Service]
WorkingDirectory=<REMOTE_PATH>
ExecStart=make start
Restart=always
User=<DROPLET_USER>

[Install]
WantedBy=multi-user.target
```

You will need to replace the placeholders <REMOTE_PATH> and <DROPLET_USER> with the appropriate values for your setup.

Save this file as nodejs-service.service in the /etc/systemd/system directory. Then, you can use the following commands to start, stop, and check the status of your service:

```sh
# Start the service
sudo systemctl start nodejs-service.service
# Stop the service
sudo systemctl stop nodejs-service.service
# Check the status of the service
sudo systemctl status nodejs-service.service
```

Finally, to make Systemd start the service automatically at boot, you can run the following command:

```sh
sudo systemctl enable nodejs-service.service
```
