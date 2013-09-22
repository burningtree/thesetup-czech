# _plugins/url_encode.rb
require 'liquid'
require 'iconv'

# Percent encoding for URI conforming to RFC 3986.
# Ref: http://tools.ietf.org/html/rfc3986#page-12
module IconvEncoding
  def to_ascii(string)
    return Iconv.new('ascii//translit','utf-8').iconv(string).gsub(/[^\d\w\-]+/, '');
  end
end

Liquid::Template.register_filter(IconvEncoding)
