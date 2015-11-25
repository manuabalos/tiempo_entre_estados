module TeeTimetablesHelper
  def set_weeks
    @weeks = [{:id => 1, :name =>"monday"},{:id => 2, :name =>"tuesday"},{:id => 3, :name =>"wednesday"},{:id => 4, :name =>"thrusday"},{:id => 5, :name =>"friday"},{:id => 6, :name =>"saturday"},{:id => 0, :name =>"sunday"}]
  end 
end
