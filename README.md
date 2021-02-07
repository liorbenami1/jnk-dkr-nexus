# Jenkins-Docker-Nexus
  A tutorial for building a docker image in jenkins and push to nexus artifactory
   
   * note: this tutorial needs a jenkins build agent with docker installed, as the jenkinsfile targeting this type of agent. 
     * edit the jenkinsfile agent label to 'any' if you have docker installed on your only agent. 
  
  1. Fork this repo.
  2. Run the following command to have a running nexus container with extra ports (you only needs the 8081 [UI] and 8082,8083 [docker repo / https]).
    
    docker run -d -p 8081:8081 -p 8082:8082 -p 8083:8083 -p 8084:8084 --name nexus sonatype/nexus3
    
  3. Configure nexus and add a 'docker (hosted)' repo. (see guide below)
    
    https://blog.sonatype.com/using-nexus-3-as-your-repository-part-3-docker-images
    
  4. Create credentials in jenkins to hold a secure 'user:password' for your nexus.
  5. Create a declarative pipeline in jenkins and point to the forked repo with the jenkinsfile within it.
  
    https://help.sonatype.com/repomanager3/formats/docker-registry/pushing-images
  
  6. Edit the jenkinsfile to match your repos and credentialsID in lines 12, 32, 67, 69, 72.
  7. Commit & push the changes to your forked repo.
  8. Run the job and anter it:
  
     * It will wait and ask you to enter a tag for the docker build.
     * At the end will ask to continue with upload to the nexus artifactory.
     
  9. You can browse your nexus to see the blob data and docker image uploaded to the registry.
