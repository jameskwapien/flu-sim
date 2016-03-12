class SimulationController < ApplicationController
  helper_method :java_test, :java_test_2, :download_textfile

  def show
  end

  def result
  end
  
  def java_test(url)
    @result = %x(java TestJavaApp)
    url
  end

  def java_test_2(input, url)
    @result = system "cd app/assets && java TestJavaApp '#{input}' > output.txt"
    url
  end

  def download_textfile(url)
    @content = "hello world"
    send_data @content, type: 'text', disposition: "attachment; filename=input.txt"
    url
  end


    

end
