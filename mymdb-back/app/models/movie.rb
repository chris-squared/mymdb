class Movie < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validate :notseen_cantbe_favorite
 

    

    def notseen_cantbe_favorite
        if !seen && favorite 
            errors.add(:favorite, "Film cannot be a favorite and not seen!")
        end
    end
end
