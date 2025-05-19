# Use LinuxServer FreeCAD base image
FROM lscr.io/linuxserver/freecad:latest

# Set working directory
WORKDIR /root

# Install dependencies for VS Code Server (if needed)
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    # clean up
    && rm -rf /var/lib/apt/lists/*

# Download and install VS Code Server (latest stable version)
RUN curl -fsSL https://update.code.visualstudio.com/latest/server-linux-x64/stable -o vscode-server.tar.gz \
    && mkdir -p /root/.vscode-server/bin \
    && tar -xzf vscode-server.tar.gz -C /root/.vscode-server/bin --strip-components 1 \
    && rm vscode-server.tar.gz

# Expose SSH port for VSCode remote connection
EXPOSE 2222

# Install and configure OpenSSH server
RUN apt-get update && apt-get install -y openssh-server \
    && mkdir /var/run/sshd

# Set root password (you can override this via env or docker exec)
RUN echo 'root:freecad' | chpasswd

# Permit root login via SSH (for VSCode remote)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Avoid PAM errors on login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# Start sshd when container starts and keep container alive
CMD ["/usr/sbin/sshd", "-D"]
