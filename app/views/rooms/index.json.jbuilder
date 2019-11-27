json.array! @rooms do |room|
  json.id room.id
  json.title room.title
  json.created_at room.created_at.strftime("%Y/%m/%d %H:%M")
end
