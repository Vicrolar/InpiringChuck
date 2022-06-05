class ChuckController < ApplicationController

  before_action :set_locale

  def index
    @categories = request_api("https://api.chucknorris.io/jokes/categories")
  end


  def search

    type = params[:type];

    if type == "random"
      @filter = type

      queryResponse = request_api("https://api.chucknorris.io/jokes/random")
      if(queryResponse == nil)
        return
      end

      @results = Array.wrap(queryResponse);
      @total = 1

    elsif type == "category"
      category = params[:selCategory];
      @filter = category

      queryResponse = request_api("https://api.chucknorris.io/jokes/random?category=#{@filter}")
      if(queryResponse == nil)
        return
      end

      @results = Array.wrap(queryResponse);
      @total = 1

    else
      word = params[:txtWord];
      @filter = word

      queryResponse = request_api("https://api.chucknorris.io/jokes/search?query=#{@filter}");
      if(queryResponse == nil)
        return
      end
      
      @results = queryResponse["result"]
      @total = queryResponse["total"]

    end

    save_request(type, word, category, @results)
    
    to_email = params[:txtEmail]
    if(to_email.length > 0)
      RequestMailer.send_mail(to_email, type, word, category, @results).deliver_now
    end

  end


  private

  def request_api(url)
    response = Excon.get(url)
    #return nil if response.status != 200
    
    json = JSON.parse(response.body)

    if(response.status != 200)
      redirect_to action: "index", error: json["message"]#redirect to index with the error message
      return
    end

    return json

  end

  def save_request(type, word, category, results)
    request = Request.new(request_type: type, word: word, category: category) 
    request.save

    responsesArray = Array.new

    results.each do |result|
      responsesArray.push(request: request, text: result['value'])
    end
    Response.create(responsesArray)

  end

  def default_url_options
    {locale: I18n.locale}
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ?
      parsed_locale.to_sym :
      nil
  end
end
