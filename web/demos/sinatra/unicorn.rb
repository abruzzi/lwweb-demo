@dir = "/Users/twer/develop/lwwd/chapters/web/demos/sinatra/"

worker_processes 2
working_directory @dir

timeout 30

listen "#{@dir}tmp/sockets/unicorn.sock", :backlog => 64

pid "#{@dir}tmp/pids/unicorn.pid"

stderr_path "#{@dir}tmp/log/unicorn.stderr.log"
stdout_path "#{@dir}tmp/log/unicorn.stdout.log"
