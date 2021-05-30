## launch instances

ami->amazon linux 2
t2->micro(single cpu)

no of instances 1
network -default
subnet default -subnet-d8cc9594
no need any changes

add storage by default no changes

add tags
value-batchcode INTCDE008-samrat-ec2

select existing security group
security group name-INTCDE008-admin-sg

then click launch

create a key value pair
INTCDE008-key
download key pair

copy public ip address in instance summary
3.22.100.156
------------------------------------------------------ 
## Go to puttygen

convert pem to ppk 
load the key which is downloaded from aws
click generate
save public key and give some name
save private key and give some name

open putty
paste the ip address from aws
go to ssh and extend then auth->privatekey->browse->open that key

console will open
give ec2-user

sudo yum update -y
yum install java-devel

for java 15
-import https://yum.corretto.aws/corretto.key 
 sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo

After the repository is added, you can install Corretto 15 by running this command:

sudo yum install -y java-15-amazon-corretto-devel

----------------------------------------------------------------
clean and build the project
s3->create bucket->bucketname->INTCDE008-files(use this)
intcde008-samrat-files
allow the publlic access
then create bucket

permission
acl ->everyone read list
click all after acl

upload->addfiles->choose jar files of project and upload

click on the project and object action->make public
now click the url of project it will download 
just copy the object url
https://intcde008-samrat-files.s3.us-east-2.amazonaws.com/truyum-0.0.1-SNAPSHOT.jar
go to putty 
wget "" and paste the url
and just enter
ls ->you will see the jar

java -jar nameoftheproject.jar

now go to ec2 instance and find ip address of your instance

change https->http and :port/trainee



------------------------------------------
Plesae find the steps-
from RAMANUJ DAS to All Participants:
1. Launch a new ec2 instance
2. save the key to your local machine
3. install putty
4. generate ppk from pem and save it
5. run putty and mention the public ip address of ec2
6. add ssh->auth->browse->add the saved ppk file
7. open
8. yum install java-devel
------------------------------------------------

Transferring files from Local Machine to EC2:
1) Create s3 bucket and add the files to be coppied
2) Allow public access to the files
3) Copy the object URL of the fils in S3
4) RUN wget "paste-url"

--------------------------------------------------
for java 15
-import https://yum.corretto.aws/corretto.key 
 sudo curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo

After the repository is added, you can install Corretto 15 by running this command:

sudo yum install -y java-15-amazon-corretto-devel

-----------------------------------------------
elastic bean rds
create environment ->webserver->choose platform->java
configure more option->database
username ,password and dont create snapshot(choose delete)
create environment
change localhost to ${RDS_HOSTNAME:localhost}:${RDS_PORT:3306}/${RDS_DB_NAME:CTS_DB}
password=${RDS_PASSWORD:password}
username=${RDS_USERNAME:root}

then upload it to the environment

-------------------------------------------------
rds
create database
standard
->mysql
->freetier
->and db name
username -admin
password-password
initial database name(additional config)
cts_db
all others are default

copy the end point from communuty and security

then go to application environment config
click edit and add new variable in env properties
RDS_HOSTNAME paste that link
RDS_PORT 3306
RDS_USERNAME admin
RDS_PASSWORD password
RDS_DB_NAME cts_db
and apply

find security group of this environment/go to ec2 instances
and click instance id and check security group and copy security group id
and now go to rds db and go to security group and edit the inbound rules 
paste the security group near custom and save
----------------------------------------------------------------
search for code commit 
create repository and name it
then click create
go to iam and open it in new tab
click users and search by userid
create security credentials and click git generate credentials
and download it 
copy the clone commands
in your system folder
copy the username and password from the downloaded file 
and paste it in the git terminal
copy src and pom file from project 
paste it in the folder which is specified for repo
create buildspec.yml in same folder.
search for buildspec.yml aws in google
change the artifact name in that buildpec file
add->commit->push
push this files in folder to aws code commit
and verify the code commit all files are pushed 
now go to elasticbean stack
create new environment
search for cicd/code pipeline
create a pipeline with name
create new service role/use the existing role
source provider choose code commit
build provider aws code build
project name->same name
os amazon linux 
image standard1.0
always use the latest runtime
vpc default ,subnets any /no need to change
def security gropups
add all subnets 
then deploy  stage.
elastic bean stack as deploy provider
app name and env name
then check all code pipe
go to iam and roles and search for created role .attach policy
and search for elastic bean awscodedeploy full access,admistractor elastic bean
and add
go to pipeline and click create pipeline.
check build status 

----------------------------------------------------------------
Docker
1. sudo yum update -y
2. sudo yum install docker -y
3. sudo service docker start
4. Add ec2-user to the docker group 
sudo usermod -a -G docker ec2-user
sudo chmod 666 /var/run/docker.sock
5. docker  -v
docker run -p 80:80 --name=covid-info ram1uj/covid-info

------------------------
create docker file for existing project
FROM adoptopenjdk/openjdk15
WORKDIR /
ADD truyum-0.0.1-SNAPSHOT.jar truyum-0.0.1-SNAPSHOT.jar
EXPOSE 5000
CMD java -jar truyum-0.0.1-SNAPSHOT.jar

escape and :wq!
docker build -t menu-item .
docker run -p 80:5000 --name=menu-items  menu-items
--------------------------------------------------------------
to run aws on terminal
C:\Users\C_M_Kali_Muthu\Downloads>ssh -i INTCDE008-901393.pem ec2-user@ec2-18-116-199-10.us-east-2.compute.amazonaws.com
sudo service docker start
docker pull mysql
docker run -d -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=cts_db -e MYSQL_USER=docker -e MYSQL_PASSWORD=password -p 3306:3306 --name mysql-server mysql

in mysql workbench
host name-ip public address from amazon
username-docker
password=password
volume
docker stop mysql-server
docker rm mysql-server
docker run -d -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=cts_db -e MYSQL_USER=docker -e MYSQL_PASSWORD=password -p 3306:3306 --name mysql-server --name mysql-server --volume mysql-db-volume:/var/lib/mysql mysql
change the application properties on that project file
create repo and install git in ec2 and pull that repo
and upload the jar from system to repo and pull that from repo to aws ec2
along with jar file create dockerfile and modify the app name in it
git pull on ec2
java -jar that jar file(to check whether its working )
ctrl+c to stop
dokcer build -t springboot-docker .
docker images
docker run -p 5000:5000 --name=springboot-docker spring-boot-docker
it will return error so we need to make conection b/w network
//linked based connection
//docker container run -p 5000:5000 -e RDS_HOSTNAME=mysql-server -e RDS_PORT=3306 --link=mysql-server --name spring-boot-docker spring-boot-docker
docker network
docker network create docker-mysql-network
docker stop mysql-server
docker rm mysql-server
docker run -d -e MYSQL_ROOT_PASSWORD=password -e MYSQL_DATABASE=cts_db -e MYSQL_USER=docker -e MYSQL_PASSWORD=password -p 3306:3306 --name mysql-server --name mysql-server --volume mysql-db-volume:/var/lib/mysql --network=docker-mysql-network mysql
docker rm spring-boot-docker
docker container run -p 5000:5000 -e RDS_HOSTNAME=mysql-server -e RDS_PORT=3306 --name spring-boot-docker --network=docker-mysql-network springboot-docker
----------------------------------------------------------------
micro-services in docker
change default zone of eureka server.
go to coupons properties
add
eureka.client.service-url.defaultZone=http://${EUREKA_HOST:localhost}:8761/eureka/
copy it and write it on order and product sevice,gateway.
build and create jar files for all service
create new folder for each service  in existing docker folder and paste the jar of ecah
create docfile for all service
change expose for each
pd-5100
order-5000
eureka-8761
copons-5200
api-gateway-8888
then push it and pull it on ec2
then build all services
cd .. to go up one dir
create docker network asmicroservice-network
run every container with ports allocated along with network
sudo docker container run -p 8761:8761 -d --name eureka-server --network=microservices-network eureka-service
sudo docker container run -p 5100:5100  -d -e EUREKA_HOST=eureka-server --name product-service --network=microservices-network product-service

sudo docker container run -p 5200:5200 -d -e EUREKA_HOST=eureka-server --name coupon-service --network=microservices-network coupon-service

sudo docker container run -p 5000:5000 -d -e EUREKA_HOST=eureka-server --name order-service --network=microservices-network order-service

sudo docker container run -p 8888:8888 -d -e EUREKA_HOST=eureka-server --name api-gateway --network=microservices-network api-gateway


1st eureka server
pass -e EUREKA_HOST=eureka-server then network
add -d before -e (detach mode)
docker logs containerid->for logs
---------------------------------------------------------------
another way to deploy micro services
sudo reboot to reboot the instance
sudo service docker start
go to docker acc and create one
docker login 
username: lionelsamrat10
password: ________ 
to connect with docker hub
to tag
docker tag order-service username/order-service:0.1
to push
docker push docker username/order-service:0.1
docker compose for better to start or stop all services at a time
we need docker-compose.yml file
copy from git 
open it in vs code
you can write depends_on:-eureka-server(to start eureka first) in all services except eureka
give eureka-host as environment for all services
push that file to git
pull from the git into ec2
then install docker-compose
sudo yum install docker-compose get from google
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
then check version
vim docker-compose.yml
then paste
then docker-compose config
then docker-compose up
ctrl+c to stop
then docker-compose down
we can also scale up the instance.by command in compose.ybl 
by adding ports with range 5100-5199:5100 (99-range)
docker-compose up --scale product-service=2 --scale coupon-service=3
--------------------------------------------------------------
docker run -p 8080:8080 -d -e EUREKA_HOST=eureka-server-0.1 --network=truyum-network --name=truyum spring-rest-api-0.1
docker run -p 8083:8083 -e EUREKA_HOST=eureka-server-final --name=gateway  --network=truyum-network truyum-zuul-gateway-final
docker run -p 8761:8761 -d  --network=truyum-network --name=eureka-server-final eureka-server-final
----------------------------------------------------------------
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
6..give ls and go to the project dir(cd dirname). then check whether the jar and dockerfile is available.
	6.1 you can check whether your jar file work fine by (java -jar filename.jar)
	6.2 works fine then .click ctrl+c to stop the jar execution. 

7. then build the docker file by docker buil -t nameofapp
8.it will create the image.to check give docker images.it will return the created images.
9.do the same steps of 6 and 7 to create image for all services you have.
10.now check whether all the images are created by (docker images).
11.now install docker-compose.follow these steps.
	1.sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	2.sudo chmod +x /usr/local/bin/docker-compose
	3.sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

12.change the directory to project dir (cd ..).
13.now have to configure the docker-compose.yml file change the images and ports name by refering your images in the yml file.
14.now check wheather all working fine by (docker-compose config).if it shows the contents of that file then its working fine..else some error in conf of yml file.(check the names).
15.now you can up all the containers by(docker-compose up).all apps are started to run.
16.check with the url whether all services are working fine by like this http://ec2-13-59-255-88.us-east-2.compute.amazonaws.com:8761/(for eureka).or you can also give 
ip address with http and colon and port number then your service.
17.youcan stop the application exec by (ctrl+c).
18.now check all containers are still running by (docker ps -a).
19.now stop the compose by (docker-compose down).
20.youcan also scale the insances by (docker-compose up --scale appname=2).
#important commands
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
