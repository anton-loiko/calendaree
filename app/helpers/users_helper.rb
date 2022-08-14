module UsersHelper
  class UserData
    def initialize(data)
      @email = data['email']
      @name = data['name']
      @sub = data['sub']
      @avatar = data['avatar']
      @admin = data['admin']
    end

    attr_reader :email, :name, :sub, :avatar, :admin
  end

  def work_times
    [8, 7, 6, 5, 4, 3, 2, 1]
  end
end
