after created ec2instance.steps to docker-compose your application
1.go to the instance and click connect to open terminal in web
	1.1 else you can go to the downloads in system terminal and execute  this but replace pem file name and aws public atress after ec2-user@.
	ssh -i INTCDE008-901393.pem ec2-user@ec2-18-116-199-10.us-east-2.compute.amazonaws.com

2.it will connect to your ec2.then sudo yum install (your java version-go through the git of sir's)
3.then check the version of java.then install git.(sudo yum install git).
4.then give git init.
5.then if you want to clone anyones git give (git clone url).else you can pull urs repo by(git pull origin master).it will pull the repo to ec2.
6.then ls to list the files.
7.now install docker to your ec2.folow these steps.
	1. sudo yum update -y
	2. sudo yum install docker -y
	3. sudo service docker start.
	4.sudo usermod -a -G docker ec2-user
	5.sudo chmod 666 /var/run/docker.sock
8..give ls and go to the project dir(cd dirname). then check whether the jar and dockerfile is available.
	6.1 you can check whether your jar file work fine by (java -jar filename.jar)
	6.2 works fine then .click ctrl+c to stop the jar execution. 

9. then build the docker file by docker buil -t nameofapp
10.it will create the image.to check give docker images.it will return the created images.
11.do the same steps of 6 and 7 to create image for all services you have.
12.now check whether all the images are created by (docker images).
12.now install docker-compose.follow these steps.
	1.sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	2.sudo chmod +x /usr/local/bin/docker-compose
	3.sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

14.change the directory to project dir (cd ..).
15.now have to configure the docker-compose.yml file change the images and ports name by refering your images in the yml file.
16.now check wheather all working fine by (docker-compose config).if it shows the contents of that file then its working fine..else some error in conf of yml file.(check the names).
17.now you can up all the containers by(docker-compose up).all apps are started to run.
18.check with the url whether all services are working fine by like this http://ec2-13-59-255-88.us-east-2.compute.amazonaws.com:8761/(for eureka).or you can also give 
ip address with http and colon and port number then your service.
19.youcan stop the application exec by (ctrl+c).
20.now check all containers are still running by (docker ps -a).
21.now stop the compose by (docker-compose down).
22.youcan also scale the insances by (docker-compose up --scale appname=2).

### important commands

docker ps :to display running containers
docker ps -a :to display the history of containers
ls :list the contents of dir
cd .. :to step back one dir .
cd dirname :to change dir.
docker build -t appname :to build the image from dockerfile
docker images :to display the images available.
java -jar jarfilename :to execute jar file.
docker run -p port:port --name=appname appname :to run the image.
docker stop imagename/img number :to stop image
docker stop containername/container number:to stop container
docker rm imagename/img number :to remove the image
docker rm containername/container number:to remove container.
docker run -p port:port e EUREKA_HOST=eureka-server --name=appname appname :to run the image. :e for environment variable.you can use for server.
docker run -p port:port -d --name=appname appname :to run the image. :d -denotes detach mode.
