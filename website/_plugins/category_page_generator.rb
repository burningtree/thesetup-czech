require 'iconv'

module Jekyll

  class CategoryPage < Page

    def initialize(site, base, dir, category)

      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      safe_category = Iconv.new('ascii//translit','utf-8').iconv(category).gsub(/[^\d\w\-]+/, '')

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'interview_category.html')

      self.data['category'] = category
      self.data['category_safe'] = safe_category

      self.data['title'] = category.capitalize
    end
  end

  class CategoryPageGenerator < Generator

    safe true

    def generate(site)

      site.categories.keys.each do |category|
        safe_category = Iconv.new('ascii//translit','utf-8').iconv(category).gsub(/[^\d\w\-]+/, '')
        site.pages << CategoryPage.new(site, site.source, File.join('rozhovory', safe_category), category)
      end
    end
  end
end
