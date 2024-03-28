# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe SendEmailJob, type: :job do
  describe '#perform' do
    let(:action) { 'action_name' }
    let(:title) { 'email_title' }
    let(:user_email) { 'user@example.com' }

    it 'sends an email using PostMailer' do
      expect(PostMailer).to receive(:send_email).with(action, title, user_email).and_return(double(deliver_now: true))

      SendEmailJob.new.perform(action, title, user_email)
    end

    it 'delivers the email immediately' do
      allow(PostMailer).to receive_message_chain(:send_email, :deliver_now)
      SendEmailJob.new.perform(action, title, user_email)

      expect(PostMailer).to have_received(:send_email).with(action, title, user_email)
    end
  end
end
