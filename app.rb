class App < Roda
  plugin :head
  plugin :json, classes: [Array, Hash], content_type: 'application/json'
  plugin :json_parser
  plugin :all_verbs

  route do |r|
    @payments = DB.new('payments')

    r.get do
      {}
    end

    r.get 'payments' do
      @payments.list
    end

    r.get 'payment', String do |id|
      @payments.get(id)
    end

    r.post 'payment', String do |id|
      payment = JSON.parse(request.body.read, symbolize_names: true)
      @payments.set(id, payment)
      payment.store(:id, id)

      payment
    end

    r.put 'payment', String do |id|
      payment = JSON.parse(request.body.read, symbolize_names: true)
      @payments.set(id, payment)
      payment.store(:id, id)

      payment
    end

    r.delete "payment", String do |id|
      @payments.delete(id)

      {}
    end
  end
end
