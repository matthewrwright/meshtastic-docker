# Start with a lightweight Linux base image
FROM debian:bullseye-slim

# Set a working directory
WORKDIR /app

# Install dependencies for running AppImages
RUN apt-get update && apt-get install -y \
    libfuse2 \
    wget \
    --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the AppImage into the container
# Replace "your-app.AppImage" with the actual name of your AppImage file
RUN wget https://affirmatech.com/download/meshsense/meshsense-x86_64.AppImage

# Ensure the AppImage has execution permissions
RUN chmod +x /app/meshsense-x86_64.AppImage

# Expose a port if the AppImage provides a web interface
# Replace 8080 with the appropriate port if needed
EXPOSE 5921
EXPOSE 5920

# Define the command to run the AppImage
CMD ["HEADLESS=1 ACCESS_KEY=mySecretKey /app/meshsense-x86_64.AppImage"]
