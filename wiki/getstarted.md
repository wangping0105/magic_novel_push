### repo

```shell
git clone ssh://git@admin.vcooline.com:40022/dyne/repos/ikcrm_push.git
```

### Built VcoolineIkcrm

```shell
hazel ikcrm_push --capistrano -d= --no-bundle-install --g #and clean up
```

### extra package for system

```shell
```

### set rvm

```shell
cd vcooline_ikcrm
# sudo -i
# rvm use 2.1.1@ikcrm_push --create
# https://rvm.io/workflow/projects/
rvm --create --ruby-version use 2.1.2@ikcrm_push
rvm --create --versions-conf use 2.1.2@ikcrm_push
```

### rspec

transpec: [Transpec](https://github.com/yujinakayama/transpec) is a tool for converting your
specs to the latest RSpec syntax with static and dynamic code analysis.

init

### boot rails more fast by zeus(rails 4 use spring default)

Boot any rails app in under a second

Start the server:

```shell
zeus start
```

The server will print a list of available commands.

Run some commands in another shell:

```shell
zeus rake
zeus dbconsole
zeus server (alias: s)
zeus runner (alias: r)
zeus destroy (alias: d)
zeus console (alias: c)
zeus generate (alias: g)
zeus test (alias: rspec, testrb)
```

### state_machine vs workflow vs transitions

- [state_machine](https://github.com/pluginaweek/state_machine)
- [workflow](https://github.com/geekq/workflow)
- [transitions](https://github.com/troessner/transitions)
- [workflow_on_mongoid](http://github.com/bowsersenior/workflow_on_mongoid) (current use)

### choose and add gems

* rails, rails-i18n, rails-timeago
* jquery-rails
* coffee-rails
* capistrano, rvm-capistrano
* whenever
* resque
* show_for
* breadcrumbs
* sisyphus-rails
* gritter
* will_paginate, will_paginate_twitter_bootstrap, will_paginate_mongoid
* thin
* database_cleaner
* factory_girl_rails

### backbone-on-rails

- https://github.com/meleyal/backbone-on-rails

.ejs – embedded javascript
.jst – javascript template

- http://embeddedjs.com/
- https://github.com/visionmedia/ejs
- https://gist.github.com/monokrome/6075034
- http://stackoverflow.com/questions/14724883/i-found-myself-repeat-a-lots-of-code-when-using-backbone-js-or-other-mvc

### rails-settings

- https://github.com/ledermann/rails-settings

Ruby gem to handle settings for ActiveRecord instances by storing them as serialized Hash in a separate database table. Namespaces and defaults included.

### deploy

testing env

database: vcooline_ikcrm_testing
