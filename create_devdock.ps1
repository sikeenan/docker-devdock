# CC Laptop Limitations due to the way GIS Build is implemented.
# - Cannot User Port 80 
# - Cannot mount local disk as storage on the container.
docker volume create shared-vol
docker volume create devdock-development-vol
docker run -h devdock --name devdock -v devdock-development-vol:/development -v shared-vol:/shared -p 127.0.0.1:5000:5000  -d devdock:custom