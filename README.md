ums-rails
=========
这是一个基于rails开发的用户管理系统组件，实现了以下功能：
* 用户帐号的设置、登录、退出、密码修改，访问权限检查
* 基于rails controller和action的功能模块管理
* 权限基于角色管理，角色对应多个功能模块
* 应用日志功能，可以记录用户登录事件

## 要求
* rails 4.0.0
* will_paginate 3.0.0
* Bootstrap 3.0

## 安装
在rails应用的Gemfile中加入：
```ruby
gem 'ums'
```
或者加入最新的开发版本：
```ruby
gem 'ums', :github => 'wangfuhai2013/ums-rails'
```

然后执行：
```sh
$ bundle
$ rake ums:install:migrations
$ rake db:migrate
```
在 db/seeds.rb文件中加入：
```ruby
Ums::Engine.load_seed
```
然后执行：
```sh
$ rake db:seed
```
初始化账号为`admin`,密码`admin`

## 使用
设置应用路由，在 config/routes.rb中加入
```ruby
mount Ums::Engine =>'/ums'
```
配置访问权限检查功能,可在 app/controllers/application_controller.rb中加入
```ruby
  helper Ums::Engine.helpers
  include Ums::ApplicationHelper
  before_filter :authorize
```
配置登录后的菜单，可在 app/views/layouts/appliction.html.erb中加入
```ruby
<nav class="navbar navbar-default" role="navigation">
   <div class="collapse navbar-collapse ">
    <ul class="nav navbar-nav">
    <% if validate_permission(ums.users_path[1..-1]) %>
    <li <%= raw 'class="active"' if  params[:controller].start_with?("ums") && !action_name.match('password|profile') %> ><%= link_to "用户管理", ums.users_path %></li>
    <% end %>
      </ul>
     <ul class="nav navbar-nav pull-right">
        <li><a>当前用户:<%= session[:user_name] %></a></li>
        <li <%= raw 'class="active"' if action_name == 'password' %> ><%= link_to "修改密码", ums.users_password_path %></li>
        <li <%= raw 'class="active"' if action_name == 'profile' %>><%= link_to "修改邮箱", ums.users_profile_path %></li>
        <li><%= link_to "退出", ums.users_logout_path %></li>
    </ul>
  </div>
</nav>
<div class="container">
  <% if params[:controller].start_with?("ums") && !action_name.match('password|profile') %>
  <ul class="nav nav-pills">
    <li <%= raw 'class="active"' if controller_name == "users" %> ><%= link_to "用户管理", ums.users_path %></li>
    <li <%= raw 'class="active"' if controller_name == "roles" %> ><%= link_to "角色管理", ums.roles_path %></li>
    <li <%= raw 'class="active"' if controller_name == "functions" %> ><%= link_to "功能管理", ums.functions_path %></li>
    <li <%= raw 'class="active"' if controller_name == "logs" %> ><%= link_to "操作日志", ums.logs_path %></li>
  </ul>
  <% end %>
  <%= yield %>
</div>
```
注：如果在此文件的公共部分引用application中helper方法(ums模块中会调用到),需加前缀 main_app ,如：
```ruby
<li <%= raw 'class="active"' if  params[:controller].start_with?("cms") %> ><%= link_to "内容管理", main_app.cms_docs_path %></li>
```
登录操作可参考 [示例页面](https://github.com/wangfuhai2013/ums-rails/tree/master/public/index.html)
