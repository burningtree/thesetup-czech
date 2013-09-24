require 'yaml'
require 'fileutils'

def read_with_yaml(path)
  contents = File.read(path)
    
  if parts = contents.match(/^(-{3}\n.*?\n?)^(-{3}*$\n?)/m)
    metadata = YAML::load(parts[1])
    contents = parts.post_match.strip!
  else
    metadata = {}
  end

  [metadata, contents]
end


# interate over interviews
Dir.glob(File.join('data', 'interviews', "**", "interview.md")) do |path|

  puts "Processing interview '#{path}'"
  interview = read_with_yaml(path)

  slug_expl = File.dirname(path).split('/')[-1].split('.')
  slug = slug_expl.slice(0)+'-'+slug_expl.drop(1).join('-')

  # load interview
  post_data = {
    'layout' => 'interview',
    'categories' => interview[0]['categories'],
    'title' => interview[0]['name'],
    'summary' => interview[0]['summary'],
    'slug' => slug_expl.drop(1).join('-'),
  }

  postfile = File.join('website', '_posts', slug+'.markdown')

  # write post
  File.open(postfile, 'w+') do |f|
    f.write YAML.dump(post_data)
    f.write "---\n\n"
    f.write interview[1]
  end

  # copy photo
  portrait_source = File.join(File.dirname(path), 'portrait.jpg')
  portrait_target = File.join('website', 'images', 'portraits', post_data['slug']+'.jpg')

  puts "Coping portrait: #{portrait_source} => #{portrait_target}"
  FileUtils.copy(portrait_source, portrait_target)

end
