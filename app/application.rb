require 'pry'

class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    header = {}

    if req.path.match(/items/)
      item_to_find = req.path.split("/items/").last
      item = @@items.find {|item| item.name == item_to_find}
      if item != nil
        status = 200
        body = [item.price]
      else
        status = 400
        body = ["Item not found"]
      end
    else
      status = 404
      body =["Route not found"]
    end
    return [status, header, body]
  end

end
