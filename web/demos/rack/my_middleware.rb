class MyMiddleware
    def initialize(app)
        @app = app 
    end 

    def call(env)
        status, headers, body = @app.call(env)
        new_body = []
        new_body << "prefix..."
        new_body << body.to_s
        new_body << "...suffix"
        [status, headers, new_body]
    end 
end