class Song < ApplicationRecord
    validates :title, presence: true
    validate :artist_year_title_repeat
    validates :released, inclusion: {in: [true, false]}
    # validates :release_year, presence: true, if: Proc.new{|s| s.released == true}
    with_options if: :released? do |record|
        record.validates :release_year, presence: true
        record.validates :release_year, numericality: {
            less_than_or_equal_to: Date.today.year
          }
    end
   


    def artist_year_title_repeat
        if Song.find_by(title: title, artist_name: artist_name, release_year: release_year)
            errors.add(:title, "can't be repeated by one artist in the same year")
        end
    end

    def released?
        released
    end

end
