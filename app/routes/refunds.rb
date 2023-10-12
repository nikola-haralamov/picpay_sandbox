module Routes
  class Refunds < Base
    route do |r|
      @refunds = DB.new('refunds')

      r.get String do |id|
        refund = @refunds.get(id)

        return { error: 'Invalid ID.' } if refund.nil?

        refund.store(:id, id)
        refund
      end

      r.get do
        @refunds.list
      end

      r.post do
        refund = JSON.parse(request.body.read, symbolize_names: true)
        id = SecureRandom.uuid

        return { error: 'Something was wrong.' } unless @refunds.create(id, refund)

        refund.store(:id, id)
        refund
      end

      r.put String do |id|
        refund = JSON.parse(request.body.read, symbolize_names: true)

        return { error: 'Something was wrong.' } unless @refunds.update(id, refund)

        refund.store(:id, id)
        refund
      end

      r.delete String do |id|
        return { error: 'Something was wrong.' } if @refunds.delete(id) < 1

        {}
      end

    end
  end
end
