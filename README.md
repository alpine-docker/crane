# crane

https://github.com/google/go-containerregistry/tree/main/cmd/crane

### usage

```
$ docker run --rm alpine/crane ls ubuntu
10.04
12.04.5
12.04
12.10
```

copy the image, for example, nginx,  with its multi-arch as well
```
docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane auth login -u <your_docker_id> -p <your_docker_api> index.docker.io

docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane copy nginx <your_docker_id>/nginx

# for example

docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane auth login -u ozbillwang -p dckr_pat_vynZPg8C5KsqItk-xxxxxxxxxx index.docker.io
docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane copy nginx ozbillwang/nginx
```

After done, you should see the image in your account and the image has its all OS and Arch
