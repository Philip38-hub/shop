# Shop Application

This is a Rails-based e-commerce application that allows users to browse, create, and manage products. It uses modern Rails features and integrates with Webpacker for JavaScript asset management.

## Requirements

- Ruby `3.1.4`
- Rails `~> 7.1.0`
- Node.js `>= 14.0.0`
- Yarn `>= 1.22.0`
- SQLite3 (for the database)

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://learn.zone01kisumu.ke/git/pochieng/shop.git
   cd shop
   ```

2. **Install Ruby Dependencies**:
   Ensure you are using Ruby `3.1.4`:
   ```bash
   rbenv install 3.1.4
   rbenv local 3.1.4
   gem install bundler
   bundle install
   ```

3. **Install JavaScript Dependencies**:
   Ensure Node.js `>= 14.0.0` is installed. Then, install dependencies using Yarn:
   ```bash
   yarn install
   ```

4. **Setup the Database**:
   Run the following commands to set up the database:
   ```bash
   rails db:setup
   ```

5. **Compile Assets**:
   Compile Webpack assets:
   ```bash
   bin/webpack
   ```

6. **Start the Server**:
   Start the Rails server:
   ```bash
   rails server
   ```

   Visit the application at [http://localhost:3000](http://localhost:3000).

## Features

- User authentication with Devise.
- Product management (CRUD operations).
- Image uploads using CarrierWave and MiniMagick.
- Responsive design with Bulma CSS framework.
- Stimulus.js for interactive UI components.

## Development Tools

- **Better Errors**: Enhanced error pages for development.
- **Guard**: File watcher for automated tasks.
- **Spring**: Speeds up development by preloading the application.

## Testing

- System tests with Capybara and Selenium WebDriver.
- Run tests using:
  ```bash
  rails test
  ```

## Deployment

- Ensure the production environment is configured with a database and asset compilation.
- Precompile assets:
  ```bash
  RAILS_ENV=production bin/webpack
  ```

## Troubleshooting

- **Webpacker Issues**:
  If Webpacker cannot find assets, ensure `yarn install` and `bin/webpack` have been run.
- **Port Conflicts**:
  If port `3000` is in use, specify a different port:
  ```bash
  rails server -p 3001
  ```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
