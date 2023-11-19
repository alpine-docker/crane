# crane

https://github.com/google/go-containerregistry/tree/main/cmd/crane

### usage #1

```
$ docker run --rm alpine/crane ls ubuntu
10.04
12.04.5
12.04
12.10
```
### usage #2
copy the image, for example, nginx,  with its multi-arch as well
```
docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane auth login -u <your_docker_id> -p <your_docker_api> index.docker.io

docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane copy nginx <your_docker_id>/nginx

# for example

docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane auth login -u ozbillwang -p dckr_pat_vynZPg8C5KsqItk-xxxxxxxxxx index.docker.io

# check the auth config file
more .docker/config.json

{
        "auths": {
                "https://index.docker.io/v1/": {
                        "auth": "b3piaWxsd2FuZzpkYxxxx"
                }
        }
}

docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane copy nginx ozbillwang/nginx
```

After done, you should see the image in your account and the image has its all OS and Arch, all DIGEST are same

![image](https://github.com/alpine-docker/crane/assets/8954908/886021e7-e723-4ccf-afe1-c77e874c5cc0)

### usage #3
create a tag for image, with its multi-arch as well
```
docker run -ti --rm -v $(pwd)/.docker:/root/.docker alpine/crane tag  ozbillwang/nginx abc
```
![image](https://github.com/alpine-docker/crane/assets/8954908/8ea0046b-89c5-4488-b9d3-5ded4a751b98)
