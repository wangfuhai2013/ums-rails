# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
functions = Ums::Function.create([{name:"用户管理",controller:'ums'}])
role = Ums::Role.create(name:'系统管理员',functions:functions)
Ums::User.create(name: "admin",hashed_password: "4b1323850c4283da817ef95f32e0b00f2f31a4b2",
	             salt: "0.8575214227141923",login_count:0,is_enabled:true,role:role)