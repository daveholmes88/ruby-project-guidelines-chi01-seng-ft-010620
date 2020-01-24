require_relative '../config/environment'
require 'net/http'
require 'pp'
require "tty-prompt"
require 'pry'
prompt = TTY::Prompt.new


all_breeds = []
all_breeds << Breed.see_all_breeds
all_temperaments = Temperament.see_all_temperaments.sort

##VARIABLE INPUTS 
choices = ["Select a breed", "Select a temperament", "MORE..."]
weight_classes = ["Small --> 5 - 20 lbs", "Medium --> 21 - 45 lbs", "Large --> 46 - 80 lbs", "Extra Large --> 81+ lbs"]

##START PROMPTS

menu = prompt.select("What would you like to do?", choices)

    if menu == choices[0]
        select_a_breed = prompt.select("Which breed?", all_breeds, filter: true)
            p Breed.find_breed("#{select_a_breed}")

        hi = prompt.select("Agree?", 
            temp_choices = Breed.ordered_array_based_on_votes("#{select_a_breed}").push("NO VOTE -- I don't agree with any of these."), symbols: {marker: 'VOTE -->'})        
                if Temperament.find_by(name: "#{hi}")
                    Personality.vote_for_personality(select_a_breed, hi)
                    puts "Thanks for voting!"
                else
                    puts "Why didn't you vote? We spent 5 hours making this work."
                end

        delete_ask = prompt.yes?("Are you sure? Didn't you want to delete it instead???")
            if delete_ask == true
                Personality.delete_personality(select_a_breed, hi)
            else 
                puts "Ok, we won't delete anything."
            end
        
        puts "_________________________"

        make_a_change = prompt.yes?("Would you like to add a temperament to this breed?")
            if make_a_change == true
                select_a_temperament = prompt.select("Which temperament?", all_temperaments, filter: true)
                Personality.new_personality("#{select_a_breed}", "#{select_a_temperament}")
                puts "Thank you for adding to our database!"
            else 
                puts "Goodbye"
            end

elsif menu == choices[1]
    select_a_temperament = prompt.select("Which temperament?", all_temperaments, filter: true)
        p Temperament.find_temperament("#{select_a_temperament}")

    lo = prompt.select("Agree?", 
        breed_choices = Temperament.ordered_array_of_breeds_based_on_votes("#{select_a_temperament}").push("NO VOTE -- I don't agree with any of these."), symbols: {marker: 'VOTE -->'})
        
            if Breed.find_by(name: "#{lo}")
                Personality.vote_for_personality(lo, select_a_temperament)
                puts "Thanks for voting!"
            else
                puts "Why didn't you vote? We spent 5 1/2 hours making this work."
            end

    delete_ask = prompt.yes?("Are you sure? Didn't you want to delete it instead???")
            if delete_ask == true
                Personality.delete_personality(lo, select_a_temperament)
            else 
                puts "Ok, we won't delete anything."
            end


        puts "____________________"

        make_a_temp_change = prompt.yes?("Would you like to add a breed to this temperament?")
            if make_a_temp_change == true 
                select_a_breed = prompt.select("Which breed?", all_breeds, filter: true)
                Personality.new_personality("#{select_a_breed}", "#{select_a_temperament}")
                puts "Thank you for adding to our database!"
            else
                puts "Goodbye!"
            end
    
    elsif menu == choices[2]
        ##START MORE
        weight_menu = prompt.select("What size dog are you looking for?", weight_classes)
        temperament_menu = prompt.select("And what sort of temperament?", all_temperaments, filter: true)

            if weight_menu == weight_classes[0]
                breed_list = Temperament.see_breeds(temperament_menu)
                pp weighted_breeds = Breed.small_dogs(breed_list)

            elsif weight_menu == weight_classes[1]
                breed_list = Temperament.see_breeds(temperament_menu)
                pp weighted_breeds = Breed.medium_dogs(breed_list)

            elsif weight_menu == weight_classes[2]
                breed_list = Temperament.see_breeds(temperament_menu)
                pp weighted_breeds = Breed.large_dogs(breed_list)

            elsif weight_menu == weight_classes[3]
                breed_list = Temperament.see_breeds(temperament_menu)
                pp weighted_breeds = Breed.extra_large_dogs(breed_list)
            end

end









