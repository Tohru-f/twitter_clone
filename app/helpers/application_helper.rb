# frozen_string_literal: true

module ApplicationHelper
  def hidden_field_tag(_name, _value = nil, _options = {})
    raise 'Happiness chainではhidden_field_tagの使用を禁止しています'
  end

  def text_url_to_link(text)
    require 'uri'
    URI.extract(text, %w[http https]).uniq.each do |url|
      sub_text = "<a href=#{url} target=\'_blank\'>#{url}</a>"
      text.gsub!(url, sub_text)
    end
    text
  end
end
