class Temperament < ActiveRecord::Base
    has_many :personalities 
    has_many :breeds, through: :personalities

    validates :name, uniqueness: true

    def self.see_all_temperaments
        self.all.map{|t| t.name}
    end

    def self.find_temperament(temperament_name)
        Temperament.all.find_by(name: temperament_name)
    end 

    def self.see_breeds(temperament)
        breeds = self.find_by(name: temperament).breeds.map {|b| b.name}
    end

    def self.see_breed_names(temperament)
        breeds = self.find_by(name: temperament).breeds
        breeds.map{|b| b.name}
    end
    
    def self.ordered_array_of_breeds_based_on_votes(temperament_name)
        x = Temperament.find_by(name: temperament_name)
        y = Temperament.see_breeds(temperament_name)
        z = y.map { |names| Breed.find_by(name: names)}
        a = z.map {|b| b.id}
        b = a.map { |ids| Personality.find_by(breed_id: ids, temperament_id: x.id)}
        wow = b.sort_by{|n| n.votes}.reverse
        sorted = wow.map{|p| p.breed}
        sorted_breeds_based_on_votes = sorted.map{|breeds| breeds.name}
    end 

    def self.new_temperament(temperament_name)
        self.find_or_create_by(temperament_name)
    end

end 