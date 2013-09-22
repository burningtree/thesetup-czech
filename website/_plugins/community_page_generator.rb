module Jekyll

  class CommunityPage < Page

    def initialize(site, base, dir, links)

      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'community.html')

      self.data['links'] = links
    end
  end

  class CommunityPageGenerator < Generator

    safe true

    def generate(site)
      links = {
        'personal' => [],
      }
      
      data = YAML::load_file(File.join(site.source, "..", "links.yml"))
      links['personal'] = data

      site.pages << CommunityPage.new(site, site.source, 'komunita', links)
    end
  end
end
