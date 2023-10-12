class Payments < Base
  route do |r|
    @payments = DB.new('payments')

    r.get 'payments' do
      @payments.list
    end

    r.get 'payment', String do |id|
      payment = @payments.get(id)

      return { error: 'Invalid ID.' } if payment.nil?

      payment.store(:id, id)
      payment
    end

    r.post 'payment' do
      payment = JSON.parse(request.body.read, symbolize_names: true)
      id = SecureRandom.uuid

      return { error: 'Something was wrong.' } unless @payments.create(id, payment)

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
  end
end
