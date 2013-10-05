module ApplicationHelper
  def extract_first_image_from_post(post)
    doc = Nokogiri::HTML( post['content'] )
    return doc.css('img').first['src']
  end

  def trim_excerpt(post, length=150)
    doc = Nokogiri::HTML( post['excerpt'] )
    return truncate(doc.css('p').first.text, :length => length, :omission => '... (read more)', :separator => ' ')
  end

  def post_date(post)
    raw_date = post['date']
    return DateTime.parse(raw_date).strftime("%B %d, %Y")
  end
end
