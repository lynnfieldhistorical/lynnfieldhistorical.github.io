# ReadMe for LHC Site

## Frontmatter Template for Blog Posts

```
---
layout: post
title: "Post Title"
date: 2020-11-12
tags:
    - "tag1"
    - "tag2"
    - "tag3"
    - "tag4"
image: "assets/images/imagename.jpg"
---
```

## Things I Need to Fix

- Alphabetical list of tags
- Connecting to WorPress domain PROPERLY

## Things I Need to Document

- Generating pages for tags: `generate_tag_pages.rb`  
- Generating tags for blog posts and projects: `generate_tags.rb`  
- Site configuration: `config.yml`  

## Little Personal Reminders

- Before committing anything, run `git config user.name` to confirm the proper identity for the Git account.
- Always run `ruby generate_tags.rb` and `ruby generate_tag_pages.rb` to update site tags after creating or editing posts/projects. 


