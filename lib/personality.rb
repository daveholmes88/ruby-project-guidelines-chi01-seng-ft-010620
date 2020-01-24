class Personality < ActiveRecord::Base
    belongs_to :breed
    belongs_to :temperament
    validates :id, uniqueness: true

        
        def self.new_personality(breed_name, temperament_name)
            breed = Breed.find_by(name: breed_name)
            temperament = Temperament.find_by(name: temperament_name)
            self.find_or_create_by(breed_id: breed.id, temperament_id: temperament.id)
        end

        def self.find_a_personality(breed_name, temperament_name)
            breed = Breed.find_by(name: breed_name)
            temperament = Temperament.find_by(name: temperament_name)
            Personality.all.find_by(breed_id: breed.id, temperament_id: temperament.id)
        end


        def self.vote_for_personality(breed_name, temperament_name)

            personality = self.find_a_personality(breed_name, temperament_name)
            personality.votes += 1
            personality.save 
        end 

        def self.delete_personality(breed_name, temperament_name)
            personality = Personality.find_a_personality(breed_name, temperament_name)
            personality.destroy
        end

       
end 

