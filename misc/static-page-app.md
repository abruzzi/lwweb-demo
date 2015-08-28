```sh
gem install middleman
```

```sh
git clone git://github.com/axyz/middleman-zurb-foundation.git ~/.middleman/zurb-foundation
```

```sh
middleman init modern-web-development --template=zurb-foundation
cd modern-web-development
bower install
bundle exec
```

1.  create repo on github
2.  initialize current folder to git repo, and add the remote
3.  push to remote

```sh
be rake build
be rake publish
```

### 前后端的分离

#### 反向代理
#### Moco框架
#### 前后分离



➜  rspec git:(master) ✗ rspec --color
F

Failures:

  1) User .name
     Failure/Error: user = User.new("Juntao", "Qiu")
     NameError:
       uninitialized constant User
     # ./spec/user_spec.rb:5:in `block (2 levels) in <top (required)>'

Finished in 0.00038 seconds (files took 0.12543 seconds to load)
1 example, 1 failure

Failed examples:

rspec ./spec/user_spec.rb:4 # User .name
➜  rspec git:(master) ✗ tree
.
├── Gemfile
├── lib
│   └── user.rb
└── spec
    └── user_spec.rb

2 directories, 3 files


RSpec是Ruby下的单元测试的工具，RSpec提供BDD的DSL，使得其编写的代码可读性很高。RSpec可以很好的和其他测试工具如Capybara的集成，这样就可以很轻松的编写出端到端的测试。

RSpec是一个gem，因此安装非常容易，可以安装在系统的全局环境中：

gem install rspec

或者安装到指定的项目中，在Gemfile中加入

gem 'rspec'

然后运行bundle install即可。

RSpec的可执行程序为rspec，按照惯例，rspec会在当前目录下查找specs目录。specs中的文件需要以 _spec.rb 结尾。

我们来看一个小例子，一个用户模型的测试：

require File.dirname(__FILE__) + '/../lib/user.rb'

describe "User" do
    it "converts Western name to Chinese name" do
        user = User.new("Juntao", "Qiu")
        expect(user.name).to eq "QIU Juntao"
    end
end

每一个测试都会放到一个测试套件中，RSpec使用describe来表示一个套件。describe接受一个描述性信息和一个块（block）。而具体的每个测试用例定义在it的块中。it也接受一个描述信息和一个块（block），块中的代码即为具体的测试。

比如我们上述的这个测试中，创建一个新的用户，并期望user.name返回的是讲姓转化为大写的形式。


上述的测试代码对应的实现非常简单：

class User
    def initialize first, last
        @first = first
        @last = last
    end

    def name
        "#{@last.upcase} #{@first}"
    end
end


运行RSpec非常简单，只需要：

$ rspec 
.

Finished in 0.00144 seconds (files took 0.10848 seconds to load)
1 example, 0 failures

运行结果中的点（.）表示一个测试用例，然后RSpec会报告时间和总的情况（运行了多少个用例，失败了多少个）。

默认的rspec没有颜色，当失败的时候结果可能不够直观，因此可以带上参数：

$ rspec --color

[image]

如果需要更加详细的报告，比如都运行了那些用例，可以使用：

$ rspec -fd --color

User
  converts Western name to Chinese name

Finished in 0.00078 seconds (files took 0.08135 seconds to load)
1 example, 0 failures

这里的fd表示输出的格式（format）为文档（documentation）。除此之外，还有json格式，html格式的输出。

对应的，如果有错误，rspec会详细的报告错误的位置，比如文件，行号，错误类型等等，比如我们新添加了一个测试，但是没有编写对应的测试：

require File.dirname(__FILE__) + '/../lib/user.rb'

describe "User" do
    it "converts Western name to Chinese name" do
        user = User.new("Juntao", "Qiu")
        expect(user.name).to eq "QIU Juntao"
    end

    it "says hi when greeting" do
        user = User.new("Juntao", "Qiu")
        greeting = user.greeting
        expect(greeting).to eq "Hello, My name is QIU Juntao"
    end
end

运行rspec，会得到这样的错误：

[image]

如果编写更多的测试，我们会发现每次都需要创建一个新的User实例，代码会有冗余，RSpec提供了更高级的DSL来简化这个过程，并可以使得测试代码更加易读：

require File.dirname(__FILE__) + '/../lib/user.rb'

describe "User" do

    subject(:user) {User.new("Juntao", "Qiu")}

    it "converts Western name to Chinese name" do
        expect(user.name).to eq "QIU Juntao"
    end

    it "says hi when greeting" do
        expect(user.greeting).to eq "Hello, My name is QIU Juntao"
    end
end


使用subject，可以将初始化的工作提取出来，放到更外层。这样，每个测试用例都可以访问到这个实例。当然，这个变量在每个测试中都是重新初始化的，比如我们在user.rb里加入以下的打印信息：


class User
    def initialize first, last
        @first = first
        @last = last
        p "ininialize User class"
    end
end

然后运行测试：

rspec -fd --color

User
"ininialize User class"
  converts Western name to Chinese name
"ininialize User class"
  says hi when greeting

Finished in 0.00107 seconds (files took 0.07983 seconds to load)
2 examples, 0 failures

可以看到，每运行一个it（测试用例），User都会被创建一次，这样也保证了每个测试之间互不干扰。

我们将这个例子扩展，看看如何使用RSpec来测试Sinatra应用。首先我们需要安装几个gem来支持：

source "http://ruby.taobao.org"

gem 'sinatra'

group :test do
    gem 'rack-test'
end


然后，假设我们的sinatra应用会放在app.rb中，那么对应的测试需要编写为：

require File.dirname(__FILE__) + '/../app.rb'
require 'rack/test'

set :environment, :test

def app
    Sinatra::Application
end

describe "User service" do
    include Rack::Test::Methods

    it "should load the user page" do
        get '/'
        expect(last_response).to be_ok
    end

    it "should create new user" do
        post '/', params = {:first => "Mansi", :last => "Sun"}
        expect(last_response).to be_ok
        expect(last_response.body).to eq "Hello, My name is SUN Mansi"
    end
end

首先，我们require了app.rb文件，这样我们就将这个sinatra的应用引入进来了，然后设置:enviroment为测试。Rack::Test::Methods提供了诸如get，post之类的方法，用来发送请求（当然，只是模拟发送，不需要真正启动服务器）。

然后对于测试代码，我们可以模拟用户的行为，比如第一个测试：

it "should load the user page" do
    get '/'
    expect(last_response).to be_ok
end

请求了根路径，并预期状态码为200。对于第二个场景，我们发送了一组参数到服务器端，并期望服务器返回一句问候："Hello, My name is SUN Mansi"。因此对应的服务器实现为：

require 'sinatra'
require './lib/user'

get '/' do
    juntao = User.new("juntao", "qiu")
    juntao.greeting
end

post '/' do
    user = User.new(params[:first], params[:last])
    user.greeting
end


Simon Stewart
