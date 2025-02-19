require 'rails_helper'

describe 'CamaleonCms::EmailHelper' do
  init_site

  describe '#send_email (old way)' do
    it 'returns empty' do
      expect(helper.send_email('test@gmail.com', 'Test Email', 'test content', 'owenperedo@gmail.com'))
        .to be_a_kind_of(Rails.version.to_i >= 7 ? ActionMailer::MailDeliveryJob : ActionMailer::DeliveryJob)
    end
  end

  describe '#send_email (new way)' do
    it 'returns empty' do
      expect(
        helper.cama_send_email('test@gmail.com', 'Test Email',
                               { content: 'test content', from: 'owenperedo@gmail.com' })
      ).to be_a_kind_of(Rails.version.to_i >= 7 ? ActionMailer::MailDeliveryJob : ActionMailer::DeliveryJob)
    end
  end
end
