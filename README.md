## Nginx 1.16, PHP-FPM 7.1 & Node12 based on Ubuntu 18.04.

### Structure

- environment
    - nginx:folder : Domain + nginx config 
    - hosts : sample hosts file
- logs : mount with log folder
- src : Source code of project
- .gitignore
- docker-compose.yml
- Dockerfile
- entrypoint.sh


### How to setup ?

- Step 1: Install docker / docker-compose
- Step 2: Add source code of project to folder `./src`
- Step 3: Add config `environment` 
- Step 4: Run `docker-compose build`
- Step 5: Run `docker-compose up -d` to running docker
