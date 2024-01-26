# RAILS TEMPLATE

## Development environment

### Create a project

Get the latest of rails:

```bash
gem update rails
rails new app_name -m https://raw.githubusercontent.com/longtrieuteam/rails_template/master/template.rb
```

Or choose a version

```bash
rails {version} new app_name -m https://raw.githubusercontent.com/longtrieuteam/rails_template/master/template.rb
```

Or add to `.zshrc`

```bash
export RAILS_TEMPLATE=https://raw.githubusercontent.com/longtrieuteam/rails_template/master/template.rb
```

then run

```bash
rails new app_name -m $RAILS_TEMPLATE
```

### Run rspec

```bash
cd app_name
rspec
```
