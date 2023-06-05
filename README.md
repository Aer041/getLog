# getLog

On local
```
./download_log_auto serial:///dev/ttyACM0
```

Push docker
```
docker buildx build . --platform=linux/amd64,linux/arm64,linux/arm/v7 -t aero41/aeros-getlog:latest --push
```

Run docker
```
docker run --mount type=bind,source=$HOME/drone,target=/root/drone --device /dev/ttyACM0:/dev/ttyACM0 -ti aero41/aeros-getlog:latest serial:///dev/ttyACM0
```
