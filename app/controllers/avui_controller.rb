class AvuiController < ApplicationController
  def demo1
  end

  def generate_demo1
    text1 = params[:text1]
    text2 = params[:text2]

    result = ChatGpt::Client.new.generate_text("Te voy a pasar dos textos sobre la misma noticia, quiero que me devuelvas un JSON del tipo {what: , who: , where: , when: , why:} con las 5W de la noticia. Este es el texto 1: #{text1}. Este es el texto 2: #{text2}")
    
    generated_results = JSON.parse(result)

    render json: generated_results
  end

  def demo2
  end
end
