class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    x = req.path_info
    array = x.split("/").reject(&:empty?)
    items = array.first
    item_name = array.last
    if items == "items"
      item_obj = @@items.find {|item|
        item.name == item_name
      }
      if item_obj.nil?
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write item_obj.price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
