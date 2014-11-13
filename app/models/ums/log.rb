class Ums::Log < ActiveRecord::Base

  def level_name
  	 name = level
     name = '错误' if self.level == 'error'
     name = '信息' if self.level == 'info'
     name
  end
  def self.level_options
     [['错误', 'error'], ['信息', 'info']]
  end

  def log_type_name
  	 name = log_type
     name = '登录' if self.log_type == 'login'
     name = '退出' if self.log_type == 'logout'
     name = '新建' if self.log_type == 'create'
     name = '修改' if self.log_type == 'update'
     name = '删除' if self.log_type == 'destroy'     
     name
  end
  def self.log_type_options
     [['登录', 'login'], ['退出', 'logout'], ['新建', 'create'], ['修改', 'update'],
      ['删除', 'destroy']]
  end
end
