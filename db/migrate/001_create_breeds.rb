##TEST TEST TEST TEST 

class CreateBreeds < ActiveRecord::Migration[5.1]

    def change
        create_table :breeds do |t|
            t.string :name
            t.integer :weight
            t.integer :lifespan
        end 
    end 
end 