class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      price = get_price_by_name(item_name)
      if price != "400"
        resp.write "#{item_name} costs #{price}"
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end

  def get_price_by_name(item_name)
    food = @@items.find {|item| item.name ==  item_name}
    !food.nil? ? food.price : "400"
  end
end
