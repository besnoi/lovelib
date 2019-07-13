##TinyCSV:
        A very useful library which makes handling with CSV's much easy. You even get to choose the
        format of your file and also how the data must be passed to the table. The documentation here is
        incomplete and somewhat outdated. I recommend you to read the comments to understand what each and
        every function does. Finally you can go to https://github.com/YoungNeer/arkanoid to see how tinyCSV
        is used in my arkanoid game which was one of my first love2d games and may be one of the best (it also used Anima a lot)


##DOCUMENTATION:
        tiniCSV is a no-nonsense library for Lua which you can use on your LOVE2D project
        without going through the 'pain' to credit the author (i.e. me). Basically it works like this:-

            csvfile=require('tiniCSV')
            
            Reading a CSV file 
            ----------------

            --if you have data (or want it to be) stored in key=value format
            game_environment=csvfile:parse("env.csv")  [env.csv is stored in the same directory]
            --if you want to use the default love2d app directory then you should use csvfile:parseFile method

            --let's say env.csv looks like this
            env.csv:            
                GAME_WIDTH=1280,
                GAME_HEIGHT=720

            --if you have data (or want it to be) stored in key:value format
            player=csvfile:parse("player.csv",':') 

            --lets say player.csv looks like this
            player.csv:
                level:2,
                score:90
            
            And you want to add score + 10 and add level to 3 if score>=100
            
            player['score']=player['score']+10 
            player['level']=player['level']+(player['score']>=100 and 1 or 0);

            Note: if the keys don't have '-' or numbers you can also access them using dot operator
            For ex- player.score,etc and you can also do player:getKey('score')

            And what about comments? Well anything which doesn't fit the key=value format
            will be considered as a comment. But I recommend you to start them with a #

            Now to add a new key, there are atleast two ways of doing it:
                player['mission']="The New Island" , or
                player:add('mission',"The New Island")

            WRITING INTO CSV FILE
            ----------------------

            Now to write out the CSV file you can do this 
                csvfile:write('env.csv',game_environment)                
                csvfile:write('player.csv',player,':')

            ERROR HANDLING
            -----------------
            Most libraries (particulary Lua ones) would perform any kind of error handling and if they
            do they will do it in their own way therby leaving the developer powerless. This is not the case
            with this library and any other of Neer's libraries (You can bet on it) 

            So what if the csvfile is deleted or maybe no data was retrieved?? Maybe the user, the system or you yourself are responsible
            But that doesn't matter, our csvfile is deleted (or data is currupt) and what do we do now?

            Simple, if no data is read then that means csvfile is simply some falsy value (nil), so you check for that

            if ~csvfile then
                --do what you want to do when file doesn't exist
            else
                --the code for when everything is normal i.e. the file exists
            end

