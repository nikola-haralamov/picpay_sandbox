module Routes
  class Payments < Base
    route do |r|
      @payments = DB.new('payments')

      r.get String do |id|
        payment = @payments.get(id)

        return { error: 'Invalid ID.' } if payment.nil?

        payment.store(:id, id)
        payment
      end

      r.get do
        @payments.list
      end

      r.post do
        payment = JSON.parse(request.body.read, symbolize_names: true)
        id = SecureRandom.uuid

        return { error: 'Something was wrong.' } unless @payments.create(id, payment)

        payment.store(:id, id)
        payment
      end

      r.put String do |id|
        payment = JSON.parse(request.body.read, symbolize_names: true)

        return { error: 'Something was wrong.' } unless @payments.update(id, payment)

        payment.store(:id, id)
        payment
      end

      r.delete String do |id|
        return { error: 'Something was wrong.' } if @payments.delete(id) < 1

        {}
      end

    end
  end
end
