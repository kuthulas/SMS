json.array!(@students) do |student|
  json.extract! student, :id, :uin, :fname, :lname, :card, :email
  json.url student_url(student, format: :json)
end
