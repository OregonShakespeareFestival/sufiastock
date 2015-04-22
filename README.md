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

    rails s
