# Docker Setup for Shop Application with SQLite3 and Webpacker

This guide will help you set up and run the Shop application using Docker with SQLite3 database and Webpacker for JavaScript assets.

## Prerequisites

- Docker
- Docker Compose

## Setup Instructions

1. **Build the Docker images**

   ```bash
   docker-compose build
   ```

2. **Install JavaScript dependencies**

   ```bash
   docker-compose run web yarn install
   ```

3. **Run migrations**

   ```bash
   docker-compose run web rails db:migrate
   ```

4. **Compile Webpacker assets**

   ```bash
   docker-compose run web rails webpacker:compile
   ```

5. **Seed the database (if needed)**

   ```bash
   docker-compose run web rails db:seed
   ```

6. **Start the application**

   ```bash
   docker-compose up
   ```

   The application will be available at http://localhost:3000

## Webpacker Development

The setup includes a separate webpack-dev-server container that automatically recompiles your JavaScript assets when they change. This enables hot module replacement (HMR) for a better development experience.

If you need to manually recompile assets:

```bash
docker-compose run web rails webpacker:compile
```

## Troubleshooting Webpacker Issues

If you encounter issues with Webpacker:

1. **Check if the webpack-dev-server is running**

   ```bash
   docker-compose ps
   ```

2. **Verify manifest.json exists**

   ```bash
   docker-compose exec web ls -la public/packs/manifest.json
   ```

3. **Manually compile assets**

   ```bash
   docker-compose run web rails webpacker:compile
   ```

4. **Check Webpacker logs**

   ```bash
   docker-compose logs webpack
   ```

5. **Clear cache and recompile**

   ```bash
   docker-compose run web rm -rf tmp/cache
   docker-compose run web rails webpacker:compile
   ```

## Other Useful Commands

- **Run Rails commands**

  ```bash
  docker-compose run web rails [command]
  ```

- **Access the Rails console**

  ```bash
  docker-compose run web rails console
  ```

- **Run tests**

  ```bash
  docker-compose run web rails test
  ```

- **View logs**

  ```bash
  docker-compose logs -f
  ```

- **Stop all containers**

  ```bash
  docker-compose down
  ```

## Troubleshooting

- If you encounter permission issues with the entrypoint script, run:
  ```bash
  chmod +x entrypoint.sh
  ```

- If you need to reset the database:
  ```bash
  docker-compose run web rails db:reset
  ```

- To access the SQLite database directly:
  ```bash
  docker-compose run web sqlite3 db/development.sqlite3
  ```

## Notes

- SQLite database files are stored in the `db` directory and persisted using a Docker volume
- JavaScript assets are compiled using Webpacker and served through the webpack-dev-server in development
- This setup is suitable for development but not recommended for production use
