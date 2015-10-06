json.array!(@friends) do |friend|
  json.extract! friend, :id, :user_id, :user_id, :body
  json.url friend_url(friend, format: :json)
end
