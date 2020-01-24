class AddVoteColumnToPersonalities < ActiveRecord::Migration[5.0]
    def change 
        add_column :personalities, :votes, :integer, :default => 0
    end 
end  