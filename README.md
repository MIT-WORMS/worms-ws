## worms-ws

This repository contains the high-level setup for development and deployment of the WORMS project. Development should take place within a docker environment to emulate the setup on the actual robot. 

## Development Setup

A development setup is provided within the .devcontainer directory. Setup instructions assume you are using VS Code, but the provided Dockerfile should work if you wish to launch it directly. If you do not already have VS Code, follow the instructions [here](https://code.visualstudio.com/docs/setup/setup-overview) to install it.

> **:warning: Warning**<br>
> These steps have only been tested on Windows and Linux. The process should be similar for Mac, but you may run into some issues. If you need any help with setup, message in the Slack and we will try to help.

### 0. Install WSL (Windows only)

For Windows, you need to start by downloading Windows Subsystem for Linux (WSL). You can do this by opening PowerShell in administrator mode and running the following command:

```powershell
wsl --install
```

If you have issues with this step, check the official Windows support page on [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).

### 1. Install Docker

**Windows/Mac:** Start off by installing [Docker Desktop](https://code.visualstudio.com/docs/devcontainers/containers#_installation). If you are on Windows, make sure to follow the steps for WSL setup.

**Linux:** If you want the full Docker Desktop application follow the same link as above. On Linux, you also have the option to install just [Docker Engine](https://docs.docker.com/engine/install/) which has less overhead.

### 2. Configure VS Code

Within VS Code, press the "Extensions" button and install the following extensions (just search for their name or identifier):

| Extension | Identifier | OS |
| --- | --- | --- |
| [Docker](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker) | `ms-azuretools.vscode-docker` | All |
| [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) | `ms-vscode-remote.remote-containers` | All |
| [WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) | `ms-vscode-remote.remote-wsl` | Windows |

### 3. Clone This Repository

**Windows Only:** Use the hotkey `Ctrl+Shift+P` and type in `WSL: Connect to WSL`. This will reopen your VS Code inside of Linux.

Open a new terminal by selecting the "Terminal" dropdown at the top of the screen and clicking "New Terminal". Within this terminal, navigate to a location on your computer where you wish to store your code. If you are new to using terminals, check out this [tutorial](https://www.linode.com/docs/guides/linux-navigation-commands/) on how to navigate between files.

Next we are going to download this repository onto your local machine. We do not have a dedicated git tutorial for now, so we recommend the official [git website](https://git-scm.com/) if you have never used it. The install and learn page can walk you through the initial setup, and once that is complete you can run the following command: 

```bash
git clone git@github.com:MIT-WORMS/worms-ws.git
```

### 4. Build the Dev Container

Finally, we can build and enter the dev container. Start by opening the repository you just cloned. You can do this by clicking the "File" dropdown at the top of the screen and clicking "Open Folder". 

Once you have this repository open in VS Code (and within WSL if on Windows), you just have to use `Ctrl/Cmd+Shift+P` and type in `Dev Containers: Rebuild and Reopen in Container`. This process may take awhile, it will pull the official ROS2 Docker image and pull our code on top of it.

If the full process worked, the bottom left of your VS Code should indicate you are in the dev container. Try opening another terminal and running the following command:

```bash
rviz2
```

If everything worked, you should see a GUI application open on your screen.

### 5. Developing

When actually developing code in the WORMS ecosystem, you should always be inside of the dev container. The code you will be working on is located inside of the `src` folder. Each repository within here is another git repository of packaged code. 

You should create individual branches in each of these repositories and commit your changes there, _you should not have to push anything to this repository itself._ There is a tutorial in the WORMS wiki that covers some basic coding practices.