
# Docker Development Environment

This repository provides a Docker environment that sets up a development environment with Node.js, npm, pnpm, Git, Tmux, and other useful tools, along with a customized `.bashrc` configuration.

## Features

- **Ubuntu jammy Base Image**: The Dockerfile uses Ubuntu 20.04 as the base image.
- **Node.js & NVM**: Node.js (v20.10.0) is installed via NVM, allowing for easy management of Node.js versions.
- **pnpm**: pnpm is installed globally for efficient package management.
- **Git & Tmux**: Git and Tmux are pre-installed, with a customized Tmux configuration cloned from the [gpakosz/.tmux](https://github.com/gpakosz/.tmux) repository.
- **Custom `.bashrc`**: A custom `.bashrc` file is included with helpful aliases, Git shortcuts, and more.

## Getting Started

### Prerequisites

Ensure you have Docker installed on your machine. You can download Docker from the official [Docker website](https://www.docker.com/get-started).

### Building the Docker Image

To build the Docker image from the provided `Dockerfile`, clone this repository and run the following command:

```bash
docker build -t my-dev-environment .
```

This will create a Docker image called `my-dev-environment` with all the tools and configurations pre-installed.

### Running the Docker Container

After building the image, you can start a container with:

```bash
docker run -it my-dev-environment
```

This will give you an interactive bash session inside the container.

### Accessing Node.js and npm

The container comes pre-installed with Node.js (v20.10.0) and npm, thanks to NVM. To verify the installation, you can run:

```bash
node -v
npm -v
```

### Using pnpm

pnpm is installed globally for better performance during package installations. You can verify the pnpm installation with:

```bash
pnpm -v
```

### Git and Tmux

Git and Tmux are also pre-installed in this environment. You can use Tmux with your custom configuration by typing:

```bash
tmux
```

Git comes with helpful aliases defined in the `.bashrc` file, such as `gs` for `git status` and `glg` for a simplified git log. To see all available Git aliases, refer to the `.bashrc` file.

### Custom `.bashrc`

This environment includes a custom `.bashrc` configuration that adds helpful aliases and functions, including:

- `ll`: List files with detailed information
- `mkcd <directory>`: Create and move to a new directory
- `gpush`: Push Git changes
- `gcomm`: Commit Git changes
- And more...

You can edit the `.bashrc` file to include your custom configurations or modify existing ones.

## Contributing

If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License.
