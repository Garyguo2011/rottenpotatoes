# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @output_movie = Movie.create!(movie)
    # puts "#{@output_movie.title} was successfully created."
    # puts Movie.all.count
    # puts ">>>>>>"
    # Movie.order(:release_date).each do |movie_sort|
    #   puts movie_sort.title
    # end
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # flunk "Unimplemented"
  e1_position = page.body.index(e1) ? page.body.index(e1) : -1
  e2_position = page.body.index(e2) ? page.body.index(e2) : -1
  assert(e1_position < e2_position, e1.to_s + " does not see before " + e2.to_s)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.delete(' ').split(',').each do |rating|
    if !uncheck
      steps %Q{
        When I check "ratings_#{rating}"
      }
    else
      steps %Q{
        When I uncheck "ratings_#{rating}"
      }
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all('table#movies tbody tr').count
  value = Movie.all.count
  assert(rows == value, rows.to_s + " does not equal " + value.to_s)
end