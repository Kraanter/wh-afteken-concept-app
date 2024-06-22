# Use node 20.13.1 base image
FROM node:20.13.1

# Set working directory inside the container
WORKDIR /app

# Copy the entire workspace (including aftekenen and its contents)
COPY . .

# Install dependencies for the root workspace
RUN yarn install --frozen-lockfile

# Install dependencies for aftekenen workspace
RUN yarn workspace aftekenen install --frozen-lockfile

# Run expo export command to build the web version
RUN yarn workspace aftekenen export:web

# Copy SSL certificates into the container
COPY server.cert server.key /app/

# Expose the port to connect to (HTTPS)
EXPOSE 3000

# Serve the static files using npx serve over HTTPS
CMD ["yarn", "workspace", "aftekenen", "serve:https"]
