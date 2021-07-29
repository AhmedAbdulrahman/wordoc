# WORDOC
A pretty simplified Docker Compose workflow that sets up a LAMP stack for Wordpress Development.

## Usage
To get started, make sure you have **Docker installed** on your system:
- Install Docker on [Mac](https://docs.docker.com/docker-for-mac/install/)
- Install Docker on [Linux](https://docs.docker.com/engine/install/ubuntu/)
- Install Docker on [Windows](https://docs.docker.com/docker-for-windows/install/)

Next, clone this repository!. Then, navigate in your terminal to the directory you cloned this `repo`, and spin up the containers for the web server by running:

```bash
docker-compose up --build -d
```

The following are built for our web server, with their exposed ports detailed:

- **WP** - `:80`
- **MYSQL** - `:3306`
- **ADMINER** - `:8080`
- **MAILHOG** - `:8025`

## Persistent MySQL Storage

By default, whenever you bring down the Docker network, your MySQL data will be removed after the containers are destroyed. If you would like to have persistent data that remains after bringing containers down and back up, do the following:

1. Create a `db_data` folder in the project root.
2. Under the `db` service in your `docker-compose.yml` file, add the following lines:

```
volumes:
  - ./db_data:/var/lib/mysql
```

and then list all `volumes` under:
```
networks:...
services: ...

# This line
volumes:
  db_data:
```

In case if you want persistent the data but not storing it inside `mysql` folder, change above line to:

```
volumes:
  - db_data:/var/lib/mysql
```

## MailHog

The `WORDOC` uses MailHog as the default application for testing email sending and general SMTP work during local development. Using the provided Docker Hub image, getting an instance set up and ready is simple and straight-forward. The service is included in the `docker-compose.yml` file, and spins up alongside the webserver and database services.

To see the dashboard and view any emails coming through the system, visit [localhost:8025](http://localhost:8025).
