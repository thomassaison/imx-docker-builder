docker build -t imx .
docker run -v ./build:/home/ubuntu/imx-yocto-bsp/build -d imx