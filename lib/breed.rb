require "pry"

class Breed < ActiveRecord::Base
    has_many :personalities
    has_many :temperaments, through: :personalities

    validates :name, uniqueness: true

    def self.see_all_breeds
        self.all.map{|b| b.name}
    end
    
    def see_all_breeds
        self.map{|d| d.name}
    end

    def self.find_breed(breed_name)
        self.all.find_by(name: breed_name)
    end 

    def self.see_temperaments(breed_name)
        
        breeds = self.find_breed(breed_name)
        breeds.temperaments.map { |temperaments| temperaments.name}
    end 

    def self.ordered_array_based_on_votes(breed_name)
        x = Breed.find_by(name: breed_name)
        y = Breed.see_temperaments(breed_name)
        z = y.map { |names| Temperament.find_by(name: names)}
        a = z.map {|t| t.id}
        b = a.map { |ids| Personality.find_by(breed_id: x.id, temperament_id: ids)}
        wow = b.sort_by{|n| n.votes}.reverse
        sorted = wow.map{|p| p.temperament}
        sorted_temps_based_on_votes = sorted.map{|temps| temps.name}
    end 


 ##SIZE METHODS 
    def self.small_dogs(breeds)
        breed_objects = breeds.map { |breed_names| Breed.find_by(name: breed_names)}
        breed_objects.select{|breed| breed.weight < 21}

    end

    def self.medium_dogs(breeds)
        breed_objects = breeds.map { |breed_names| Breed.find_by(name: breed_names)}
        breed_objects.select{|breed| breed.weight >= 21 && breed.weight < 46}
    end

    def self.large_dogs(breeds)
        breed_objects = breeds.map { |breed_names| Breed.find_by(name: breed_names)}
        breed_objects.select{|breed| breed.weight >= 46 && breed.weight < 81}
    end

    def self.extra_large_dogs(breeds)
        breed_objects = breeds.map { |breed_names| Breed.find_by(name: breed_names)}
        breed_objects.select{|breed| breed.weight > 81}
    end

end 