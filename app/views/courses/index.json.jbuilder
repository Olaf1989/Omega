json.array!(@courses) do |course|
  json.extract! course, :id, :naam, :begindatum, :einddatum, :cursusduur, :students
  json.url course_url(course, format: :json)
end
