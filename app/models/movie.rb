class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date, :director

  def self.all_ratings
  	# return ['G','PG','PG-13','R']
  	rating_dict = {}
  	self.select(:rating).uniq.each do |movie|
  		rating_dict[movie.rating] = 1
  	end
  	return rating_dict
  end

end
