#Define what installment you need. For example, node, ubuntu
FROM node:lts-alpine

# install depedencies outside the scope of the project
RUN ...

# Generate a folder to the currect Docker directory
WORKDIR /app

# copy items if needed
COPY ...

# install project dependencies
RUN ...

# copy project files and folders to the current working directory (i.e. 'app' folder)
COPY . .

# build app for production with minification
RUN ...

# if running a webserver, define what port should be exposed
#EXPOSE 8080 
# Define the commands, this could be npm run ... or cmake 
CMD [ "...", "..." ]