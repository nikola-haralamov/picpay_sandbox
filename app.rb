class App < Roda
  plugin :json, classes: [Array, Hash], content_type: 'application/json'
  plugin :json_parser
  plugin :all_verbs

  route do |r|
    # /payments
    @payments = DB.new('payments')

    r.get 'payments' do
      @payments.list
    end

    r.get 'payment', String do |id|
      payment = @payments.get(id)
      payment.store(:id, id)

      payment
    end

    r.post 'payment', String do |id|
      payment = JSON.parse(request.body.read, symbolize_names: true)

      return { error: 'Something was wrong.' } unless @payments.create(id, payment) && @payments.persist(id)

      payment.store(:id, id)
      payment
    end

    r.put 'payment', String do |id|
      payment = JSON.parse(request.body.read, symbolize_names: true)

      return { error: 'Something was wrong.' } unless @payments.update(id, payment)

      payment.store(:id, id)
      payment
    end

    r.delete "payment", String do |id|
      return { error: 'Something was wrong.' } if @payments.delete(id) < 1

      {}
    end
    #END /payments

  end
end
