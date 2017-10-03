
require "cuba"
require "erb"
require "cuba/render"
require "tilt/erubis"

Cuba.plugin Cuba::Render

Cuba.use Rack::Static,
  root: "public",
  urls: ["/css","/js", "/fonts", "/img", "/node_modules", "/json", "/scss"]

Dir["./routes/*.rb"].each { |rb| require rb }
