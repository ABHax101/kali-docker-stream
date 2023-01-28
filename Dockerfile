# Use the official Kali Linux image as the base image
FROM kalilinux/kali-rolling

# Install the necessary dependencies for noVNC and Ratpoison
RUN apt-get update && apt-get install -y \
    python3-numpy \
    python3-pil.imagetk \
    tightvncserver \
    ratpoison \
    xterm \
    x11vnc \
    wget \
    unzip

# Install noVNC
RUN wget https://github.com/novnc/noVNC/archive/v1.2.0.zip && unzip v1.2.0.zip && rm v1.2.0.zip
RUN mkdir -p /usr/local/bin/noVNC
RUN cp -r noVNC-1.2.0/* /usr/local/bin/noVNC

# Copy the start.sh script and .ratpoisonrc file to the container
COPY start.sh /root/
COPY .ratpoisonrc /etc/ratpoison/

# Change .ratpoisonrc ownership to root user to avoid potential issues
RUN chown root:root /etc/ratpoison/.ratpoisonrc

# Expose port 80 for the noVNC web interface
EXPOSE 80

# Set the default command to run when the container starts
CMD ["/bin/bash", "/root/start.sh"]
