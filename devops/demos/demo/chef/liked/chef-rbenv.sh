#!/bin/bash

repo="fnichol/chef-rbenv"
latest_release=$(curl -s https://api.github.com/repos/$repo/git/refs/tags \
| ruby -rjson -e '
  j = JSON.parse(STDIN.read);
  puts j.map { |t| t["ref"].split("/").last }.sort.last
')
cat >> Berksfile <<END_OF_BERKSFILE
cookbook 'rbenv',
  :git => 'git://github.com/$repo.git', :branch => '$latest_release'
END_OF_BERKSFILE
