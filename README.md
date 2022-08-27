## LEMP stack docker env

+ OS : Ubuntu 18.04
+ Nginx 1.16
+ PHP-FPM 7.1
+ Node12

### Structure

```bash
lemp-docker
├── environment
│   └── nginx: sample nginx domain config
│   └── hosts: sample hosts file
├── logs: mount with log folder
├── src: 
├── .gitignore
├── docker-compose.yml
├── Dockerfile
├── entrypoint.sh: Run when docker up
└── README.md
```


### How to setup ?

- Step 1: Install docker / docker-compose
- Step 2: Add source code of project to folder `./src`
- Step 3: Add config `environment` 
- Step 4: Run `docker-compose build`
- Step 5: Run `docker-compose up -d` to running docker
