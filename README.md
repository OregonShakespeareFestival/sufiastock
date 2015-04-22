# sufiastock

##Requirements 

1. Java 1.7 or greater
2. Redis running in default config on CentOS
3. rails of course
4. ffmpeg
5. imagemagick
6. fits ( in your path via bash profile )



##Spinning up the project

    resque-pool --daemon --environment development start
    rake jetty:clean
    rake jetty:start
    rake db:migrate
    rake db:seed


> This will create an admin user admin@archive.local with password ` archive2015 `

#Promote that user to admin
    rails s

##From rails console


    r = Role.create name: "admin"
    r.users << User.find_by_user_key( "admin@archive.local" )
    r.save


##Docker Image

If you are using the docker image nginx is setup to respond to hostname sufia.*
