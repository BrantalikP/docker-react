FROM node:alpine
WORKDIR '/app'

# First copy and run npm install in order to npm install is not run over and over again with every change in files,
# but only if package.json file is changed
COPY package.json .

RUN npm install
COPY . .

# Create build file in app/build
RUN npm run build

FROM nginx
# we need to tell AWS which port to use
EXPOSE 80
# Using build files from prev task
COPY --from=0 /app/build /usr/share/nginx/html
# Automaticly start on port 80
