# frozen_string_literal: true

CategoryTag.seed do |s|
  s.id = 1
  s.category_id = 1
  s.tag_id = 2
end
CategoryTag.seed do |s|
  s.id = 2
  s.category_id = 1
  s.tag_id = 3
end
CategoryTag.seed do |s|
  s.id = 3
  s.category_id = 2
  s.tag_id = 1
end
CategoryTag.seed do |s|
  s.id = 4
  s.category_id = 3
  s.tag_id = 4
end
CategoryTag.seed do |s|
  s.id = 5
  s.category_id = 4
  s.tag_id = 5
end
