echo "Removing an existing build..."
rm -r ./build
echo "Ensuring we have the latest version..."
git pull
go get -u
go mod tidy
echo "Build latest....."
go build -o ./build/docker-build
echo "Building docker...."
sudo docker build -t todolist-backend .
