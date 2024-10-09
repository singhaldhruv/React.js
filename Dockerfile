# Step 1: Use an official Node.js runtime as a parent image
FROM node:18-alpine AS build

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json (if available)
COPY package.json ./
#COPY package-lock.json ./

# Step 4: Install project dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Build the React app for production
RUN npm run build

# Step 7: Use an nginx web server to serve the static files
FROM nginx:alpine

# Step 8: Copy the build output from the previous step to the nginx html directory  
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 80 to the outside world
EXPOSE 80

# Step 10: Start nginx
CMD ["nginx", "-g", "daemon off;"]
