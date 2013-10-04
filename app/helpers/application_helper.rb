module ApplicationHelper
  def extract_first_image_from_post(post)
    doc = Nokogiri::HTML( post['content'] )
    return doc.css('img').first['src']
  end
end
