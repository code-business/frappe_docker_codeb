## Introduction

This is basic configuration for building images and testing custom apps that use Frappe.

- Change the `frappe` and `erpnext` versions in `docker-bake.hcl` to use them as base. These values correspond to tags and branch names on the github frappe and erpnext repo. e.g. `version-14`, `v14.16.0`
- Change `ci/clone-apps.sh` script to clone your private and public apps. Read comments in the file to update it as per need. Current script will install following apps in `repos` folder:
  - https://github.com/frappe/hrms.git
- Change `images/backend.Dockerfile` to copy and install required apps with `install-app`.
- Change `images/frontend.Dockerfile` to copy and install required apps with `install-app`.
- Change `docker-bake.hcl` for builds as per need.

## Files Introduction

You can see that there's four (4) files in this folder:

- `ci/clone-apps.sh`
- `backend.Dockerfile`,
- `frontend.Dockerfile`,
- `docker-bake.hcl`,

`ci/clone-apps.sh` clones the repository of all the apps that we need in the `repos` folder

Python code will be built in `backend.Dockerfile`. JS and CSS (and other fancy frontend stuff) files will be built in `frontend.Dockerfile`.

`docker-bake.hcl` is reference file for [Buildx Bake](https://github.com/docker/buildx/blob/master/docs/reference/buildx_bake.md). It helps to build images without having to remember all build arguments.

## Manually Build images
Execute the following commands from `custom_app` directory

Clone the apps that we need other than ERPNext (e.g. hrms) in the `repos` folder,

```shell
sh ./ci/clone-apps.sh
```

Set appropriate values of variables in `docker-bake.hcl`,

- `FRAPPE_VERSION` set to use frappe version during building images. Default is `version-13`.
- `ERPNEXT_VERSION` set to use erpnext version during building images. Default is `version-13`.

Build custom images of `frappe/erpnext-worker` and `frappe/nginx-worker`,

```shell
docker buildx bake -f docker-bake.hcl --load
```

Note:

- Use `docker buildx bake --load` to load images for usage with docker.
- Use `docker buildx bake --push` to push images to registry.
- Use `docker buildx bake --help` for more information.

## Installing multiple apps

- Add clone command of the app to `ci/clone-apps.sh`
- `backend.Dockerfile` builds contain `install-app` script that places app where it should be. Each call to script installs given app. Usage: `RUN install-app [APP_NAME]`.
