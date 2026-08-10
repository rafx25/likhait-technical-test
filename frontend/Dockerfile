FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies.
# npm bug #4828: a package-lock.json generated on a non-musl host (e.g. Windows)
# omits the musl optional dependency (@rollup/rollup-linux-x64-musl) that Vite
# needs on Alpine Linux, which makes the dev server crash at startup. Removing the
# lockfile forces npm to re-resolve the correct platform-specific binaries here.
RUN rm -f package-lock.json && npm install

# Copy the rest of the application
COPY . .

# Expose port
EXPOSE 5173

# Start the development server
CMD ["npm", "run", "dev", "--", "--host"]