# Cloudreve

[Reference](https://github.com/xavier-niu/cloudreve-docker#docker-compose%E6%96%B9%E5%BC%8F%E8%BF%90%E8%A1%8C)

* Set the environment variables in .env file (sample: dot.env)
* `docker-compose up -d`
* The admin and the password will show in cloudreve's log, default port: 5212
* Login the admin account, set 管理面板->离线下载, set Aria2
  * RPC server address: http://aria2:6800 (the name of the service in the docker-compsoe file)
  * RPC secret: the random string in the .env file
  * Temporary donwload folder: /downloads (match with the dir in the docker-compose file)
  * Test the connection, save if pass.
* Set the reverse proxy accordingly (not included here)
