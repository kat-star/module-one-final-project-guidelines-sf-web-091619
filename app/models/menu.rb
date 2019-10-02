def pause                                                                                                        
    print "press any key to continue"                                                                                                    
    STDIN.getch                                                                                                              
    print "            \r" # extra space to overwrite in case next sentence is short                                                                                                              
end    


def skill_menu(name, age)                       ########## BEGIN SKILL MENU - NEW USER SIGNUP ###########
    skill = nil
    system("clear")
    puts " "
    puts "Thank you #{name}, it's good to know you're #{age}."
    puts "On a scale of 1 to 5, five being the best, how good are you?"
    puts " "
    print ": "

    skill = STDIN.getch
    skill = skill.to_i
    
    if skill.between?(1,5)
        puts "YESSS!"
        return skill
    else
        puts "Your choise in invalid.  Please try again."
        pause
        skill_menu(name, age)
    end
end                                         ############  END SKILL MENU - NEW USER SIGNUP ##########

def location_menu(name, age, skill)             ###### BEGIN LOCATION MENU - NEW USER SIGNUP ##############
    system("clear")
    puts " "
    puts "WOW #{name}, you're #{age} years old and a #{skill}?  That's great!"
    puts "Last but not least, please select your location from the list below."
    puts "1 - Bay Area      2 - Yosemite        3 - SoCal"
    puts "      4 - New York    5 - International"
    print ": "
    location = STDIN.getch
    
    if location == "1"
        return "Bay Area"
    elsif location == "2"
        return "Yosemite"
    elsif location == "3"
        return "SoCal"
    elsif location == "4"
        return "New York"
    elsif location == "5"
        return "International"
    else
        puts " "
        puts "I'm sorry but that was not a valid entry.  Please try again."
        pause
        location_menu(name, age, skill)
    end
end                                                     ###########  END LOCATION - NEW USER SIGNUP ##########

def confirmation_menu(name, age, skill, location)       ######## BEGIN CONFIRMATION - NEW USER SIGNUP ######
    system("clear")
    puts " "
    puts "Fantastic!!!"
    puts " "
    puts "Just to be clear, let's make sure this is correct."
    puts "Youre name is #{name}, you're #{age} years old."
    puts "You'd consider your skill level a #{skill}, &"
    puts "you're located in (or near) #{location}."
    print "Correct? (Y/N): "
    answer = STDIN.getch
    puts " "
    if answer == "y"
        puts "Wonderful!  We can continue!"
        return answer
    elsif answer == "n"
        puts "That's alright, we can start over!"
        pause
        signup_menu
    else 
        puts "You answer wan't 'y' or 'n', please try again."
        pause
        confirmation_menu(name, age, skill, location)
    end
end                                                     ############  END CONFIRMATION - NEWUSER ###########

def signup_menu                                                #######  BEGIN NEWUSER SIGNUP###########
    system("clear")
    puts " "
    puts "Welcome to the System.  Please enter your name!"
    puts " "
    print ": "
    name = gets.chomp
    
    system("clear")
    puts " "
    puts "Hello #{name}!  Please tell us your age."
    puts " "
    print ": "
    age = gets.chomp

    skill_level = skill_menu(name, age)
    location = location_menu(name, age, skill_level)
    confirmation = confirmation_menu(name, age, skill_level, location)

    if confirmation
        new_user = Climber.create(name: name, age: age, location: location,  skill_level: skill_level)
        puts "Welcome #{new_user.name}!  We're glad to have you!"
        pause
        user_menu(new_user)
    else
        puts "Something is terribly wrong, human."
        pause
    end
end                                                             ############  END NEW USER SIGNUP ############

def user_menu(user)                                           #####  BEGIN MAIN MENU ########
    system("clear")
    puts "Welcome #{user.name}!"
    puts "1 - See your climbs           2 - Delete a climb"
    puts "3 - Find climb by name        4 - Find climb by area"
    puts "5 - List available routes     6 - List climbers who've climbed route"
    puts "7 - List top climbers         8 - List routes by rating"
    puts "X - Exit"
    puts " "
    print "Menu: "
    choise = STDIN.getch.to_s
    puts " "
    if choise == "1"
        puts "HERE ARE YOUR CLIMBS"
        pause
        user_menu(user)
    elsif choise == "2"
        puts "DON'T FORGET THE PAST, HUMAN!"
        pause
        user_menu(user)
    elsif choise == "3"
        puts "THESE ARE CLIMBS LISTED BY NAME"
        pause
        user_menu(user)
    elsif choise == "4"
        puts "THESE ARE CLIMBS LISTED BY AREA"
        pause
        user_menu(user)
    elsif choise == "5"
        puts "THESE ARE ALL AVAILABLE ROUTES"
        pause
        user_menu(user)
    elsif choise == "6"
        puts "THESE ARE ALL THE CLIMBERS FOR A ROUTE"
        pause
        user_menu(user)
    elsif choise == "7"
        puts "THESE ARE THE TOP CLIMBERS"
        pause
        user_menu(user)
    elsif choise == "8"
        puts "THESE ARE THE CLIMBS BY RATING"
        pause
        user_menu(user)
    elsif choise == "x" || choise == "X"
        puts "Goodbye #{user.name}!"
        return
    else
        puts "YOU TYPED SOMEHTING I DON'T UNDERSTAND, HUMAN!!!"
        pause
        user_menu(user)
    end
end                                                         ##########  END MAIN MENU #############

def main_menu                                               ########## BEGIN STARTUP LOGIN ###########
    system("clear")
    puts " " * 30
    puts "Welcome to the Main Menu!"
    puts " " * 36
    puts "Please enter your name, 'new' to sign up, or 'exit' to leave."
    print "BEGIN: "
    
    input = gets.chomp
                                                                 # possible solution = "Casimira Schmeler MD"
    
    if Climber.helper.include?(input) 
        user = Climber.find { |info| info.name == input }
        user_menu(user)
    elsif input == "new"
        signup_menu

    elsif input == "exit" 
        puts "YOU'RE GOING TO WISH YOU STAYED!"
        pause 
        return
    else
        puts "That was not a valid menu selection"
        pause
        main_menu
    end
end                                                  ##########  END STARTUP LOGIN ##############