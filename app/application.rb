
class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_title = req.path.split("/items/").last
      puts " here is ISSSSS #{item_title}"
      if !@@items.select {|item| item.name == item_title}.empty?
      resp.write @@items.select {|item| item.name == item_title}
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

end
