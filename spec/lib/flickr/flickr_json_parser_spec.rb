require 'spec_helper'
require  "#{Rails.root}/lib/flickr/flickr_json_parser"

describe FlickrJsonParser do 
  include FlickrJsonParser

  before(:each) do 
    @json_content = "{\n\t\t\"title\": \"Uploads from bjr2101, tagged thailand\",\n\t\t\"link\": \"http://www.flickr.com/photos/23824747@N07/tags/thailand/\",\n\t\t\"description\": \"\",\n\t\t\"modified\": \"1970-01-01T00:00:00Z\",\n\t\t\"generator\": \"http://www.flickr.com/\",\n\t\t\"items\": [\n        ]\n}"
    @raw_response = "jsonFlickrFeed(#{@json_content})"
    @parsed_response = "{\n\t\t\"title\": \"Uploads from bjr2101, tagged thailand\",\n\t\t\"link\": \"http://www.flickr.com/photos/23824747@N07/tags/thailand/\",\n\t\t\"description\": \"\",\n\t\t\"modified\": \"1970-01-01T00:00:00Z\",\n\t\t\"generator\": \"http://www.flickr.com/\",\n\t\t\"items\": [\n        ]\n}"
  end

  describe 'parse' do
    it 'properly parses a valid input' do 
      parse(@raw_response).should == { "title"=>"Uploads from bjr2101, tagged thailand",
                "link"=>"http://www.flickr.com/photos/23824747@N07/tags/thailand/",
                "description"=>"",
                "modified"=>"1970-01-01T00:00:00Z",
                "generator"=>"http://www.flickr.com/",
                "items"=>[]}
    end

    it "cleans string when raw_response starts with 'jsonFlickrFeed('" do 
      self.should_receive(:clean_input_string).and_call_original
      parse(@raw_response)
    end

    context "When json doesn't start with jsonFlickrFeed, " do 
      it 'does not clean response unnecessarily' do
        FlickrJsonParser.should_not_receive(:clean_input_string)
        parse(@json_content)
      end

      it 'properly parses the input' do 
        parse(@json_content).should == { "title"=>"Uploads from bjr2101, tagged thailand",
                  "link"=>"http://www.flickr.com/photos/23824747@N07/tags/thailand/",
                  "description"=>"",
                  "modified"=>"1970-01-01T00:00:00Z",
                  "generator"=>"http://www.flickr.com/",
                  "items"=>[]} 
      end
    end
  end

  context 'clean_input_string' do
    it 'remove the json_flickr_feed() surrounding text' do
      clean_input_string(@raw_response).should == @parsed_response
    end
  end


end