# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
functions = Ums::Function.create([{name:"用户管理",controller:'ums'}])
role = Ums::Role.create(name:'系统管理员',functions:functions)
#初始账号:admin 密码:admin
Ums::User.create(account: "admin",name: "系统管理员",hashed_password: "4ef71e780c4381a5c6bae8cad6c88b356f526128ae19d2f1cfacfc4f05c6e14f",
	             salt: "0.8575214227141923",login_count:0,is_enabled:true,role:role)
