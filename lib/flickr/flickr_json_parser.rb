module FlickrJsonParser

  def parse(raw_response)
    if raw_response.starts_with? "jsonFlickrFeed(" and raw_response.ends_with? ")"
      JSON.parse(clean_input_string(raw_response))
    else
      JSON.parse(raw_response)
    end
  end

  def clean_input_string(raw_response)
    raw_response[15..-2]
  end
end