class AvuiController < ApplicationController
  def demo1
  end

  def generate_demo1
    text1 = params[:text1]
    text2 = params[:text2]

    result = ChatGpt::Client.new.generate_text("Te voy a pasar dos textos sobre la misma noticia, quiero que me devuelvas un JSON del tipo {what: , who: , where: , when: , why:} con las 5W de la noticia, como haría un periodista. Tiene que ser neutral y didáctico.. Este es el texto 1: #{text1}. Este es el texto 2: #{text2}")
    
    generated_results = JSON.parse(result)

    render json: generated_results
  end

  def demo2
  end

  def generate_demo2
    text = params[:term]

    link1 = Search::Client.new.find_story(text, 'rtve.es')
    link2 = Search::Client.new.find_story(text, 'efe.com')

    html1 = URI.open(link1) { |f| f.read }
    html2 = URI.open(link2) { |f| f.read }

    paragraphs1 = Nokogiri::HTML(html1).css('.artBody p')
    paragraphs2 = Nokogiri::HTML(html2).css('.entry-content p')

    story1 = paragraphs1.reduce("") {|result, p| result << "#{p.text}\n"}
    story2 = paragraphs2.reduce("") {|result, p| result << "#{p.text}\n"}

    render json: {text1: story1, link1: link1, text2: story2, link2: link2}
  end
end
