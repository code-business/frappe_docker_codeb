# About the repository

- This respository is used for the self hosted deployment of [ERPNext](https://github.com/frappe/erpnext)
- We use `development` as the main working branch, because `main` branch is the `fork` of [frappe/frappe_docker](https://github.com/frappe/frappe_docker) and we can sync that for future updates
- We create custom docker images of the `frappe/erpnext-worker` and `frappe/nginx-worker` as we need `hrms app` to be installed along with ERPNext
- Everything more about [Frappe](https://github.com/frappe/frappe) and [ERPNext](https://github.com/frappe/erpnext) in containers.

# Creating a Custom app

Learn how to containerize your custom Frappe app(s) in [this guide](custom_app/README.md).

# Deployment using Docker
- Install Docker Engine on Ubuntu using [this guide](https://docs.docker.com/engine/install/ubuntu/)
- Create custom docker images of the `frappe/erpnext-worker` and `frappe/nginx-worker` with additional apps using [this guide](custom_app/README.md)
- To add any additional apps update the `create-site` service of `custom-compose.yml` by adding following command at the end (currently installs `hrms`)
  ```shell
  bench --site [SITE_NAME] install-app [APP_NAME];
  ```
  - SITE_NAME (e.g. frontend)
  - APP_NAME (e.g. hrms)
- Start all the containers
  ```shell
  docker compose -f custom-compose.yml -d up
  ```
- Check app running status at `protocol://host:8080` (e.g. http://localhost:8080 or http://[EC2 IP]:8080)
# Original README of [frappe/frappe_docker](https://github.com/frappe/frappe_docker)

Original README.md can be found [here](original/README.md).