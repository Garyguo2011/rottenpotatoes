class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.all_ratings
  	return ['G','PG','PG-13','R']
  end

  def self.init_ratings
  	return {'G'=>'1', 'PG'=>'1', 'PG-13'=>'1', 'R'=>'1'}
  end

end
