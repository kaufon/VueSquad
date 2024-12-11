module Users
  class ListUserService
    def initialize(users)
      @users = users
    end

    def execute
      @users
    end
  end
end
