# Guava - Backend

This is the backend for the Guava application, a Flutter-based front-end application that displays articles on nutrition and sports. It is built with NestJS and is supported by MongoDB for data persistence. The application is Docker-ready for easy deployment.

The backend provides APIs for managing articles and their respective contents. It also handles the storage and retrieval of images via a dedicated `public/assets` directory.

## Initial Setup

### 1. Clone the repository

Start by cloning this repository to your local machine.

```shell
git clone https://github.com/DuncanTilliole/guava
```

### 2. Install dependencies

Navigate to the project directory and install the necessary dependencies:

```shell
cd guava/back
yarn install
```

### 3. Setup environment variables

This application requires certain environment variables to function properly. You'll need to create a .env file in the root directory of the project and add the following variables:

```properties
APP_PORT=<your-desired-port>
MONGODB_URL=<your-mongodb-connection-string>
```

### 4. Run the app

You can then run the application:

```shell
npm run start
```

For Docker-based deployment, build the Docker compose:

```shell
docker-compose up -d --build
```

Enjoy developing with the Guava backend!

Remember, if you encounter any problems or have any suggestions, feel free to open an issue or a pull request.

Made by TILLIOLE DUNCAN