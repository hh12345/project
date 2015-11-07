class Movie < ActiveRecord::Base
 def Movie.ratingcollection  
    ratingcollect=Array.new  
    i=0  
    Movie.select(:rating).distinct.each  do |movie|  
      ratingcollect[i]=movie.rating  
      i+=1;  
    end  
    return ratingcollect.sort  
  end  
end
