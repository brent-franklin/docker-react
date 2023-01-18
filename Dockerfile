# Base image for build phase
FROM node:alpine as builder

# Working Directory
WORKDIR '/usr/app'

# Copy package.json before running npm install
COPY package.json .
RUN npm install

# Copy remaining files to working directory
COPY . .

# Run the build command
RUN npm run build


# Base image for second phase of production build and server
FROM nginx

# Copy over files from build phase to nginx folder
COPY --from=builder /usr/app/build /usr/share/nginx/html


