module APIv2
  class Currencies < Grape::API

    desc 'Retrieve currencies list'
    get "/currencies" do
      Currency.all.map { |currency| currency.code }
    end

  end
end
