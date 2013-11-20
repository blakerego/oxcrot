module PostHelper
  def extract_first_image_from_post(post)
    return post['featured_image'] if post['featured_image'].present?
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

  def post_url(post)
    return "/#{post['slug']}"
  end

end
