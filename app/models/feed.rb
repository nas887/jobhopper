module Feed

  def sort_by_radius(jobs_array, user_loc)
    if user_loc != ''
      coordinates = get_coordinates(user_loc)
      sorted_by_distance = {}
      i = 0
      jobs_array.each do |job|
        if job.has_coordinates
          job_coordinates = [job.lat.to_f, job.lng.to_f]
          distance = haversine(coordinates, job_coordinates)
          sorted_by_distance[distance] = job
        else
          #TODO HACK FIX THIS SHIT
          sorted_by_distance[100000000 + i] = job
          i += 1
        end
      end
      # TODO shitty fucking code. please fix this shit.
      sorted_keys = sorted_by_distance.keys.sort
      sorted_jobs = {}
      sorted_keys.each {|key| sorted_jobs[key] = sorted_by_distance[key] }
      sorted_jobs
    else
      jobs_array
    end
  end

  def get_coordinates(location)
    location_tags = Tag.where('tag_type = ?', 'LocationTag')
    results = []
    location_tags.each do |tag|
      unless (location.downcase.scan(tag.name)).empty?
        results << tag
      end
    end
    begin
      # TODO if the user already has a lat and lon don't do this
      city = Geokit::Geocoders::GoogleGeocoder3.geocode(results.first.name)
      # TODO save the user's lat and lon in the database
      [city.lat.to_f, city.lng.to_f]
    rescue Exception => e
      puts e.message
    end
  end

  def haversine(user_coordinates, job_coordinates)
   lat1, lon1 = user_coordinates
   lat2, lon2 = job_coordinates
   dLat = to_rad(lat2-lat1)
   dLon = to_rad(lon2-lon1)
   a = Math.sin(dLat/2) * Math.sin(dLat/2) +
   Math.cos(to_rad(lat1)) * Math.cos(to_rad(lat2)) * Math.sin(dLon/2) * Math.sin(dLon/2);
   c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
   (6371 * c) * 0.62137 # convert km to mi
  end

  private 

  def to_rad(coordinate)
    coordinate.to_f * Math::PI / 180
  end

end
