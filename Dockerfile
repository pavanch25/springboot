# Stage 1: Compile and Build angular codebase

# Use official node image as the base image
FROM registry.access.redhat.com/ubi8/nodejs-16:latest as build

# Set the working directory
WORKDIR /usr/local/app

# Add the source code to app
COPY ./ /usr/local/app/

# Install all the dependencies
RUN npm install

# Generate the build of the application
RUN npm run build


# Stage 2: Serve app with nginx server

# Use official nginx image as the base image
FROM ubi8/nginx-118

# Copy the build output to replace the default nginx contents.
RUN rm -rf /usr/share/nginx/html/* && rm -rf /etc/nginx/nginx.conf
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/local/app/dist/sip-web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

