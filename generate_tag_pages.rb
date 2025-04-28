require 'yaml'
require 'fileutils'
require 'date'

# Directory where tag pages will be created
TAGS_DIR = 'tags'

# Read all posts
posts = Dir.glob('_posts/**/*.{md,markdown}').select { |f| File.file?(f) }

# Extract post metadata including tags and titles
post_metadata = posts.map do |post_path|
  content = File.read(post_path)
  if content =~ /\A---(.+?)---/m
    front_matter = YAML.safe_load($1, permitted_classes: [Date])
    {
      path: post_path,
      title: front_matter['title'] || 'Untitled',
      tags: front_matter['tags'] || []
    }
  else
    { path: post_path, title: 'Untitled', tags: [] }
  end
end

# Extract unique tags
all_tags = post_metadata.flat_map { |meta| meta[:tags] }.uniq

puts "Found tags: #{all_tags.join(', ')}"

# Create a folder and index.md for each tag
all_tags.each do |tag|
  # Normalize tag to lowercase and remove non-alphanumeric characters, keeping hyphens
  slug = tag.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

  # Create the tag folder
  tag_folder = File.join(TAGS_DIR, slug)
  FileUtils.mkdir_p(tag_folder)

  # Find posts for the current tag
  tagged_posts = post_metadata.select { |meta| meta[:tags].include?(tag) }

  # Create the index.md file for the tag
  File.open(File.join(tag_folder, 'index.md'), 'w') do |file|
    file.puts <<~MARKDOWN
      ---
      layout: tag
      tag: #{tag}
      title: Posts tagged "#{tag}"
      permalink: /tags/#{slug}/
      ---

      ## Posts tagged with "#{tag}"
    MARKDOWN

    tagged_posts.each do |post|
      post_title = post[:title]
      post_slug = File.basename(post[:path], File.extname(post[:path])).split('-', 4).last
      post_path = "/#{post_slug}/"
      file.puts "- [#{post_title}](#{post_path})"
    end
  end

  puts "Generated page for tag: #{tag} -> /tags/#{slug}/index.md"
end